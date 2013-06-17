package edu.rpi.tw.visualization.graph.layout.centrifuge;

import org.openrdf.model.Resource;
import org.openrdf.query.BindingSet;

import com.tinkerpop.blueprints.Edge;
import com.tinkerpop.blueprints.Graph;
import com.tinkerpop.blueprints.Vertex;
import com.tinkerpop.blueprints.impls.tg.TinkerGraph;

import edu.rpi.tw.data.rdf.sesame.query.impl.DefaultQuerylet;
import edu.rpi.tw.data.rdf.sesame.vocabulary.VoID;

/**
 * 
 * @param <T>
 */
public class LinksetQuerylet extends DefaultQuerylet<Graph> {

   private Graph graph = new TinkerGraph();
   
   public LinksetQuerylet() {
      super();
   }
   
   public LinksetQuerylet(Resource context) {
      super(context);
   }
   
   @Override
   public String getQueryString(Resource context) {
      
      graph = new TinkerGraph();
      
      this.addNamespace("void","tag","datafaqs");

      //                                  x        x                 x
      String select = "distinct ?linkset ?dataset ?triples ?overlap ?target";
      
      String graphPattern =
         "?dataset\n"+
         "   a datafaqs:CKANDataset;\n"+
         "   void:subset ?linkset;\n"+
         ".\n"+
         "optional{ ?dataset tag:taggedWithTag ?tag     }\n"+
         "optional{ ?dataset void:triples      ?triples }\n"+
         "\n"+
         "?linkset \n"+
         "   void:target  ?target;\n"+
         "   void:triples ?overlap;\n"+
         ".\n"+
         "?target a datafaqs:CKANDataset .\n"+
         "filter(?dataset != ?target)";
      
      String orderBy = "";

      //System.out.println(this.composeQuery(select, context, graphPattern, orderBy));
      return this.composeQuery(select, context, graphPattern, orderBy);
   }

   @Override
   public void handleBindingSet(BindingSet bindings) {
      
      // From
      Vertex dataset = graph.getVertex(bindings.getValue("dataset"));
      if( dataset == null ) {
         dataset = graph.addVertex(bindings.getValue("dataset"));
      }
      if( bindings.hasBinding("triples") ) {
         dataset.setProperty(VoID.triples.stringValue(), Long.parseLong(bindings.getValue("triples").stringValue()));
      }
      
      // To
      Vertex target = graph.getVertex(bindings.getValue("target"));
      if( target == null ) {
         target = graph.addVertex(bindings.getValue("target"));
      }
      
      // Link
      String id = bindings.getValue("linkset").stringValue();
      Edge link = graph.getEdge(id);
      if( link == null ) {
         //System.out.println("adding edge " + id + " " + dataset + " " + target + " " + bindings.getValue("overlap").stringValue());
         link = graph.addEdge(id, dataset, target, bindings.getValue("overlap").stringValue());
      }
      link.setProperty("overlap", Long.parseLong(bindings.getValue("overlap").stringValue()));
   }
   
   @Override
   public Graph get() {
      return graph;
   }
}