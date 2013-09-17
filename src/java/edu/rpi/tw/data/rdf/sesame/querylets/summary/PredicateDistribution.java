package edu.rpi.tw.data.rdf.sesame.querylets.summary;

import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import org.openrdf.model.Resource;
import org.openrdf.model.URI;
import org.openrdf.model.ValueFactory;
import org.openrdf.model.impl.ValueFactoryImpl;
import org.openrdf.model.vocabulary.OWL;
import org.openrdf.model.vocabulary.RDF;
import org.openrdf.repository.Repository;
import org.openrdf.repository.RepositoryConnection;
import org.openrdf.repository.RepositoryException;
import org.openrdf.repository.http.HTTPRepository;

import edu.rpi.tw.data.rdf.sesame.query.QueryletProcessor;
import edu.rpi.tw.data.rdf.sesame.query.impl.DefaultQuerylet;
import edu.rpi.tw.data.rdf.sesame.querylets.pipes.stops.Predicates;
import edu.rpi.tw.data.rdf.sesame.vocabulary.SIO;
import edu.rpi.tw.data.rdf.sesame.vocabulary.VSR;
import edu.rpi.tw.data.rdf.sesame.vocabulary.VoID;
import edu.rpi.tw.data.rdf.utils.pipes.Constants;
import edu.rpi.tw.string.pmm.DefaultPrefixMappings;
import edu.rpi.tw.string.pmm.PrefixMappings;

/**
 * 
 */
public class PredicateDistribution extends Distribution {
   
   /**
    * 
    * @param context
    * @param predicates a list of predicates for which to get a distribution 
    *        (can come from Predicates.getPredicatesList()).
    */
   public PredicateDistribution(Resource context, Collection<Resource> predicates) {
      super(context,predicates);
   }
   
   @Override
   public String getQueryString(Resource context) {
      
      String select       = "distinct ?s ?o";
      String graphPattern = "?s <"+focusR.stringValue()+"> ?o .";
      String orderBy      = "";
      
      return composeQuery(select, context, graphPattern, orderBy);
   }
   
   /**
    * Assert an RDF description of the given predicate distribution.
    * 
    * @param base - 
    * @param distribution - count given predicate URI.
    * @param conn - the RepositoryConnection to assert into.
    * @param reportR - the context to assert into (within the Repository).
    */
   public static String toString(HashMap<Resource,Integer> distribution) {
      
      StringBuffer string = new StringBuffer();

      PrefixMappings pmap = new DefaultPrefixMappings();

      for( Resource predicate : distribution.keySet() ) {
         int count = distribution.get(predicate);
         string.append(count + " " + pmap.bestQNameFor(predicate.stringValue())+"\n");
      }
      return string.toString();
   }

   /**
    * Assert an RDF description of the given predicate distribution.
    * 
    * @param base         - 
    * @param distribution - count given predicate URI.
    * @param conn         - the RepositoryConnection to assert into.
    * @param reportR      - the context to assert into (within the Repository).
    */
   public static void describeDistribution(URI base, HashMap<Resource,Integer> distribution,
                                           RepositoryConnection conn, Resource reportR) {
      
      PrefixMappings pmap = new DefaultPrefixMappings();
      ValueFactory vf = ValueFactoryImpl.getInstance();
      
      int bin = 0;
      for( Resource predicate : distribution.keySet() ) {
         bin++;
         
         try {
            URI predBinR = vf.createURI(base.stringValue()+"/bin/"+bin);
            conn.add(base, VoID.subset,   predBinR,  reportR);
            conn.add(base, SIO.hasMember, predicate, reportR);
            
            
            //BNode restriction = vf.createBNode();
            conn.add(predBinR,    RDF.TYPE,            VSR.Dataset,                                   reportR);
            conn.add(predBinR,    RDF.TYPE,            VSR.Bin,                                       reportR);
            conn.add(predBinR,    RDF.TYPE,            VSR.PredicateOccurrenceDataset,                reportR);
            conn.add(predBinR,    SIO.count,           vf.createLiteral(distribution.get(predicate)), reportR);
            //conn.add(predBinR,  OWL.EQUIVALENTCLASS, restriction,                                   reportR);
            conn.add(predBinR,    OWL.ONPROPERTY,      RDF.PREDICATE,                                 reportR);
            conn.add(predBinR,    OWL.HASVALUE,        predicate,                                     reportR);
            conn.commit();
            
            System.err.println("    "+pmap.bestQNameFor(predicate.stringValue()) +
                               " ( "+distribution.get(predicate)+" ) ");
         }catch (RepositoryException e) {
            e.printStackTrace();
         }
      }
   }
   
   public static final String USAGE = "PredicateDistribution {- | serverURL repositoryID [context]*}";
   /**
    * usage: PredicateDistribution {- | serverURL repositoryID [context]*}
    */
   public static void main(String[] args) {
      Repository    repository = null;
      Set<Resource> contexts   = null;
      if( args.length > 0 && "-".equalsIgnoreCase(args[0]) ) {
         repository = Constants.getPipeRepository();
         contexts   = Constants.getEnumeratedOrPipe(args,2,repository);
      }else if(args.length >= 2 ){
         String serverURL    = args[0];
         String repositoryID = args[1];
         System.out.println(serverURL+"\n"+repositoryID+"\n");
         repository = new HTTPRepository(serverURL,repositoryID);
         try {
            repository.initialize();
         } catch (RepositoryException e) {
            e.printStackTrace();
         }
         contexts = DefaultQuerylet.getContexts(args,2,repository);
      }else {
         System.err.println(USAGE);
         System.exit(1);
      }
      PrefixMappings pmap = DefaultPrefixMappings.getInstance();
      
      for( Resource context : contexts ) {
         Predicates predicatesQ = new Predicates(context);
         QueryletProcessor.processQuery(repository, predicatesQ);
         
         PredicateDistribution handler = new PredicateDistribution(context,new HashSet<Resource>(predicatesQ.get()));
         QueryletProcessor.processQueries(repository, handler);
         System.out.println(pmap.bestQNameFor(context.stringValue())+" uses predicates:");
         HashMap<Resource,Integer> distribution = handler.get();
         for( Resource predicate : distribution.keySet() ) {
            System.out.println("  "+distribution.get(predicate) + " " + pmap.bestQNameFor(predicate.stringValue()));
         }
         System.out.println();
      }
   }
}