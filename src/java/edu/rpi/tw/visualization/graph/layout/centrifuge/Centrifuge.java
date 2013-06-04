package edu.rpi.tw.visualization.graph.layout.centrifuge;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.openrdf.repository.Repository;

import com.tinkerpop.blueprints.Direction;
import com.tinkerpop.blueprints.Edge;
import com.tinkerpop.blueprints.Graph;
import com.tinkerpop.blueprints.Vertex;

import edu.rpi.tw.data.rdf.sesame.query.QueryletProcessor;
import edu.rpi.tw.data.rdf.utils.pipes.Constants;
import edu.rpi.tw.data.rdf.utils.pipes.starts.Cat;

/**
 * 
 */
public class Centrifuge {

   /*
    * 1 component if BOTH; 183 if OUT...
    */
   public static final Direction direction = Direction.BOTH;
   
   /**
    * 
    * @param args
    */
   public static void main(String args[]) {
      
      if( args.length < 1 ) {
         System.err.println("Usage: Centrifuge <filename>");
         System.exit(1);
      }
      
      String fileName = args[0];
      Repository repo = Cat.load(fileName);
      System.out.println("loaded " + Cat.size(repo) + " triples");
      LinksetQuerylet querylet = new LinksetQuerylet(Constants.PIPE_CONTEXT);
      QueryletProcessor.processQuery(repo, querylet);
      Graph graph = querylet.get();
      System.out.println(graph.toString());
      
      List<Component> components = decompose(graph);
      
      System.out.println("\n== Graph had "+components.size()+" component"+s(components.size())+" ==");
      for( int i = 0; i < components.size(); i++ ) {
         System.out.println("\n  Component "+i+" of "+ components.size()+" "+ components.get(i).describe());
      }

      graph.shutdown();
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
      
      System.out.println("\ndepth " + removalDepth);
      Set<String> paths = findComponents(graph, removalDepth, previousComponent);
      if( paths.size() > 0 ) {
         System.out.println("\\=> " + paths.size() + " component"+s(paths.size())+" at depth " + removalDepth);
      }else {
         System.out.println("(0 components)");
      }
      
      List<Component> components = new ArrayList<Component>();
      for( String path : paths ) {
         
         if( componentSize(graph, path) > 0 ) {
         
            System.out.println();
            Vertex                                                       delegate  = findDelegate(graph, path);
            Component      component = new Component(removalDepth, path, delegate, degree(delegate));
            components.add(component);
            graph.removeVertex(                                          delegate);
   
            for( Vertex vertex : graph.getVertices() ) {
               if( degree(vertex) == 0 ) {
                  System.out.println("   flung " + vertex.getId());
                  graph.removeVertex(vertex);
                  component.addLeaf(vertex);
               }
            }
         }else {
            System.err.println("path empty: " + path);
         }
      }
      for( Component component : components ) {
         List<Component> subcomponents = decompose(graph, removalDepth+1, component.getPath());
         Collections.sort(subcomponents);
         if( !subcomponents.isEmpty() ) {
            System.out.println(component.getPath() + " (" + component.getDelegate().getId() + ") has " + subcomponents.size() + " subcomponents:");
            for(Component sub : subcomponents) {
               System.out.println("  * " + sub.getPath() + " (" + sub.getDelegate().getId() + " x "+sub.getDelegateDegree()+")");
            }
            component.setPrimarySubcomponent(subcomponents.get(0));
            subcomponents.remove(0);
            component.setSecondarySubcomponent(subcomponents);
         }else {
            System.out.println(component.getPath() + " has 0 subcomponents.");
         }
      }
      return components;
   }
   
   /**
    * 
    * @param graph             - The graph within which to find connected components.
    * @param removalDepth      - the number of vertices that have been snapped from `graph` so far.
    * @param previousComponent - 
    * @return the number of components found in `graph`.
    */
   public static Set<String> findComponents(Graph graph, int removalDepth, String previousComponent) {
      int component = 0;
      for( Vertex vertex : graph.getVertices() ) {
         if( !visitedAtDepth(vertex, removalDepth) )  {
            findComponents(vertex, removalDepth, previousComponent, ++component, "");
         }
      }
      Set<String> paths = new HashSet<String>();
      for( Vertex vertex : graph.getVertices() ) {
         //System.out.println(vertex.getProperty("component") + ": " + vertex.getId() + " (with "+degree(vertex)+" connections)");
         paths.add(vertex.getProperty("component").toString());
      }
      return paths;
   }
   
   /**
    * 
    * @param vertex
    * @param removalDepth
    * @return
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
         boolean visited = vertex.getProperty("component").toString().split("\\/").length > 1+removalDepth;
         /*System.out.println("\""+vertex.getProperty("component")+"\"" + " length " + 
                                 vertex.getProperty("component").toString().split("\\d+").length + 
                            " depth " + removalDepth + " " + " ==> " + visited);*/
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
   private static void findComponents(Vertex vertex, int removalDepth, String previousComponent, int component, String indent) {
      if( null == vertex.getProperty("component") ) {
         vertex.setProperty("component", previousComponent+"/"+component);
      }else {
         String next = vertex.getProperty("component") + "/" + component;
         vertex.removeProperty("component");
         vertex.setProperty("component", next);         
      }
      System.out.println(vertex.getProperty("component") + ":  " + indent + vertex.getId());
      for( Vertex neighbor : vertex.getVertices(direction) ) {
         if( !visitedAtDepth(neighbor, removalDepth) ) {
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