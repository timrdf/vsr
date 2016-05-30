package edu.rpi.tw.data.rdf.sesame.querylets.summary.spobalance;

import java.util.Collection;
import java.util.HashMap;

import org.openrdf.model.Resource;
import org.openrdf.model.URI;
import org.openrdf.query.BindingSet;

import edu.rpi.tw.data.rdf.sesame.query.impl.DefaultQuerylet;
import edu.rpi.tw.data.rdf.sesame.query.impl.PluralContextsQuerylet;

/**
 * 
 */
public class PredicatesFromSourcesToBridges extends PluralContextsQuerylet<HashMap<Resource,Integer>> {
  
   private HashMap<Resource,Integer> distribution = null;
   
   public PredicatesFromSourcesToBridges(Resource context) {
      super(context);
   }
   
   @Override
   public String getQueryString(Collection<Resource> contexts) {
      
      distribution = new HashMap<Resource,Integer>();

      String select       = "?in";
      String graphPattern = 
                            "                         ?source ?in [ ?p ?resource ].\n"+
                            "                        filter(!isLiteral(?resource)) \n"+
                            "     optional {?none ?na ?source}                     \n"+
                            "filter (!bound(?none))                                \n";
      
      String orderBy = "";

      return composeQuery(select, contexts, graphPattern, orderBy);
   }

   @Override
   public void handleBindingSet(BindingSet bindings) {
      tally((URI) bindings.getValue("in"));
   }
   
   /**
    * 
    * @param predicate
    */
   protected void tally(URI predicate) {
      if( !distribution.containsKey(predicate) ) {
         distribution.put(predicate, 1);
      }else {
         distribution.put(predicate, distribution.get(predicate) + 1);
      }
   }

   @Override
   public HashMap<Resource,Integer> get() {
      return distribution;
   }
}