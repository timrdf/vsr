package edu.rpi.tw.visualization.graph.layout.centrifuge;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.openrdf.model.Resource;
import org.openrdf.model.URI;
import org.openrdf.model.ValueFactory;
import org.openrdf.model.impl.ValueFactoryImpl;
import org.openrdf.model.vocabulary.XMLSchema;
import org.openrdf.repository.Repository;
import org.openrdf.repository.RepositoryConnection;
import org.openrdf.repository.RepositoryException;
import org.openrdf.rio.RDFHandlerException;

import com.tinkerpop.blueprints.Direction;
import com.tinkerpop.blueprints.Edge;
import com.tinkerpop.blueprints.Graph;
import com.tinkerpop.blueprints.Vertex;

import edu.rpi.tw.data.rdf.sesame.query.QueryletProcessor;
import edu.rpi.tw.data.rdf.sesame.vocabulary.DCTerms;
import edu.rpi.tw.data.rdf.sesame.vocabulary.PROVO;
import edu.rpi.tw.data.rdf.sesame.vocabulary.VSR;
import edu.rpi.tw.data.rdf.utils.pipes.Constants;
import edu.rpi.tw.data.rdf.utils.pipes.starts.Cat;

/**
 * 
 */
public class Centrifuge {
   
   //
   // Vocabulary
   //
   protected static ValueFactory vf = ValueFactoryImpl.getInstance();
   
   public static final String   PREFIX    = "centrifuge";
   public static final String   BASE_URI  = "http://purl.org/twc/vocab/centrifuge#";
   public static final Resource Primary   = vf.createURI(BASE_URI+"Primary");
   public static final Resource Secondary = vf.createURI(BASE_URI+"Secondary");
   public static final URI      hasRoot   = vf.createURI(BASE_URI+"hasRoot");
   
   /*
    * 1 component if BOTH; 183 if OUT...
    */
   public static final Direction direction = Direction.BOTH;
   
   protected String baseURI  = null;
   protected String specimen = null;
   
   /**
    * 
    * @param baseURI
    */
   public Centrifuge(String baseURI) {
      this(baseURI, null);
   }
   
   /**
    * 
    * @param baseURI
    * @param specimen
    */
   public Centrifuge(String baseURI, String specimen) {
      this.baseURI  = baseURI+"/centrifuge";
      this.specimen = specimen;
   }
   
   /**
    * 
    * @param out - the OutputStream to print the layout information.
    */
   public void layout(OutputStream out) {
      
      Repository repo = Cat.load(specimen);
      System.err.println("loaded " + Cat.size(repo) + " triples from " + specimen);
      layout(repo, Constants.PIPE_CONTEXT, Centrifuge.Primary); // Just need some URI...

      RepositoryConnection conn = null;
      try {
         conn = repo.getConnection();
         conn.export(Constants.handlerForFileExtension("ttl", out), Centrifuge.Primary);
      } catch (RepositoryException e) {
         e.printStackTrace();
      } catch (RDFHandlerException e) {
         e.printStackTrace();
      } finally {
         if( conn != null ) {
            try {
               conn.close();
            } catch (RepositoryException e) {
               e.printStackTrace();
            }
         }
      }
   }
   
   /**
    * 
    * @param specimenRepo    - A Repository to write the layout information to
    * @param reportR - The context / named graph to write into repo.
    */
   public void layout(Repository specimenRepo, Resource specimenNG, Resource reportR) {
      
      LinksetQuerylet querylet = new LinksetQuerylet(specimenNG);
      QueryletProcessor.processQuery(specimenRepo, querylet);
      Graph graph = querylet.get();
      
      List<Component> components = decompose(graph);
      
      RepositoryConnection conn = null;
      
      try {
         conn = specimenRepo.getConnection();
         conn.setNamespace("xsd",        XMLSchema.NAMESPACE);
         conn.setNamespace(PROVO.PREFIX,     PROVO.BASE_URI);
         conn.setNamespace("vsr",              VSR.BASE_URI);
         conn.setNamespace("dcterms",      DCTerms.BASE_URI);
         conn.setNamespace(PREFIX,                 BASE_URI);
         
         for( int i = 0; i < components.size(); i++ ) {
            System.err.println("\nComponent "+(i+1)+" of "+ components.size() + ":");
            components.get(i).describe(baseURI, conn, reportR, System.err);
         }
      } catch (RepositoryException e) {
         e.printStackTrace();
      } finally {
         if( conn != null ) {
            try {
               conn.close();
            } catch (RepositoryException e) {
               e.printStackTrace();
            }
         }
      }
      
      graph.shutdown();
   }
   
   public static final String USAGE = "Usage: Centrifuge [--baseURI <base-uri>] <filename>";
   
   /**
    * 
    * @param args
    */
   public static void main(String args[]) {
      
      if( args.length < 1 ) {
         System.err.println(USAGE);
         System.exit(1);
      }
      
      String baseURI = "http://eg.org";
      int arg = 0;
      if( "--baseURI".equals(args[arg]) ) {
         baseURI = args[arg+1];
         arg += 2;
      }
      
      if( args.length < 1+arg ) {
         System.err.println(USAGE);
         System.exit(1);
      }
      
      String fileName = args[arg];
      
//      try {
//         // TODO: argument for output file.
//         FileOutputStream fos = new FileOutputStream(new File(fileName+".cent.ttl"), false);
//      } catch (FileNotFoundException e) {
//         e.printStackTrace();
//      }

      Centrifuge cent = new Centrifuge(baseURI, fileName);
      cent.layout(System.out);
   }
   
   /**
    * 
    * @param graph - The graph to decompose (NOTE: this graph will be deconstructed).
    * @return
    */
   public static List<Component> decompose(Graph graph) {
      return decompose(graph, 0, "component");
   }
   
   /**
    * 
    * @param graph             - The graph to decompose (NOTE: this graph will be deconstructed).
    * @param removalDepth      - 
    * @param previousComponent - 
    * @return the main component line
    */
   public static List<Component> decompose(Graph graph, int removalDepth, String previousComponent) {
      
      System.err.println("\n\\/" + removalDepth + " " + graph + " \"" + previousComponent +"\"");
      Set<String> paths = findComponents(graph, removalDepth, previousComponent);                   // Updates vertices' "component" attribute e.g. component/1/1/2
      if( paths.size() > 0 ) {                                                                      // The set of unique "component" attribute values
         System.err.println("\\=> " + paths.size() + " component"+s(paths.size())+" at depth " + removalDepth + " " + previousComponent + " (" + graph + ")");
      }else {
         //System.err.println("(0 components) "+graph);
         System.err.println("---"); // This happens when the component was nothing but a delegate and {cling-ons}.
      }
      
      List<Component> components = new ArrayList<Component>();
      for( String path : paths ) {
         if( !path.startsWith(previousComponent) ) {
            System.err.println("component "+ path +" is not the current focus (\""+ previousComponent +"\")");
         }else if( componentSize(graph, path) > 0 ) {               // The count of nodes with the "component" attribute value
            System.err.println();
            Vertex                                                       delegate = findDelegate(graph, path);
            Component      component = new Component(removalDepth, path, delegate, degree(delegate));
            components.add(component);
            graph.removeVertex(                                          delegate);                 // Graph \minus delegate
   
            int flung = 0;
            for( Vertex vertex : graph.getVertices() ) {
               if( degree(vertex) == 0 ) {
                  System.err.println("   flung " + vertex.getId() + " (" + vertex.getProperty("component")+")");
                  graph.removeVertex(vertex);                                                       // Graph \minus {cling-ons}
                  component.addLeaf(vertex);
                  flung++;
               }
            }
            System.err.println("#   ("+flung+" total)");
         }else {
            System.err.println("component " + path + " is empty");
         }
      }                                         // delegate and cling-on vertices already removed.
      for( Component component : components ) { // given component's delegate, depth, path, and cling-ons...
         // RECURSIVE CALL to this method. =====================================================\
         List<Component> subcomponents = decompose(graph, removalDepth+1, component.getPath());  // RECURSIVE CALL to this method.
         // RECURSIVE CALL to this method. =====================================================/
         Collections.sort(subcomponents);
         System.err.println("^" + removalDepth +", "+ subcomponents.size() + " subcomponent"+s(subcomponents.size())+" of " + component.getPath() + " (" + component.getDelegate().getId() + ") "+graph);
         if( !subcomponents.isEmpty() ) {
            String bullet = "*";
            for(Component sub : subcomponents) {
               System.err.println("  "+bullet+" " + sub.getPath() + " (" + sub.getDelegate().getId() + " x "+sub.getDelegateDegree()+")");
               bullet="+";
            }
            component.setPrimarySubcomponent(subcomponents.get(0));
            subcomponents.remove(0);
            component.setSecondarySubcomponent(subcomponents);
         }
      }
      return components;
   }
   
   /**
    * 
    * @param graph             - The graph within which to find connected components.
    * @param removalDepth      - the number of vertices that have been snapped from `graph` so far.
    * @param previousComponent - 
    * 
    * @return the paths identifying the components found in `graph`.
    */
   public static Set<String> findComponents(Graph graph, int removalDepth, String previousComponent) {
      int component = 0;
      for( Vertex vertex : graph.getVertices() ) {
         /* 
          * NOT visited at depth 0  <==  vertex."component" = ""
          *     Visited at depth 0  <==  vertex."component" = "component/x"
          *     
          * NOT visited at depth 1  <==  vertex."component" = "component/x"
          *     Visited at depth 1  <==  vertex."component" = "component/x/y"
          */
         if( !visitedAtDepth(vertex, removalDepth, previousComponent) )  {
            findComponents(vertex, removalDepth, previousComponent, ++component, "");
         }
      }
      System.err.println();
      Set<String> paths = new HashSet<String>();
      for( Vertex vertex : graph.getVertices() ) {
         System.err.println(vertex.getProperty("component") + ": " + vertex.getId() + " (with "+degree(vertex)+" connections)");
         paths.add(vertex.getProperty("component").toString());
      }
      return paths;
   }
   
   /**
    * 
    * @param vertex - the vertex to evaluate
    * @param removalDepth - the depth at which to evaluate
    * @param component - component that 'vertex' must be part of
    * @return
    */
   private static boolean visitedAtDepth(Vertex vertex, int removalDepth, String component) {
      if( null == vertex.getProperty("component") ) {
         return false;
      }else if( !vertex.getProperty("component").toString().startsWith(component) ) {
         /*
          * e.g. a vertex at "component/1/1" is NOT within "component/1/3".
          * (so don't visit it yet)
          */
         return true;
      }else {
         return visitedAtDepth(vertex, removalDepth);
      }
   }
   
   /**
    * 
    * @param vertex - the vertex to evaluate
    * @param removalDepth - the depth at which to evaluate
    * 
    * @return true if the given 'vertex' was visited at 'removalDepth'
    */
   private static boolean visitedAtDepth(Vertex vertex, int removalDepth) {
      if( null == vertex.getProperty("component") ) {
         return false;
      }else {
         /*            0 1 2 3 4 5      depth: 0  1  2  3  4  5  6  7  8
          * "component/1"            1         T  -  -  ...
          * "component/1/1"          2         T  T  -  ...
          * "component/1/3"          2         T  T  -  ...
          * "component/1/3/3"        3         T  T  T  -  ...
          * "component/2/1/4/2/7/1"  6         T  T  T  T  T 
          */
         boolean visited = vertex.getProperty("component").toString().split("\\/").length - 1 > removalDepth;
         /*System.err.println("\""+vertex.getProperty("component")+"\""+
                             " length " + (vertex.getProperty("component").toString().split("\\/").length - 1) + 
                             " depth "  + removalDepth + " " + " ==> " + visited);*/
         /*
          * "component/1"     length 1 depth 0  ==> true
          * "component/1/1"   length 2 depth 1  ==> true
          * "component/1/1/1" length 3 depth 2  ==> true 
          */
         return visited;
      }
   }
   
   /**
    * 
    * @param vertex            - a member of the connected component that is currently being traversed.
    * @param removalDepth      - the number of vertices that have been snapped from `graph` so far.
    * @param previousComponent - 
    * @param component         - the label for the current connected component being traversed.
    * @param indent            - grows in recursion.
    */
   private static void findComponents(Vertex vertex, int removalDepth, String previousComponent, 
                                      int component, String indent) {
      
      if( null == vertex.getProperty("component") ) {
         vertex.setProperty("component", previousComponent+"/"+component);
      }else {
         String next = vertex.getProperty("component") + "/" + component;
         vertex.removeProperty("component");
         vertex.setProperty("component", next);         
      }
      System.err.println(vertex.getProperty("component") + ":  " + indent + vertex.getId());
      for( Vertex neighbor : vertex.getVertices(direction) ) {
         if( !visitedAtDepth(neighbor, removalDepth, previousComponent) ) {
            findComponents(neighbor, removalDepth, previousComponent, component, "  "+indent);
         }
      }
   }
   
   /**
    * Return the principle vertices in the given graph, based on some criteria.
    * Currently, the criteria is maximum degree.
    * 
    * @param graph     - a Blueprints graph with vertices having "component" properties.
    * @param component - the component for which to find a delegate.
    * @return
    */
   public static Vertex findDelegate(Graph graph, String component) {
      
      Vertex delegate = null;
      long delegateThreshold = 0;
      
      // First only by number of edges in our out.
      Set<Vertex> delegates = new HashSet<Vertex>();
      for( Vertex vertex : graph.getVertices("component", component) ) {
         long degree = degree(vertex);
         
         if( degree > delegateThreshold ) {
            delegates.clear();
         }
         if( degree >= delegateThreshold ) {
            delegates.add(vertex);
            delegate = vertex;
         }
         delegateThreshold = Math.max(degree, delegateThreshold);
      }
      
      // If tie, then by weight of edges in or out.
      if( delegates.size() > 1 ) {
         //System.err.println("WARNING: delegation not single ("+delegates.size()+") for: " + component);
         Set<Vertex> delegates2 = new HashSet<Vertex>();
         delegateThreshold = 0;
         for( Vertex vertex : delegates ) {
            long degree = weightedDegree(vertex);
            //System.err.println(vertex.getId() + " " + degree);
            
            if( degree > delegateThreshold ) {
               delegates2.clear();
            }
            if( degree >= delegateThreshold ) {
               delegates2.add(vertex);
               delegate = vertex;
            }
            delegateThreshold = Math.max(degree, delegateThreshold);
         }

         // If tie, then by weight of edges in or out weighted by the size of the neighbor.
         if( delegates2.size() > 1 ) {
            //System.err.println("WARNING: delegation2 not single ("+delegates2.size()+") for: " + component);
            Set<Vertex> delegates3 = new HashSet<Vertex>();
            delegateThreshold = 0;
            for( Vertex vertex : delegates ) {
               long degree = weightedWeightedDegree(vertex);
               //System.err.println(vertex.getId() + " " + degree);
               
               if( degree > delegateThreshold ) {
                  delegates3.clear();
               }
               if( degree >= delegateThreshold ) {
                  delegates3.add(vertex);
                  delegate = vertex;
               }
               delegateThreshold = Math.max(degree, delegateThreshold);
            }
            if( delegates3.size() > 1 ) {
               System.err.println("WARNING: delegation3 not single ("+delegates.size()+") for: " + component);
            }
         }
      }
      return delegate;
   }
   
   /**
    * 
    * @param vertex
    * @return the degree of the given vertex.
    */
   public static int degree(Vertex vertex) {
      int degree = 0;
      for( Edge e : vertex.getEdges(direction) ) {degree++;}
      return degree;
   }
   
   /**
    * 
    * @param vertex
    * @return the degree of the given vertex.
    */
   public static long weightedDegree(Vertex vertex) {
      long degree = 0;
      for( Edge e : vertex.getEdges(direction) ) {
         degree += (Long) e.getProperty("overlap");
      }
      return degree;
   }
   
   /**
    * 
    * @param vertex
    * @return the degree of the given vertex.
    */
   public static long weightedWeightedDegree(Vertex vertex) {
      long degree = 0;
      for( Edge e : vertex.getEdges(direction) ) {
         long eWeight = (Long) e.getProperty("overlap");
         Vertex neighbor = e.getVertex(Direction.IN);
         long nWeight = neighbor.getProperty("triples") == null ? 1 : (Long) neighbor.getProperty("triples");
         //System.err.println("WWD: " + vertex.getId() + " " + eWeight + " " + neighbor.getId() + " " + nWeight);
         degree +=  eWeight * nWeight;
      }
      return degree;
   }
   
   /**
    * 
    * @param graph
    * @param component
    * @return
    */
   public static long componentSize(Graph graph, String component) {
      long count = 0;
      for( Vertex v : graph.getVertices("component", component) ) {
         count++;
      }
      return count;
   }
   
   private static String s(int size) {
      return size == 0 || size > 1 ? "s" : "";
   }
}