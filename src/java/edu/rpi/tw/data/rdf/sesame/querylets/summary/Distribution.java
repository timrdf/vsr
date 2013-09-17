package edu.rpi.tw.data.rdf.sesame.querylets.summary;

import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import org.openrdf.model.Resource;
import org.openrdf.query.BindingSet;
import org.openrdf.repository.Repository;
import org.openrdf.repository.RepositoryException;
import org.openrdf.repository.http.HTTPRepository;

import edu.rpi.tw.data.rdf.sesame.query.QueryletProcessor;
import edu.rpi.tw.data.rdf.sesame.query.impl.DefaultQuerylet;
import edu.rpi.tw.data.rdf.sesame.query.impl.DefaultSPOIterableQuerylet;
import edu.rpi.tw.data.rdf.sesame.query.returning.QueryletReturning;
import edu.rpi.tw.data.rdf.sesame.querylets.pipes.stops.Predicates;
import edu.rpi.tw.data.rdf.utils.pipes.Constants;
import edu.rpi.tw.string.pmm.DefaultPrefixMappings;
import edu.rpi.tw.string.pmm.PrefixMappings;

/**
 * 
 */
public abstract class Distribution extends    DefaultSPOIterableQuerylet
								           implements QueryletReturning<HashMap<Resource,Integer>> {

   private   Iterator<Resource>        focusIter;      // The foci that still need a frequency count.
   protected Resource                  focusR;         // The next focusR to query
   private   HashMap<Resource,Integer> distribution;   // The saved frequency counts.
   private   boolean                   trustEndCount = true;
   
   /**
    * 
    * @param context
    * @param foci a list of predicates for which to get a distribution 
    *        (can come from Predicates.getPredicatesList()).
    */
   public Distribution(Resource context, Collection<Resource> foci) {
      super(context);
      this.focusIter    = foci.iterator();
      this.distribution = new HashMap<Resource,Integer>();
   }

   // TODO: constructor with just context. - but can it be done?

   @Override
   public boolean hasNext() {
      return focusIter.hasNext();
   }
   
   @Override
   public void advance() {
      focusR = focusIter.next();
   }

   @Override
   public String getType() {
      return focusR.stringValue();
   }

   @Override
   public void handleBindingSet(BindingSet bindingSet) {
      if( !trustEndCount ) {
         if( !distribution.containsKey(focusR) ) {
            distribution.put(focusR, 0);
         }
         distribution.put(focusR, distribution.get(focusR) + 1);
      }
   }
   
   @Override
   public void finish(int numResults) {
      if( trustEndCount ) distribution.put(focusR, numResults);
   }
   
   /**
    * @return the predicates and their occurrence count.
    */
   public HashMap<Resource,Integer> get() {
      return distribution;
   }
   
   public static final String USAGE = "Distribution {- | serverURL repositoryID [context]*}";
   /**
    * usage: Distribution {- | serverURL repositoryID [context]*}
    */
   public static void main(String[] args) {
      
      
      
      // TODO: process both predicates and classes.
      
      
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
