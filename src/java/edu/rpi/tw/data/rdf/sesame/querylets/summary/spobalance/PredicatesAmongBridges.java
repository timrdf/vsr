package edu.rpi.tw.data.rdf.sesame.querylets.summary.spobalance;

import java.util.Collection;

import org.openrdf.model.Resource;
import org.openrdf.model.URI;
import org.openrdf.query.BindingSet;

/**
 * 
 */
public class PredicatesAmongBridges extends PredicatesFromSourcesToBridges {

   public PredicatesAmongBridges(Resource context) {
      super(context);
   }
   
   @Override
   public String getQueryString(Collection<Resource> context) {
      
      super.getQueryString(context);

      String select       = "distinct ?bridge ?among ?bridge2";
      String graphPattern = "   [] ?in ?bridge .                      \n"+
                            "          ?bridge ?among ?bridge2 .      \n"+
                            "                         ?bridge2 ?p ?uri . filter(isURI(?uri)) \n";
      String orderBy = "";

      return composeQuery(select, context, graphPattern, orderBy);
   }

   @Override
   public void handleBindingSet(BindingSet bindings) {
      tally((URI) bindings.getValue("among"));
   }
}