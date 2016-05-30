package edu.rpi.tw.visualization.graph.layout.centrifuge;

import java.io.PrintStream;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import org.openrdf.model.Resource;
import org.openrdf.model.ValueFactory;
import org.openrdf.model.impl.ValueFactoryImpl;
import org.openrdf.repository.RepositoryConnection;
import org.openrdf.repository.RepositoryException;

import com.tinkerpop.blueprints.Vertex;

import edu.rpi.tw.data.rdf.sesame.vocabulary.DCTerms;
import edu.rpi.tw.data.rdf.sesame.vocabulary.PROVO;
import edu.rpi.tw.data.rdf.sesame.vocabulary.RDF;
import edu.rpi.tw.data.rdf.sesame.vocabulary.VSR;

/**
 * 
 */
public class Component implements Comparable<Component> {
   
   private int             removalDepth;   // 0
   private String          path;           // component/1
   
   private Vertex          delegate;       // http:...dbpedia
   private int             delegateDegree; // 
   
   private Component          primarySubcomponent;                               // {component/1/3}

   private HashSet<Component> secondarySubcomponents = new HashSet<Component>(); // {component/1/1}
                                                                                 // {component/1/5}
   private HashSet<Component> subs = null; // Union of primary and secondary.
   
   private HashSet<Vertex> leafs = new HashSet<Vertex>(); // http:...linked-cruchbase,
                                                          // http:...data-cnr-it
                                                          // ...
   protected static ValueFactory vf = ValueFactoryImpl.getInstance();
   
   /**
    * 
    * @param path
    */
   public Component(int removalDepth, String path, Vertex delegate, int delegateDegree) {
      this.removalDepth   = removalDepth;
      this.path           = path;
      this.delegate       = delegate;
      this.delegateDegree = delegateDegree;
      
      System.err.println("Snapping " + delegate.getProperty("component") + 
            " delegate " + delegate.getId().toString() + 
            " (with "    + delegateDegree + " connections)" + 
            " at depth " + removalDepth);
   }
   
   public String getPath() {
      return this.path;
   }
   
   public int getRemovalDepth() {
      return this.removalDepth;
   }
   
   public Vertex getDelegate() {
      return this.delegate;
   }
   
   public long getDelegateDegree() {
      return this.delegateDegree;
   }
   
   public void setPrimarySubcomponent(Component sub) {
      if( null != sub && null != sub.getPath() && null != sub.getDelegate() ) {
         this.primarySubcomponent = sub;
      }
      //System.err.println(this.getPath()+"("+this.getDelegate().getId()+")'s *primary* subcomponent: "+sub.getPath()+"("+sub.getDelegate().getId()+")");
   }
   
   public void setSecondarySubcomponent(Collection<Component> subs) {
      for( Component sub : subs ) {
         if( null != sub && null != sub.getPath() && null != sub.getDelegate() ) {
            this.secondarySubcomponents.add(sub);
         }
         //System.err.println(this.getPath()+"("+this.getDelegate().getId()+")'s secondary subcomponent: "+sub.getPath()+"("+sub.getDelegate().getId()+")");
      }
   }
   
   //
   //
   //
   
   public Set<Vertex> getLeafs() {
      return this.leafs;
   }
   
   /**
    * 
    * @return both the primary and secondary components (without a distinction).
    */
   public Set<Component> getSubcomponents() {
      if( subs == null ) {
         subs = new HashSet<Component>(secondarySubcomponents);
         if( null != this.primarySubcomponent ) {
            subs.add(this.primarySubcomponent);
         }
      }
      return subs;
   }
   
   /**
    * 
    * @return
    */
   public Component getPrimarySubcomponent() {
      return this.primarySubcomponent;
   }
   
   /**
    * 
    * @return
    */
   public Set<Component> getSecondarySubcomponents() {
      return this.secondarySubcomponents;
   }
   
   
   /**
    * 
    * @param id
    * @return
    */
   public int addLeaf(Vertex id) {
      this.leafs.add(id);
      return leafs.size();
   }

   @Override
   public int compareTo(Component o) {
      return o.delegateDegree - this.delegateDegree;
   }
   
   /**
    * 
    * @param i
    * @param size
    * @return
    */
   public void describe(PrintStream out) {
      describe(out,"");
   }
   
   /**
    * 
    * @param out
    * @param indent
    */
   private void describe(PrintStream out, String indent) {

      out.print("\n"+
         indent+ "When "+getPath()+"'s delegate <"+getDelegate().getId()+"> was removed,\n"+
         indent+ "   it  flung  "+ getLeafs().size() + " individual nodes\n"+
         indent+ "   and caused "+getSubcomponents().size()+" isolated connected components:\n");
      
      // Primary
      if( null != getPrimarySubcomponent() ) {
         out.print(indent+"       "+getPrimarySubcomponent().getPath());
         getPrimarySubcomponent().describe(out,indent+"       ");
      }else {
         //out.println(indent+"      (no primary subcomponent) "+getPrimarySubcomponent());
      }
      
      // Secondary
      if( getSecondarySubcomponents().size() > 0 ) {
         for( Component sub : getSecondarySubcomponents() ) {
            out.print(indent+"       "+sub.getPath());
            sub.describe(out,indent+"       ");
         }
      }else {
         //out.println(indent+"      (no secondary subcomponents) "+getSubcomponents());
      }
   }
   
   /**
    * 
    * @param out
    * @param conn
    * @param root
    * @param base
    */
   public void describe(String base, RepositoryConnection conn, Resource reportR, PrintStream out) {
      describe(base, "", conn, reportR, out, null);
   }
   
   /**
    * 
    * @param base - grows with each call down.
    * @param indent -
    * @param conn - 
    * @param reportR - named graph to write into.
    * @param out - 
    * @param root - stays the same, so each node can point to its root.
    * 
    */
   private void describe(String base, String indent,
                         RepositoryConnection conn, Resource reportR, PrintStream out, 
                         Resource root) {

      out.print("\n"+
         indent+ "When "+getPath()+"'s delegate <"+getDelegate().getId()+"> was removed,\n"+
         indent+ "   it  flung  "+ getLeafs().size() + " individual nodes\n"+
         indent+ "   and caused "+getSubcomponents().size()+" isolated connected components:\n");

      Resource component = vf.createURI(base+"/"+getPath());
      try {
         conn.add(component, RDF.a, PROVO.Collection,                                                   reportR);
         if( this.removalDepth == 0 ) {
            conn.add(component, RDF.a, VSR.Root,                                                        reportR);
            root = component;
         }
         conn.add(component, Centrifuge.hasRoot,     root,                                              reportR);
         conn.add(component, DCTerms.identifier,     vf.createLiteral(getPath()),                       reportR);
         conn.add(component, PROVO.specializationOf, vf.createURI(this.delegate.getId().toString()),    reportR);
         conn.add(component, VSR.depth,              vf.createLiteral(this.removalDepth),               reportR);

         for( Vertex leaf : this.getLeafs() ) {
            Resource leafR = vf.createURI(leaf.getId().toString());
            conn.add(component, DCTerms.hasPart, leafR,                                                 reportR);
         }
      } catch (RepositoryException e) {
         e.printStackTrace();
      }
      
      // Primary
      if( null != getPrimarySubcomponent() ) {
         out.print(indent+"       "+getPrimarySubcomponent().getPath());
         try {
            Resource subR = vf.createURI(base+"/"+getPrimarySubcomponent().getPath());
            conn.add(component, DCTerms.hasPart, subR,                                                  reportR);
            conn.add(subR, RDF.a,              Centrifuge.Primary,                                      reportR);
            conn.add(subR, RDF.a,              PROVO.Collection,                                        reportR);
            conn.add(subR, DCTerms.identifier, vf.createLiteral(getPrimarySubcomponent().getPath()),    reportR);
         } catch (RepositoryException e) {
            e.printStackTrace();
         }
         getPrimarySubcomponent().describe(base, indent+"       ", conn, reportR, out, root);
      }else {
         //out.println(indent+"      (no primary subcomponent) "+getPrimarySubcomponent());
      }
      
      // Secondary
      if( getSecondarySubcomponents().size() > 0 ) {
         for( Component sub : getSecondarySubcomponents() ) {
            Resource subR = vf.createURI(base+"/"+sub.getPath());
            try {
               conn.add(component, DCTerms.hasPart, subR,                                               reportR);
            } catch (RepositoryException e) {
               e.printStackTrace();
            }
         }
         for( Component sub : getSecondarySubcomponents() ) {
            Resource subR = vf.createURI(base+"/"+sub.getPath());
            try {
               conn.add(subR, RDF.a,              Centrifuge.Secondary,                                 reportR);
               conn.add(subR, RDF.a,              PROVO.Collection,                                     reportR);
               conn.add(subR, DCTerms.identifier, vf.createLiteral(getPrimarySubcomponent().getPath()), reportR);
               conn.commit();
            } catch (RepositoryException e) {
               e.printStackTrace();
            }
         }

         for( Component sub : getSecondarySubcomponents() ) {
            out.print(indent+"       "+sub.getPath());
            sub.describe(base, indent+"       ", conn, reportR, out, root);
         }
      }else {
         //out.println(indent+"      (no secondary subcomponents) "+getSubcomponents());
      }
   }
}