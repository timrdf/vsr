package edu.rpi.tw.visualization.graph.layout.centrifuge;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import com.tinkerpop.blueprints.Vertex;

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
   /**
    * 
    * @param path
    */
   public Component(int removalDepth, String path, Vertex delegate, int delegateDegree) {
      this.removalDepth   = removalDepth;
      this.path           = path;
      this.delegate       = delegate;
      this.delegateDegree = delegateDegree;
      
      System.out.println("Snapping " + delegate.getProperty("component") + 
            " delegate " + delegate.getId().toString() + 
            " (with "    + delegateDegree + " connections)" + 
            " at depth " + removalDepth);
   }
   
   public String getPath() {
      return this.path;
   }
   
   public Vertex getDelegate() {
      return this.delegate;
   }
   
   public long getDelegateDegree() {
      return this.delegateDegree;
   }
   
   public void setPrimarySubcomponent(Component sub) {
      this.primarySubcomponent = sub;
      //System.out.println(this.getPath()+"("+this.getDelegate().getId()+")'s *primary* subcomponent: "+sub.getPath()+"("+sub.getDelegate().getId()+")");
   }
   
   public void setSecondarySubcomponent(Collection<Component> subs) {
      for( Component sub : subs ) {
         this.secondarySubcomponents.add(sub);
         //System.out.println(this.getPath()+"("+this.getDelegate().getId()+")'s secondary subcomponent: "+sub.getPath()+"("+sub.getDelegate().getId()+")");
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
         subs.add(this.primarySubcomponent);
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
   public String describe() {
      
      System.err.println("describing " + getDelegate().getId());
      
      String primaryDelegateDescription    = "";
      String secondaryDelegatesDescription = "";
      
      String description = 
      "is represented by delegate "+getDelegate().getId()+".\n"+
      "    It resides at "+getPath()+".\n"+
      "    When its delegate was removed, it flung "+ getLeafs().size() + " individual nodes"+
      " and caused "+getSubcomponents().size()+" isolated connected components.\n";
      
      // Primary
      if( null != getPrimarySubcomponent() ) {
         if( null != getPrimarySubcomponent().getDelegate() ) {
            description += "    Its primary subcomponent's delegate is   "+getPrimarySubcomponent().getDelegate().getId();
         }else {
            description += "    Its primary subcomponent does not have a delegate.";
         }
         primaryDelegateDescription = getPrimarySubcomponent().describe();
      }else {
         description += "    It does not have a primary subcomponent.";
      }
      
      // Secondary
      if( getSecondarySubcomponents().size() > 0 ) {
         description += "\n      secondary subcomponents' delegates are\n";
         for( Component sub : getSecondarySubcomponents() ) {
            description += "                                             "+sub.getDelegate().getId()+"\n";
         }
      }else {
         description += "\n    It does not have any secondary subcomponents.";
      }

      return description + primaryDelegateDescription + secondaryDelegatesDescription;
   }
}