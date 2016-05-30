package edu.rpi.tw.data.rdf.sesame.querylets.summary.spobalance;

import java.util.Collection;

import org.openrdf.model.Resource;
import org.openrdf.model.URI;
import org.openrdf.query.BindingSet;

/**
 * 
 */
public class PredicatesFromSourcesToSinks extends PredicatesFromSourcesToBridges {

   public PredicatesFromSourcesToSinks(Resource context) {
      super(context);
   }
   
   @Override
   public String getQueryString(Collection<Resource> context) {
     
      super.getQueryString(context);

      String select       = "distinct ?p";
      String graphPattern = "filter not exists { [] ?na ?source }                    \n"+
                            "                           ?source ?p ?sink .           \n"+
                            "                    filter(!isLiteral(?sink))           \n"+
                            "                  filter not exists { ?sink ?na ?none   \n"+
                            "                              filter(!isLiteral(?none)) \n"+
                            "                  }\n";
      String orderBy      = "";

      return composeQuery(select, context, graphPattern, orderBy);
   }
   
   @Override
   public void handleBindingSet(BindingSet bindings) {
      tally((URI) bindings.getValue("p"));
   }
}