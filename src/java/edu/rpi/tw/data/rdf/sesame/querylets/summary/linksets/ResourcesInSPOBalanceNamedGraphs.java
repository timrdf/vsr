package edu.rpi.tw.data.rdf.sesame.querylets.summary.linksets;

import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import org.openrdf.model.Resource;
import org.openrdf.model.URI;
import org.openrdf.query.BindingSet;

import edu.rpi.tw.data.rdf.sesame.query.impl.PluralContextsQuerylet;
import edu.rpi.tw.string.pmm.PrefixMappings;

/**
 * 
 */
@SuppressWarnings("rawtypes")
public class ResourcesInSPOBalanceNamedGraphs extends    PluralContextsQuerylet<HashMap<URI,Set<URI>>> {

   private HashMap<URI,Set<URI>> ring;
   
   public ResourcesInSPOBalanceNamedGraphs(Resource context, PrefixMappings pmap) {
      super(context, pmap);
   }
   
   @Override
   public String getQueryString(Collection<Resource> context) {
      
      this.ring = new HashMap<URI, Set<URI>>();
      
      addNamespace("dcat", "vsr", "sd", "prov", "void", "sio");

      String select       = "distinct ?dataset ?resource";

      String graphPattern = 
                  "   {?dataset a dcat:Dataset, vsr:SPODataset; \n"+
                  "   prov:wasDerivedFrom [ a sd:NamedGraph; sd:name ?name ] .\n"+
                  " ?dataset void:subset [ a vsr:SubjectsDataset; void:subset [ void:subset [ sio:has-member ?resource ] ] ] .}\n"+
                  " \n"+
                  "  union\n"+
                  "  \n"+
                  " {?dataset a dcat:Dataset, vsr:SPODataset; \n"+
                  "    prov:wasDerivedFrom [ a sd:NamedGraph; sd:name ?name ] .\n"+
                  " ?dataset void:subset [ a vsr:ObjectsDataset;  void:subset [ void:subset [ sio:has-member ?resource ] ] ] .} \n"+
                  "filter(isIRI(?dataset)) filter(isIRI(?resource))";

      String orderBy      = "";

      return composeQuery(select, context, graphPattern, orderBy);
   }
   
   @Override
   public void handleBindingSet(BindingSet bindings) {
      URI dataset  = (URI) bindings.getValue("dataset");
      URI resource = (URI) bindings.getValue("resource");
      if( !ring.containsKey(dataset) ) {
         ring.put(dataset, new HashSet<URI>());
      }
      ring.get(dataset).add(resource);
   }
   
   @Override
   public HashMap<URI, Set<URI>> get() {
      return ring;
   }
}