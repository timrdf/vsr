package edu.rpi.tw.data.rdf.sesame.querylets.summary.spobalance;

import org.openrdf.model.Resource;
import org.openrdf.model.URI;
import org.openrdf.query.BindingSet;

/**
 * 
 */
public class PredicatesFromBridgesToSinks extends PredicatesFromSourcesToBridges {
   
   public PredicatesFromBridgesToSinks(Resource context) {
      super(context);
   }
   
   @Override
   public String getQueryString(Resource context) {
     
      super.getQueryString(context);

      String select       = "distinct ?out ?sink";
      String graphPattern = 
                           "     [] ?in [ ?out ?sink ] .         \n"+
                           "      filter(!isLiteral(?sink))      \n"+
                           "filter not exists {?sink ?na ?none   \n"+
                           "           filter(!isLiteral(?none)) \n"+
                           "} \n";
      String orderBy = "";

      return composeQuery(select, context, graphPattern, orderBy);
   }

   @Override
   public void handleBindingSet(BindingSet bindings) {
      tally((URI) bindings.getValue("out"));
   }
}