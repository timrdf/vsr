package edu.rpi.tw.visualization.overview.summarizer;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Hashtable;

import org.openrdf.model.BNode;
import org.openrdf.model.Namespace;
import org.openrdf.model.Resource;
import org.openrdf.model.URI;
import org.openrdf.model.ValueFactory;
import org.openrdf.model.impl.ValueFactoryImpl;
import org.openrdf.model.vocabulary.OWL;
import org.openrdf.model.vocabulary.RDF;
import org.openrdf.model.vocabulary.RDFS;
import org.openrdf.repository.Repository;
import org.openrdf.repository.RepositoryConnection;
import org.openrdf.repository.RepositoryException;
import org.openrdf.repository.http.HTTPRepository;
import org.openrdf.repository.sail.SailRepository;
import org.openrdf.repository.sparql.SPARQLRepository;
import org.openrdf.rio.RDFFormat;
import org.openrdf.rio.RDFHandlerException;
import org.openrdf.rio.RDFParseException;
import org.openrdf.sail.memory.MemoryStore;
import org.openrdf.sail.nativerdf.NativeStore;

import edu.rpi.tw.data.csv.valuehandlers.DateTimeValueHandler;
import edu.rpi.tw.data.csv.valuehandlers.ResourceValueHandler;
import edu.rpi.tw.data.rdf.sesame.query.QueryletProcessor;
import edu.rpi.tw.data.rdf.sesame.query.composable.LimitOffsetQuerylet;
import edu.rpi.tw.data.rdf.sesame.query.impl.DefaultQuerylet;
import edu.rpi.tw.data.rdf.sesame.querylets.pipes.stops.Classes;
import edu.rpi.tw.data.rdf.sesame.querylets.pipes.stops.Names;
import edu.rpi.tw.data.rdf.sesame.querylets.pipes.stops.Predicates;
import edu.rpi.tw.data.rdf.sesame.querylets.pipes.stops.PredicatesFromClass;
import edu.rpi.tw.data.rdf.sesame.querylets.summary.PredicateDistribution;
import edu.rpi.tw.data.rdf.sesame.querylets.summary.spobalance.ObjectLiteralsDistributionQuerylet;
import edu.rpi.tw.data.rdf.sesame.querylets.summary.spobalance.ObjectsAsSinkQuerylet;
import edu.rpi.tw.data.rdf.sesame.querylets.summary.spobalance.PredicatesAmongBridges;
import edu.rpi.tw.data.rdf.sesame.querylets.summary.spobalance.PredicatesFromSourcesToBridges;
import edu.rpi.tw.data.rdf.sesame.querylets.summary.spobalance.PredicatesFromBridgesToSinks;
import edu.rpi.tw.data.rdf.sesame.querylets.summary.spobalance.PredicatesFromSourcesToSinks;
import edu.rpi.tw.data.rdf.sesame.querylets.summary.spobalance.SubjectsAsBridgeQuerylet;
import edu.rpi.tw.data.rdf.sesame.querylets.summary.spobalance.SubjectsAsSourceQuerylet;
import edu.rpi.tw.data.rdf.sesame.string.PrettyTurtleWriter;
import edu.rpi.tw.data.rdf.sesame.vocabulary.DCAT;
import edu.rpi.tw.data.rdf.sesame.vocabulary.PROVO;
import edu.rpi.tw.data.rdf.sesame.vocabulary.SD;
import edu.rpi.tw.data.rdf.sesame.vocabulary.SIO;
import edu.rpi.tw.data.rdf.sesame.vocabulary.VSR;
import edu.rpi.tw.data.rdf.sesame.vocabulary.VoID;
import edu.rpi.tw.data.rdf.utils.pipes.Constants;
import edu.rpi.tw.string.NameFactory;
import edu.rpi.tw.string.pmm.DefaultPrefixMappings;
import edu.rpi.tw.string.pmm.PrefixMappings;
import edu.rpi.tw.visualization.overview.summarizer.SPOBalance.BalanceType;

/**
 * The heavy lifting for summarizing a repository is RepositorySummaryQuerylet.
 * RepositorySummarizer provides the main() with appropriate usage checking, executes the 
 * RepositorySummaryQuerylet, and walks the RepositorySummaryQuerylet results to describe in 
 * RDF within the given reportURI context.
 */
public class RepositorySummarizer {

	public static String version = "2014-Jan-17";

	public static ValueFactory   vf   = ValueFactoryImpl.getInstance();
	public static PrefixMappings pmap = DefaultPrefixMappings.getInstance();

	private Resource             specimenEndpoint;
	private Repository           specimenRepository;
	private Collection<Resource> specimenContexts;
	private Resource             specimenAntecedent;
	
	private String               baseURI = "http://datafaqs.tw.rpi.edu";
	private Repository           reportRepository;
	private Resource             reportR;       
	private PrefixMappings       prefixMappings; // TODO: replace with pmap

	/**
	 * Provenance-less constructor: no SPARQL endpoint nor antecendent known.
	 * 
	 * @param specimenRepository
	 * @param specimenContexts
	 * @param reportRepository
	 * @param baseURI
	 * @param reportR
	 * @param prefixMappings
	 */
	public RepositorySummarizer(Repository           specimenRepository,
                     	       Collection<Resource> specimenContexts,
                     	       Repository           reportRepository,
                     	       String               baseURI,
                     	       Resource             reportR,
                     	       PrefixMappings       prefixMappings) {
	   
	   this(null, specimenRepository, specimenContexts, null, reportRepository, baseURI, reportR, prefixMappings);
	}

	/**
	 * 
	 * @param specimenEndpoint - if null, 'http://localhost/sparql' is used.
	 * @param specimenRepository - the graph name to analyze in 'specimenEndpoint'
	 * @param specimenContexts - 
	 * @param specimenAntecedent - any URI for something that the summary report was derived from. May be null.
	 * @param reportRepository - 
	 * @param baseURI - our data domain name, e.g. "http://datafaqs.tw.rpi.edu"
	 * @param reportR - the context / graph name to write report (within reportRepository).
	 * @param pmap - 
	 */
	public RepositorySummarizer(Resource             specimenEndpoint,
	                            Repository           specimenRepository,
      							 	 Collection<Resource> specimenContexts,
      							 	 Resource             specimenAntecedent,
      							 	 Repository           reportRepository,
      							 	 String               baseURI,
      							 	 Resource             reportR,
      								 PrefixMappings       prefixMappings) {
	   
	   this.specimenEndpoint   = specimenEndpoint;
		this.specimenRepository = specimenRepository;
		this.specimenContexts   = specimenContexts;
		this.specimenAntecedent = specimenAntecedent;
		this.reportRepository   = reportRepository;
		this.baseURI            = baseURI;
		this.reportR            = reportR;
		this.prefixMappings     = prefixMappings;
	}

	/**
	 * 
	 */
	public void summarize() {
		RepositoryConnection conn = null;
		int LIMIT = 100000;

		try {
			//conn = specimenRepository.getConnection();
		   conn = reportRepository.getConnection();
		   
			long sizeBefore = conn.size(reportR);
			System.err.println("Replacing existing report of "+sizeBefore+" triples:\n");
			//conn.export(new PrettyTurtleWriter(System.err), reportR);
			//if( reportR.stringValue().length() > 0 ) {
				try {
				   conn.clear(reportR);
				}catch (UnsupportedOperationException e) {
				   e.printStackTrace();
				}
				System.err.println("\ncleared existing report. size now "+conn.size(reportR));
			//}else {
			//	System.err.println("\ndid not clear report. size still "+conn.size(reportR));
			//}

			System.err.println("Prefix mappings for repository: ");
			System.err.println(PrettyTurtleWriter.prefixMappingsAsString(conn.getNamespaces().asList(),true));

			// We pour them all in so that we can cover as many of the predicates that we find in the 
			// data that we're analyzing.
			for( Namespace ns : pmap.getNamespaces() ) {
			   try {
			      conn.setNamespace(ns.getPrefix(), ns.getName());
			   }catch (UnsupportedOperationException e) {
			      e.printStackTrace();
			   }
			}

			System.err.println("Reporting into "+reportR);
			System.err.println(this.specimenContexts.size()+" contexts.");
			DecimalFormat df = new DecimalFormat("#,###.00");

			int c = 0;
			// For each context.
			for( Resource specimenContextR : specimenContexts ) {
				c++;
            String specimenContextL = specimenContextR != null ? specimenContextR.stringValue() : "#default";
            
				if( null != specimenContextR && specimenContextL
						.startsWith("http://healthdata.tw.rpi.edu/source/healthdata-tw-rpi-edu/dataset/spo-balance") ) {
					System.err.println("Skipping report graph: "+specimenContextR.stringValue());
					continue;
				}
				System.err.println("\n===================================================================================");
				System.err.println("Summarizing (" +c+ "/"+ specimenContexts.size() +") " + specimenContextR);

	         String nameHash = "";
	           
				URI ngR = null;
				if( specimenEndpoint != null ) {
   				String endpoint = specimenEndpoint.stringValue();
   				URI endpointR = vf.createURI(endpoint);
   				    ngR       = vf.createURI(NameFactory.getSPARQLEndpointGraphNameTiny(this.baseURI, endpoint, specimenContextL));
   				URI ngRLong   = vf.createURI(NameFactory.getSPARQLEndpointGraphName(endpoint, specimenContextL));
   				   
   				System.err.println("Canonical URI for named graph: "+ngR.stringValue());
   				
   				// <http://healthdata.tw.rpi.edu/sparql?query=PREFIX+sd%3A...>
   				//    a sd:NamedGraph;
   				//	  sd:name <http://xmlns.com/foaf/0.1>;
   				//	  prov:hadLocation <http://healthdata.tw.rpi.edu/sparql>;
   				//	.
   				conn.add(ngR, RDF.TYPE,          SD.NamedGraph,    reportR);
   				conn.add(ngR, SD.name,           specimenContextR, reportR);
   				conn.add(ngR, PROVO.hadLocation, endpointR,        reportR);
   				
               conn.add(ngR, OWL.SAMEAS,        ngRLong,          reportR);
               nameHash = "/"+NameFactory.getMD5(NameFactory.getSPARQLEndpointGraphName(endpoint,specimenContextL));
				}
				
				//NameFactory.getMD5(specimenContextR.stringValue());

				if( specimenContextR != null && !specimenContextR.equals(Constants.PIPE_CONTEXT) && nameHash == "") {
				   //nameHash = "/"+NameFactory.label2URI(specimenContextL);
				   nameHash = "/"+NameFactory.getMD5(specimenContextL);
				}
				URI spoSetR = vf.createURI(reportR.stringValue()+nameHash+"/spo");
				URI sSetR   = vf.createURI(reportR.stringValue()+nameHash+"/spo/s");
				URI pSetR   = vf.createURI(reportR.stringValue()+nameHash+"/spo/p");
				URI oSetR   = vf.createURI(reportR.stringValue()+nameHash+"/spo/o");
				
				conn.add(reportR, VoID.subset,          spoSetR,        reportR);
				if( ngR != null ) {
				   conn.add(spoSetR, PROVO.wasDerivedFrom, ngR,         reportR);
				}else if( this.specimenAntecedent != null ) {
               conn.add(spoSetR, PROVO.wasDerivedFrom, this.specimenAntecedent, reportR);
            }
				conn.add(spoSetR, RDF.TYPE,             DCAT.Dataset,   reportR);
				conn.add(spoSetR, RDF.TYPE,             VSR.SPODataset, reportR);
				conn.add(spoSetR, RDF.TYPE,             VSR.Dataset,    reportR);
				conn.add(spoSetR, VoID.subset,          sSetR,          reportR);
				conn.add(spoSetR, VoID.subset,          pSetR,          reportR);
				conn.add(spoSetR, VoID.subset,          oSetR,          reportR);

				
				// ---------------------------------------------------------------------------------------------------------
				System.err.println("  Number of triples"); // --------------------------------------------------------------
				double numTriples = conn.size(specimenContextR);
				System.err.println("    "+(int)numTriples);
				// specimenContextR numTriplesP primary.size(specimenContextR) .
				conn.add(spoSetR, VoID.triples, vf.createLiteral((int)conn.size(specimenContextR)), reportR);
				conn.add(spoSetR, SIO.count,    vf.createLiteral((int)conn.size(specimenContextR)), reportR);
				
				conn.commit();

				
				// ---------------------------------------------------------------------------------------------------------
				System.err.println("  SPO balance: "); // ------------------------------------------------------------------
				SPOBalance spoBal = new SPOBalance(specimenContextR);
				QueryletProcessor.processQueries(specimenRepository, new LimitOffsetQuerylet(spoBal,LIMIT));

				Hashtable<BalanceType,Integer> balance = spoBal.get();
				
				conn.add(sSetR, RDF.TYPE,  VSR.SubjectsDataset,                          reportR);
				conn.add(sSetR, RDF.TYPE,  VSR.Dataset,                                  reportR);
				conn.add(sSetR, SIO.count, vf.createLiteral(balance.get(BalanceType.S)), reportR);
				conn.add(oSetR, RDF.TYPE,  VSR.ObjectsDataset,                           reportR);
				conn.add(oSetR, RDF.TYPE,  VSR.Dataset,                                  reportR);
				conn.add(oSetR, SIO.count, vf.createLiteral(balance.get(BalanceType.O)), reportR);
				conn.commit();

				System.err.println("    "+SPOBalance.toStringCounts(balance,spoBal.getNumTriples()));
				double sDiameter = 2*Math.sqrt(balance.get(BalanceType.S)/Math.PI);
				double oDiameter = 2*Math.sqrt(balance.get(BalanceType.O)/Math.PI);

				//         - - - - - - - - - - - - - - Subjects - - - - - - - - - - - - - -
				//
				//
				//
				//                                       named
				//                       bnode:                         uri:
				// c          +----------------------------+---------------------------+
				// o          |                            |                           |     
				// n  source: |  (bnode source subjects)   |   (uri source subjects)   |   
				// n (O_S)    |                            |                           |      preds
				// e          |----------------------------+---------------------------|   +------------
				// c          |                            |                           |   |
				// t bridge:  |  (bnode bridge subjects)   |   (uri bridge subjects)   |   |
				// i (NO_S)   |                            |                           |   |
				// v          +----------------------------+---------------------------+   |
				// i                                                                       |
				// t                                                                       +------------
				// y

				URI sub_blank  = vf.createURI(reportR.stringValue()+nameHash+"/spo/s/name/resource/named/blank");
				URI sub_uri    = vf.createURI(reportR.stringValue()+nameHash+"/spo/s/name/resource/named/uri");
				URI sub_bridge = vf.createURI(reportR.stringValue()+nameHash+"/spo/s/connectivity/bridge");
				URI sub_source = vf.createURI(reportR.stringValue()+nameHash+"/spo/s/connectivity/source");
				
				conn.add(sSetR, VoID.subset, sub_blank,  reportR);
				conn.add(sSetR, VoID.subset, sub_uri,    reportR);
				conn.add(sSetR, VoID.subset, sub_bridge, reportR);
				conn.add(sSetR, VoID.subset, sub_source, reportR);
				
				URI sub_blank_bridge = vf.createURI(reportR.stringValue()+nameHash+"/spo/s/name/resource/named/blank/connectivity/bridge");
				URI sub_blank_src    = vf.createURI(reportR.stringValue()+nameHash+"/spo/s/name/resource/named/blank/connectivity/source");
				URI sub_uri_bridge   = vf.createURI(reportR.stringValue()+nameHash+"/spo/s/name/resource/named/uri/connectivity/bridge");
				URI sub_uri_src      = vf.createURI(reportR.stringValue()+nameHash+"/spo/s/name/resource/named/uri/connectivity/source");

            conn.add(sub_blank,  RDF.TYPE,    VSR.Dataset,      reportR);
            conn.add(sub_blank,  VoID.subset, sub_blank_bridge, reportR);
				conn.add(sub_blank,  VoID.subset, sub_blank_src,    reportR);
            conn.add(sub_uri,    RDF.TYPE,    VSR.Dataset,      reportR);
            conn.add(sub_uri,    VoID.subset, sub_uri_bridge,   reportR);
				conn.add(sub_uri,    VoID.subset, sub_uri_src,      reportR);
				
				conn.add(sub_bridge, VoID.subset, sub_blank_bridge, reportR);
				conn.add(sub_bridge, VoID.subset, sub_uri_bridge,   reportR);
				conn.add(sub_source, VoID.subset, sub_blank_src,    reportR);
				conn.add(sub_source, VoID.subset, sub_uri_src,      reportR);
				
				// Subject Sources (bnode and uri)
				SubjectsAsSourceQuerylet subSourceQ = new SubjectsAsSourceQuerylet(specimenContextR);
				int count = QueryletProcessor.processQuery(specimenRepository, subSourceQ);
				conn.add(sub_source, SIO.count, vf.createLiteral(count), reportR);
				
				HashMap<URI,Integer> talliesGranular = new HashMap<URI,Integer>();
				talliesGranular.put(sub_blank_src, 0);
				talliesGranular.put(sub_uri_src,   0);
				for( Resource source : subSourceQ.get() ) {
					if( source instanceof BNode ) {
						talliesGranular.put(sub_blank_src, 1+talliesGranular.get(sub_blank_src));
						// No need to put the bnode in as a sio:has-member
					}else {
						talliesGranular.put(sub_uri_src, 1+talliesGranular.get(sub_uri_src));
						conn.add(sub_uri_src, SIO.hasMember, source, reportR);
					}
				}
				
				// Subject Bridges (bnode and uri)
				SubjectsAsBridgeQuerylet subBridgeQ = new SubjectsAsBridgeQuerylet(specimenContextR);
				count = QueryletProcessor.processQuery(specimenRepository, subBridgeQ);
				conn.add(sub_bridge, SIO.count, vf.createLiteral(count), reportR);
				
				talliesGranular.put(sub_blank_bridge, 0);
				talliesGranular.put(sub_uri_bridge,   0);
				for( Resource source : subBridgeQ.get() ) {
					if( source instanceof BNode ) {
						talliesGranular.put(sub_blank_bridge, 1+talliesGranular.get(sub_blank_bridge));
						// No need to put the bnode in as a sio:has-member
					}else {
						talliesGranular.put(sub_uri_bridge, 1+talliesGranular.get(sub_uri_bridge));
						conn.add(sub_uri_bridge, SIO.hasMember, source, reportR);
					}
				}
				
				conn.add(sub_blank,  SIO.count, vf.createLiteral(talliesGranular.get(sub_blank_src)   +talliesGranular.get(sub_blank_bridge)), reportR);
				conn.add(sub_uri,    SIO.count, vf.createLiteral(talliesGranular.get(sub_uri_src)     +talliesGranular.get(sub_uri_bridge)),   reportR);
				conn.add(sub_bridge, SIO.count, vf.createLiteral(talliesGranular.get(sub_blank_bridge)+talliesGranular.get(sub_uri_bridge)),   reportR);
				conn.add(sub_source, SIO.count, vf.createLiteral(talliesGranular.get(sub_blank_src)   +talliesGranular.get(sub_uri_src)),      reportR);
				
            conn.add(sub_blank_bridge, RDF.TYPE,  VSR.Leaf,                                                reportR);
            conn.add(sub_blank_bridge, SIO.count, vf.createLiteral(talliesGranular.get(sub_blank_bridge)), reportR);
            conn.add(sub_blank_src,    RDF.TYPE,  VSR.Leaf,                                                reportR);
            conn.add(sub_blank_src,    SIO.count, vf.createLiteral(talliesGranular.get(sub_blank_src)),    reportR);
            conn.add(sub_uri_bridge,   RDF.TYPE,  VSR.Leaf,                                                reportR);
				conn.add(sub_uri_bridge,   SIO.count, vf.createLiteral(talliesGranular.get(sub_uri_bridge)),   reportR);
            conn.add(sub_uri_src,      RDF.TYPE,  VSR.Leaf,                                                reportR);
            conn.add(sub_uri_src,      SIO.count, vf.createLiteral(talliesGranular.get(sub_uri_src)),      reportR);
				
				conn.add(sub_blank_bridge, SIO.count, vf.createLiteral(talliesGranular.get(sub_blank_bridge)), reportR);
				conn.add(sub_uri_bridge,   SIO.count, vf.createLiteral(talliesGranular.get(sub_uri_bridge)),   reportR);
				conn.add(sub_blank_src,    SIO.count, vf.createLiteral(talliesGranular.get(sub_blank_src)),    reportR);
				conn.add(sub_uri_src,      SIO.count, vf.createLiteral(talliesGranular.get(sub_uri_src)),      reportR);
				
				
				// ---------------------------------------------------------------------------------------------------------
				System.err.println("  Predicates list: "); // --------------------------------------------------------------
				Predicates pList = new Predicates(specimenContextR);
				int numPred = QueryletProcessor.processQuery(specimenRepository, pList); // TODO: add just Querylet to LimitOffset
				conn.add(pSetR, RDF.TYPE,  VSR.Dataset,                          reportR);
				conn.add(pSetR, RDF.TYPE,  VSR.PredicatesDataset,                reportR);
				conn.add(pSetR, SIO.count, vf.createLiteral(pList.get().size()), reportR);
				conn.commit();
				
				double pWidth = (sDiameter + oDiameter)/2;
				double pHeight = numTriples / pWidth;
				System.err.println("    p width " + df.format(Math.round(pWidth)) + " height " + df.format(Math.round(pHeight)));

				
				// ---------------------------------------------------------------------------------------------------------
				System.err.println("  Predicates distribution: "); // ------------------------------------------------------
				PredicateDistribution pDist = new PredicateDistribution(specimenContextR, pList.get());
				double numTriples2 = QueryletProcessor.processQueries(specimenRepository, new LimitOffsetQuerylet(pDist,LIMIT));
				if( numTriples != numTriples2 ) {
					System.err.println("TRIPLE COUNT INCONSISTENT: "+numTriples2+" vs. "+numTriples);
				}
				HashMap<Resource,Integer> distribution = pDist.get();
				PredicateDistribution.describeDistribution(pSetR, distribution, conn, reportR);
				
			
				
				//      To: Sources Bridges Sinks      ('-' is impossible, '+' is calculated)
				// From:
				// Sources     -      +       +       <(SourcePredicatesToBridges, SourcePredicatesToSinks)
				// Bridges     -      +       +       <(BridgePredicatesDataset,   SinkPredicatesDataset)
				// Sinks       -      -       -
				//
				// From sources to sources is impossible b/c then the latter would be a bridge.
            URI pSetFromSourcesToBridgesR  = vf.createURI(pSetR.stringValue()+"/from/sources/to/bridges");
            URI pSetFromSourcesToSinksR    = vf.createURI(pSetR.stringValue()+"/from/sources/to/sinks");
            // From bridges to sources is impossible b/c then the source would be a bridge.
            URI pSetAmongBridgesR          = vf.createURI(pSetR.stringValue()+"/among/bridges");
            URI pSetFromBridgesToSinksR    = vf.createURI(pSetR.stringValue()+"/from/bridges/to/sinks");
            // From sinks to bridges (or sources) is impossible b/c then the sink would be a bridge.
            conn.add(pSetR, VoID.subset, pSetFromSourcesToBridgesR, reportR);
            conn.add(pSetR, VoID.subset, pSetFromSourcesToSinksR,   reportR);
            conn.add(pSetR, VoID.subset, pSetAmongBridgesR,         reportR);
            conn.add(pSetR, VoID.subset, pSetFromBridgesToSinksR,   reportR);

            // 
            // Predicates from {Source / Bridge / Sink} (to Bridge)
            //                  ^^^^^^
            conn.add(pSetFromSourcesToBridgesR, RDF.TYPE,  VSR.SourcePredicatesToBridgesDataset, reportR);
            PredicatesFromSourcesToBridges fromSourcesToBridgesQ = new PredicatesFromSourcesToBridges(specimenContextR);
            QueryletProcessor.processQuery(specimenRepository, fromSourcesToBridgesQ);
            System.err.println(" -- Predicates from sources to bridges:");
            PredicateDistribution.describeDistribution(pSetFromSourcesToBridgesR, fromSourcesToBridgesQ.get(), conn, reportR);

            // 
            // Predicates from {Source / Bridge / Sink} (to Sink)
            //                  ^^^^^^
            conn.add(pSetFromSourcesToSinksR, RDF.TYPE,  VSR.SourcePredicatesToSinksDataset, reportR);
            PredicatesFromSourcesToSinks fromSourcesToSinksQ = new PredicatesFromSourcesToSinks(specimenContextR);
            QueryletProcessor.processQuery(specimenRepository, fromSourcesToSinksQ);
            System.err.println(" -- Predicates from sources to sinks:");
            PredicateDistribution.describeDistribution(pSetFromSourcesToSinksR, fromSourcesToSinksQ.get(), conn, reportR);
            
            // 
            // Predicates from {Source / Bridge / Sink} (to Sink)
            //                           ^^^^^^
            conn.add(pSetAmongBridgesR, RDF.TYPE,  VSR.BridgePredicatesDataset, reportR);      
            PredicatesAmongBridges amongBridgesQ = new PredicatesAmongBridges(specimenContextR);
            QueryletProcessor.processQuery(specimenRepository, amongBridgesQ);
            System.err.println(" -- Predicates among bridges:");
            PredicateDistribution.describeDistribution(pSetAmongBridgesR, amongBridgesQ.get(), conn, reportR);
            
            // 
            // Predicates *to* {Source / Bridge / Sink} (from Bridge)
            //                                    ^^^^
            conn.add(pSetFromBridgesToSinksR, RDF.TYPE, VSR.SinkPredicatesDataset, reportR);
            PredicatesFromBridgesToSinks toSinksQ = new PredicatesFromBridgesToSinks(specimenContextR);
            QueryletProcessor.processQuery(specimenRepository, toSinksQ);
            System.err.println(" -- Predicates from bridges to sinks:");
            PredicateDistribution.describeDistribution(pSetFromBridgesToSinksR, toSinksQ.get(), conn, reportR);
            

            // Predicate grouped by namespace
            URI pNSBinsR = vf.createURI(pSetR.stringValue()+"/ns");
            HashMap<Resource,Integer> cumulative = PredicateDistribution.aggregateByNS(fromSourcesToBridgesQ.get(),
                                                   fromSourcesToSinksQ.get(), amongBridgesQ.get(), toSinksQ.get());
            PredicateDistribution.describeDistribution(pNSBinsR, RDFS.ISDEFINEDBY, cumulative, conn, reportR);

				// ---------------------------------------------------------------------------------------------------------
				//System.err.println("  SPO balance: "); // ------------------------------------------------------------------
				//RepositorySummaryQuerylet repSummaryQuerylet = new RepositorySummaryQuerylet(reportR,specimenContextR);
				//QueryletProcessor.processQueries(specimenRepository,repSummaryQuerylet);
				//repSummaryQuerylet.printBalance("    ");

				
				// ---------------------------------------------------------------------------------------------------------
				System.err.println("  Classes:"); // -----------------------------------------------------------------------
				Classes classesQuerylet = new Classes(specimenContextR);
				QueryletProcessor.processQuery(specimenRepository, classesQuerylet);
				for( Resource classR : classesQuerylet.get() ) {
					System.err.println("    "+pmap.bestQNameFor(classR.stringValue()));
				}

				
				// ---------------------------------------------------------------------------------------------------------
				System.err.println("  Predicates from classes:"); // -------------------------------------------------------
				for( Resource classR : classesQuerylet.get() ) {
					System.err.println("    "+pmap.bestQNameFor(classR.stringValue()));
					PredicatesFromClass predsFromClass = new PredicatesFromClass(specimenContextR,classR);
					QueryletProcessor.processQuery(specimenRepository, predsFromClass);
					for( Resource predR : predsFromClass.get() ) {
						System.err.println("       "+pmap.bestQNameFor(predR.stringValue()));
					}
				}

				
				// ---------------------------------------------------------------------------------------------------------
				System.err.println("  Predicates to classes:"); // ---------------------------------------------------------

				
				// ---------------------------------------------------------------------------------------------------------
				System.err.println("  Resources"); // ----------------------------------------------------------------------
				Names names = new Names(specimenContextR);
				QueryletProcessor.processQueries(specimenRepository, names);
				System.err.println("       size: "+names.get().size());
				int buffer = 0;
				for( Resource resource : names.get() ) {
					//System.err.println("       "+resource.stringValue());
					//conn.add(resource, VoID.inDataset, graph, reportR);
					if ( buffer >= 50 ) {
						conn.commit();
						buffer = 0;
					}
					buffer++;
				}
				
				
				
				
				//         - - - - - - - - - - - - - - Objects - - - - - - - - - - - - - -
				//
				//--+ 
				//  |                                    name               
				//  | c                    uri:                         bnode:          literals:
				//  | o        +---------------------------+--------------------------+----------+
				//  | n        |                           |                          |          |  d
				//  | n bridge |  (uri bridge subjects)    |  (bnode bridge subjects) |  xsd:int |  a
				//  | e        |                           |                          |----------+  t
				//--+ c        |---------------------------+--------------------------|   :str   |  a
				//    t        |                           |                          |----------+  t 
				//    i sink   |  (uri sink   subjects)    |  (bnode sink subjects)   |----------+  y
				//    v        |                           |                          |  :float  |  p
				//    i        +---------------------------+--------------------------+----------+  e
				//    t
				//    y
				
				URI obj_resource = vf.createURI(reportR.stringValue()+nameHash+"/spo/o/name/resource");
				URI obj_literal  = vf.createURI(reportR.stringValue()+nameHash+"/spo/o/name/literal");
				URI obj_bridge   = sub_bridge; // vf.createURI(reportR.stringValue()+nameHash+"/spo/o/connectivity/bridge");
				URI obj_sink     = vf.createURI(reportR.stringValue()+nameHash+"/spo/o/connectivity/sink");
				
				conn.add(oSetR, VoID.subset, obj_resource, reportR);
				conn.add(oSetR, VoID.subset, obj_literal,  reportR);
				
				URI obj_blank = vf.createURI(reportR.stringValue()+nameHash+"/spo/o/name/resource/named/blank");
				URI obj_uri   = vf.createURI(reportR.stringValue()+nameHash+"/spo/o/name/resource/named/uri");
				
				conn.add(obj_resource, RDF.TYPE,    VSR.ResourceObjectsDataset,  reportR);
				conn.add(obj_resource, RDF.TYPE,    VSR.Dataset,                 reportR);
				conn.add(obj_resource, VoID.subset, obj_blank,                   reportR);
				conn.add(obj_resource, VoID.subset, obj_uri,                     reportR);
				conn.add(obj_resource, VoID.subset, obj_bridge,                  reportR);
				conn.add(obj_resource, VoID.subset, obj_sink,                    reportR);
				
				// above: sub_blank_bridge = reportR.stringValue()+nameHash+"/spo/s/name/resource/named/blank/connectivity/bridge"
				// above: sub_uri_bridge   = reportR.stringValue()+nameHash+"/spo/s/name/resource/named/uri/connectivity/bridge"
				
				// Bridge subjects are equivalent to bridge objects.
            conn.add(obj_blank, RDF.TYPE,    VSR.Dataset,      reportR);
            conn.add(obj_blank, VoID.subset, sub_blank_bridge, reportR);
            conn.add(obj_uri,   RDF.TYPE,    VSR.Dataset,      reportR);
            conn.add(obj_uri,   VoID.subset, sub_uri_bridge,   reportR);
				
				URI obj_blank_sink = vf.createURI(reportR.stringValue()+nameHash+"/spo/o/name/resource/named/blank/connectivity/sink");
				URI obj_uri_sink   = vf.createURI(reportR.stringValue()+nameHash+"/spo/o/name/resource/named/uri/connectivity/sink");
				
				// Object Sink Resources (bnode and uri)
				ObjectsAsSinkQuerylet objSinksQ = new ObjectsAsSinkQuerylet(specimenContextR);
				count = QueryletProcessor.processQuery(specimenRepository, objSinksQ);
				conn.add(obj_sink, SIO.count,   vf.createLiteral(count), reportR);
				conn.add(obj_sink, VoID.subset, obj_blank_sink,          reportR);
				conn.add(obj_sink, VoID.subset, obj_uri_sink,            reportR);
				talliesGranular.put(obj_blank_sink, 0);
				talliesGranular.put(obj_uri_sink,   0);
				for( Resource object : objSinksQ.get() ) {
					if( object instanceof BNode ) {
						talliesGranular.put(obj_blank_sink, 1+talliesGranular.get(obj_blank_sink));
						// No need to put the bnode in as a sio:has-member
					}else {
						talliesGranular.put(obj_uri_sink,   1+talliesGranular.get(obj_uri_sink));
						conn.add(obj_uri_sink, SIO.hasMember, object, reportR);
					}
				}
            conn.add(obj_blank_sink, RDF.TYPE , VSR.Leaf,                                              reportR);
            conn.add(obj_blank_sink, SIO.count, vf.createLiteral(talliesGranular.get(obj_blank_sink)), reportR);
            conn.add(obj_uri_sink,   RDF.TYPE,  VSR.Leaf,                                              reportR);
            conn.add(obj_uri_sink,   SIO.count, vf.createLiteral(talliesGranular.get(obj_uri_sink)),   reportR);
				
				

				
				
				// Object Literals (by datatype)
				ObjectLiteralsDistributionQuerylet objDistQ = new ObjectLiteralsDistributionQuerylet(specimenContextR, pList.get());
				QueryletProcessor.processQueries(specimenRepository, objDistQ);
				int bin = 0;
				int totalLiterals = 0;
				for( URI datatype : objDistQ.get().keySet() ) { // HashMap<URI,HashMap<String,Integer>>
					bin++;
					URI datatypeBinR = vf.createURI(reportR.stringValue()+nameHash+"/spo/o/named/literal/datatype/"+bin);
					conn.add(obj_literal,  VoID.subset, datatypeBinR,                    reportR);
					
					HashMap<String,Integer> typedValueDist = objDistQ.get().get(datatype);
					count = typedValueDist.size();
					conn.add(datatypeBinR, SIO.count,   vf.createLiteral(count),         reportR);
					conn.add(datatypeBinR, RDF.TYPE,    VSR.Dataset,                     reportR);
					conn.add(datatypeBinR, RDF.TYPE,    VSR.Bin,                         reportR);
					conn.add(datatypeBinR, RDF.TYPE,    VSR.TypedLiteralObjectsDataset,  reportR);
					
					//BNode restriction = vf.createBNode();
					//conn.add(datatypeBinR, OWL.EQUIVALENTCLASS, restriction,             reportR);
					if( datatype != null) {
						conn.add(datatypeBinR,  OWL.ONPROPERTY,     VSR.datatype,          reportR);
						conn.add(datatypeBinR,  OWL.HASVALUE,       datatype,              reportR);
					}else {
						conn.add(datatypeBinR,  OWL.ONPROPERTY,     VSR.datatype,          reportR);
						conn.add(datatypeBinR,  OWL.MAXCARDINALITY, vf.createLiteral(0),   reportR);
					}
					conn.commit();
					

					int vBin = 0;
					for( String value : typedValueDist.keySet() ) {
						vBin++;
						URI valueBinR = vf.createURI(reportR.stringValue()+nameHash+"/spo/o/name/literal/datatype/"+bin+"/value/"+vBin);
						conn.add(datatypeBinR, VoID.subset, valueBinR, reportR);
						
						conn.add(valueBinR, RDF.TYPE,  VSR.Dataset,                                 reportR);
						conn.add(valueBinR, RDF.TYPE,  VSR.Bin,                                     reportR);
						conn.add(valueBinR, RDF.TYPE,  VSR.TypedLiteralObjectsValueDataset,         reportR);
						conn.add(valueBinR, SIO.count, vf.createLiteral(typedValueDist.get(value)), reportR);
						totalLiterals += typedValueDist.get(value);
						//BNode restrictionV = vf.createBNode();
						//conn.add(valueBinR,     OWL.EQUIVALENTCLASS, restrictionV, reportR);
						conn.add(valueBinR, OWL.ONPROPERTY, RDF.OBJECT, reportR);

						boolean captureLiterals = false;
						// TODO: add option to exclude recording the literal value (to save graph size)
						if( captureLiterals ) {
							if( datatype != null) {
								conn.add(valueBinR,  OWL.HASVALUE,    vf.createLiteral(value, datatype), reportR);
							}else {
								conn.add(valueBinR,  OWL.HASVALUE,    vf.createLiteral(value),           reportR);
							}
						}
					}
				}
				conn.add(obj_literal, RDF.TYPE,  VSR.LiteralObjectsDataset,       reportR);
				conn.add(obj_literal, RDF.TYPE,  VSR.Dataset,                     reportR);
				conn.add(obj_literal, SIO.count, vf.createLiteral(totalLiterals), reportR);
				
				conn.add(spoSetR, PROVO.generatedAtTime, vf.createLiteral(DateTimeValueHandler.getNowXMLGregorianCalendar()), reportR);
			}
			conn.add(reportR, PROVO.generatedAtTime, vf.createLiteral(DateTimeValueHandler.getNowXMLGregorianCalendar()), reportR);
			//conn.export(new RDFXMLPrettyWriter(System.out), reportR);
			conn.export(Constants.forFileExtension("ttl"), reportR);
		} catch (RepositoryException e) {
			e.printStackTrace();
		} catch (RDFHandlerException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (RepositoryException e) {
				e.printStackTrace();
			}            
		}
	}

	public final static String USAGE = 
			"usage: RepositorySummarizer [--cr-base-uri <base-uri>]\n"+
	      "                            { -(sysin)                                [--derivedFrom <antecedent>] [reportURI | .]                                                       |\n"+
			"                              -r(emote)    serverURL repositoryID <reportURI | .> [context-to-summarize ...] |\n"+
         "                              -s(parql)    serverURL              <reportURI | .> [context-to-summarize ...] |\n"+
			"                              -d(irectory) path/to/sesame-native-dir/ [--derivedFrom <antecedent>] [context-to-summarize ...]             |\n"+
			"                              -f(ile)      path/to/a.rdf              [--derivedFrom <antecedent>] <reportURI | .> }\n"+
			"where:\n"+
			"   -(sysin):     Summarize the RDF on standard in; print summary report to standard out.\n"+
			"                 If reportURI or . are provided, print TRiG instead of RDF/XML.\n"+
			"   -r(emote):    Summarize listed specimenContexts in Sesame repositoryID at serverURL. \n"+
			"                 If no specimenContexts listed, summarize all contexts in repository.\n"+
         "   -s(parql):    Summarize listed specimenContexts in SPARQL endpoint at serverURL. \n"+
         "                 If no specimenContexts listed, summarize all contexts in repository.\n"+
			"   -d(irectory): Summarize listed specimenContexts in sesame native directory. \n"+
			"                 If no specimenContexts listed, summarize all contexts in directory.\n"+
			"   -f(ile):      Summarize the RDF in file; print summary report to standard out.\n"+
			"\n"+
			"( version: "+version+" )";

	/**
	 * 
	 * @param args
	 */
	public static void main(String[] args) {

		if( args.length == 0 ) {
			System.err.println(USAGE);
			System.exit(1);
		}

		System.err.println("RepositorySummarizer version: " + version);

		String baseURI = "http://eg.org";
		
		int arg = 0;
		if( args.length > 2+arg && (    "--baseURI".equals(args[arg]) ||   // deprecated argument name; use --cr-base-uri
		                            "--cr-base-uri".equals(args[arg])) ) { // per https://github.com/timrdf/csv2rdf4lod-automation/wiki/SDV-organization
		   baseURI = args[arg+1];
		   System.err.println("--cr-base-uri: " + baseURI);
		   arg += 2;
		}
		
		String sourceType = args[arg];
		System.err.println("source type: " +sourceType + " " + arg);

		// The following if/else needs to populate the following for the RepositorySummarizer:
		Resource             specimenEndpoint   = null;
		Repository           specimenRepository = null;
		Collection<Resource> contextIDs         = null;
      Resource             antecedentR        = null;
	   Repository           reportRepository   = null;
		Resource             reportR            = null;       

		if( "-".equalsIgnoreCase(sourceType) || "-sysin".equalsIgnoreCase(sourceType) ) {

			Resource destinationContext = vf.createURI(VSR.BASE_URI+"PIPED_CONTEXT");

			specimenRepository = Constants.getPipeRepository(destinationContext);

			contextIDs = new ArrayList<Resource>(); contextIDs.add(destinationContext);

			if( args.length < 2+arg || ".".equalsIgnoreCase(args[1+arg]) ) {
				reportR = vf.createURI(VSR.BASE_URI + NameFactory.getMillisecondToMinuteName("RepositorySummarizer"));
			}else {
				reportR = vf.createURI(args[1+arg]);
			}
			reportRepository = specimenRepository;
		}else if( ("r".equalsIgnoreCase(sourceType) || "repository".equalsIgnoreCase(sourceType)) && args.length >= 4+arg ) {
			String serverURL      = args[1+arg];
			String repositoryID   = args[2+arg];

			//http://sourceforge.net/mailarchive/forum.php?thread_name=4EA7086D.8040708%40gmail.com&forum_name=sesame-general
			System.err.println("using http repository "+serverURL+" repoID "+repositoryID);
			specimenRepository = new HTTPRepository(serverURL, repositoryID);
			try {
				specimenRepository.initialize();
			} catch (RepositoryException e2) {
				e2.printStackTrace();
			}

			String reportName = args[3+arg].equals(".") ? 
			      baseURI + NameFactory.getMillisecondToMinuteName("RepositorySummarizer")
			      : args[3+arg];
			      
	      reportR = vf.createURI(reportName);

	      contextIDs = new HashSet<Resource>();
	      for( int i = 4; i < args.length+arg; i++ ) {
	         if( args[i+arg].equalsIgnoreCase("-d" )) {
	            System.err.println("adding default specimenContexts.");
	            contextIDs.addAll(getURIs());
	         }else {
	            contextIDs.add(vf.createURI(args[i+arg]));
	         }
	      }

	      if( contextIDs.size() == 0 ) {
	         RepositoryConnection conn = null;
	         try {
	            conn = specimenRepository.getConnection();
	            System.err.println("Getting contextIDs from repository...");
	            contextIDs = conn.getContextIDs().asList();
	         } catch (RepositoryException e) {
	            e.printStackTrace();
	         } finally {
	            try {
	               conn.close();
	            } catch (RepositoryException e) {
	               e.printStackTrace();
	            }            
	         }
	      }
        reportRepository = specimenRepository;
		}else if( (sourceType.equalsIgnoreCase("-s") || sourceType.equalsIgnoreCase("-sparql")) && args.length >= 3+arg ) {
          String serverURL = args[1+arg];
          specimenEndpoint = vf.createURI(serverURL);
	       
	       System.err.println("using SPARQL endpoint "+serverURL);
	       specimenRepository = new SPARQLRepository(serverURL);
	       try {
	          specimenRepository.initialize();
	       } catch (RepositoryException e) {
	          e.printStackTrace();
	       }
	       
	       String reportName = args[2+arg].equals(".") ? 
	               baseURI + NameFactory.getMillisecondToMinuteName("RepositorySummarizer")
	               : args[2+arg];
	       reportR = vf.createURI(reportName);

	       contextIDs = new HashSet<Resource>();
	       for( int i = 3; i+arg < args.length; i++ ) {
	          if( args[i+arg].equalsIgnoreCase("-d" )) {
	             System.err.println("adding default specimenContexts.");
	             contextIDs.addAll(getURIs());
	          }else {
	             contextIDs.add(vf.createURI(args[i+arg]));
	          }
	       }

	       if( contextIDs.size() == 0 ) {
	          RepositoryConnection conn = null;
	          try {
	             conn = specimenRepository.getConnection();
	             System.err.println("Getting contextIDs from repository...");
	             contextIDs = conn.getContextIDs().asList();
	          } catch (RepositoryException e) {
	             e.printStackTrace();
	          } finally {
	             try {
	                conn.close();
	             } catch (RepositoryException e) {
	                e.printStackTrace();
	             }            
	          }
	       }

          reportRepository = new SailRepository(new MemoryStore());
          try {
            reportRepository.initialize();
         } catch (RepositoryException e) {
            e.printStackTrace();
         }

		}else if( (sourceType.equalsIgnoreCase("-d") || sourceType.equalsIgnoreCase("-directory")) && args.length >= 2+arg ) {
	
			String nativeRepositoryDirPath = args[1+arg];
			System.err.println("summarizing native repository "+nativeRepositoryDirPath);

			File dataDir = new File(args[1+arg]);
			String indexes = "spoc,posc,cspo,cpos,cops,cosp,opsc,ospc"; //"spoc,posc";//"spoc,posc,cosp";  //spoc posc
			specimenRepository = new SailRepository(new NativeStore(dataDir, indexes));
			try {
				specimenRepository.initialize();
			} catch (RepositoryException e) {
				e.printStackTrace();
			}

			contextIDs = DefaultQuerylet.getContexts(args, 3+arg, specimenRepository);
			
			if( contextIDs == null || contextIDs.size() == 0 ) {
			   contextIDs.add((Resource)null);
			}

			String reportName = //args[3+arg].equals(".") ? 
					baseURI + "blah" ; //NameFactory.getMillisecondToMinuteName("RepositorySummarizer");
					//: args[3+arg];
			reportR = vf.createURI(reportName);

         //reportRepository = new SailRepository(new MemoryStore()); //specimenRepository;
			reportRepository = new SailRepository(new NativeStore(new File("~/repository-summarizer.sme"),"spoc,posc,cspo,cpos,cops,cosp,opsc,ospc"));
         try {
            reportRepository.initialize();
         } catch (RepositoryException e) {
            e.printStackTrace();
         }
		}else if( (sourceType.equalsIgnoreCase("-f") || sourceType.equalsIgnoreCase("-file")) && (args.length == 3+arg || args.length == 5+arg) ) {

			String sourcePath = args[1+arg];
         System.err.println("using file:                                            " + sourcePath);
         
			if( args.length == 5+arg && "--derivedFrom".equals(args[2+arg])) {
			   if( ResourceValueHandler.isURI(args[3+arg])) {
			      antecedentR = vf.createURI(args[3+arg]);
	            System.err.println("--derivedFrom: "+antecedentR);
			   }
            arg += 2;
			}
			String reportURI = args[2+arg];

			specimenRepository = new SailRepository(new MemoryStore());
			try {
				specimenRepository.initialize();
			} catch (RepositoryException e) {
				e.printStackTrace();
			}

			contextIDs = new HashSet<Resource>();
			contextIDs.add(Constants.PIPE_CONTEXT);

			RepositoryConnection conn = null;
			try {
				conn = specimenRepository.getConnection();
				System.err.println("context: "+Constants.PIPE_CONTEXT);
				conn.add(new File(sourcePath), null, RDFFormat.forFileName(sourcePath), Constants.PIPE_CONTEXT);
			} catch (RepositoryException e) {
				e.printStackTrace();
			} catch (RDFParseException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}finally {
				try {
					if( conn != null) conn.close();
				} catch (RepositoryException e) {
					e.printStackTrace();
				}
			}

			String reportName = reportURI.equals(".") 
					? baseURI + NameFactory.getMillisecondToMinuteName("RepositorySummarizer")
							: reportURI;                
			reportR = vf.createURI(reportName);
					
         reportRepository = specimenRepository;
		}else{
			System.err.println(USAGE);
			System.exit(1);
		}

		for( Resource context : contextIDs ) {
			if( context != null ) {
            System.err.println("will summarize context:                                "+context.stringValue());    
			}else {
			   System.err.println("will summarize the default context.");
			}
		}
		if( null != reportR ) {
		   System.err.println("will report to context:                             "+reportR.stringValue());
		}else {
	       System.err.println("will report to default context.");
		}

		// Create the user and their prefix mapping preferences.
		Resource userR            = vf.createURI(VSR.BASE_URI+"Tim_Lebo");//TODO hard coded.
		Resource userPrefContextR = vf.createURI(VSR.BASE_URI+"Tim_Lebos_prefix_mapping_preferences_26_feb_2009_1235681614857");
		System.err.println("checking for namespace abbreviation preferences in NG:    " + userPrefContextR.stringValue());   
		System.err.println("checking for namespace abbreviation preferences for user: " + userR.stringValue()); 
		PreferredPrefixMappingsQuerylet prefPrefixMappingsQ = new PreferredPrefixMappingsQuerylet(userPrefContextR, userR);
		int numPreferences = QueryletProcessor.processQuery(specimenRepository, prefPrefixMappingsQ);

		PrefixMappings pmap = numPreferences <= 0 ? new DefaultPrefixMappings() : prefPrefixMappingsQ.get();

		RepositorySummarizer rSum = new RepositorySummarizer(specimenEndpoint, 
                                                		     specimenRepository, 
                                                		     contextIDs,
                                                		     antecedentR,
                                                		     reportRepository, 
                                                		     baseURI, 
                                                		     reportR, 
                                                		     pmap);
		rSum.summarize();
	}

	/**
	 * 
	 * @return
	 */
	public static final Collection<Resource> getURIs() {
		Collection<Resource> uris = new ArrayList<Resource>();
		uris.add(VSR.nameR("Tim_Lebos_prefix_mapping_preferences"));
		return uris;
	}
}