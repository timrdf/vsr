package edu.rpi.tw.visualization.overview.linksets;

import java.io.File;
import org.openrdf.model.URI;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import org.openrdf.model.Namespace;
import org.openrdf.model.Resource;
import org.openrdf.model.ValueFactory;
import org.openrdf.model.impl.ValueFactoryImpl;
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
import edu.rpi.tw.data.rdf.sesame.query.QueryletProcessor;
import edu.rpi.tw.data.rdf.sesame.query.impl.DefaultQuerylet;
import edu.rpi.tw.data.rdf.sesame.querylets.summary.linksets.ResourcesInSPOBalanceNamedGraphs;
import edu.rpi.tw.data.rdf.sesame.string.PrettyTurtleWriter;
import edu.rpi.tw.data.rdf.sesame.vocabulary.PROVO;
import edu.rpi.tw.data.rdf.sesame.vocabulary.RDF;
import edu.rpi.tw.data.rdf.sesame.vocabulary.VSR;
import edu.rpi.tw.data.rdf.sesame.vocabulary.VoID;
import edu.rpi.tw.data.rdf.utils.pipes.Constants;
import edu.rpi.tw.string.NameFactory;
import edu.rpi.tw.string.pmm.DefaultPrefixMappings;
import edu.rpi.tw.string.pmm.PrefixMappings;
import edu.rpi.tw.visualization.overview.summarizer.PreferredPrefixMappingsQuerylet;
import edu.rpi.tw.visualization.overview.summarizer.RepositorySummarizer;

public class VoIDLinksetsFromSPOBalance {
   
   public static String version = "2013-Jul-11";
   
   public static ValueFactory   vf   = ValueFactoryImpl.getInstance();
   public static PrefixMappings pmap = DefaultPrefixMappings.getInstance();
   

   private Resource             specimenEndpoint;
   private Repository           specimenRepository;
   private Collection<Resource> specimenContexts;
   
   private Repository           reportRepository;
   private Resource             reportR;       
   private PrefixMappings       prefixMappings; // TODO: replace with pmap
   
   
   /**
    * 
    * @param specimenEndpoint
    * @param specimenRepository
    * @param specimenContexts
    * @param reportRepository
    * @param reportR
    * @param prefixMappings
    */
   public VoIDLinksetsFromSPOBalance(Resource             specimenEndpoint,
                                     Repository           specimenRepository,
                                     Collection<Resource> specimenContexts, 
                                     Repository           reportRepository,
                                     Resource             reportR,
                                     PrefixMappings       prefixMappings) {

      this.specimenEndpoint   = specimenEndpoint;
      this.specimenRepository = specimenRepository;
      this.specimenContexts   = specimenContexts;
      this.reportRepository   = reportRepository;
      this.reportR            = reportR;
      this.prefixMappings     = prefixMappings;
   }
   
   public void summarize() {
      RepositoryConnection conn = null;
      int LIMIT = 100000;
      
      try {
         //conn = specimenRepository.getConnection();
         conn = reportRepository.getConnection();

         long sizeBefore = conn.size(reportR);
         System.err.println("Replacing existing report of "+sizeBefore+" triples:\n");
         //conn.export(new PrettyTurtleWriter(System.err), reportR);
         if( reportR.stringValue().length() > 0 ) {
            try {
               conn.clear(reportR);
            }catch (UnsupportedOperationException e) {
               e.printStackTrace();
            }
            System.err.println("\ncleared existing report. size now "+conn.size(reportR));
         }else {
            System.err.println("\ndid not clear report. size still "+conn.size(reportR));
         }

         System.err.println("Prefix mappings for repository: ");
         System.err.println(PrettyTurtleWriter.prefixMappingsAsString(conn.getNamespaces().asList(),true));

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

         }
         
         ResourcesInSPOBalanceNamedGraphs querylet = new ResourcesInSPOBalanceNamedGraphs(null, pmap);
         QueryletProcessor.processQuery(this.specimenRepository, querylet);
         
         for( Resource dataset : querylet.get().keySet() ) {
            conn.add(dataset, RDF.type, VoID.DATASET,                                       reportR);
            for( Resource dataset2 : querylet.get().keySet() ) {
               conn.add(dataset2, RDF.type, VoID.DATASET,                                   reportR);
               if( !dataset2.equals(dataset) ) {
                  Set<URI> intersection = new HashSet<URI>();
                  intersection.addAll(   querylet.get().get(dataset));
                  intersection.retainAll(querylet.get().get(dataset2));
                  
                  if( intersection.size() > 1 ) {
                     Resource linkset = vf.createBNode();
                     conn.add(linkset, RDF.type,     VoID.Linkset,                          reportR);
                     conn.add(linkset, VoID.target,  dataset,                               reportR);
                     conn.add(linkset, VoID.target,  dataset2,                              reportR);
                     conn.add(linkset, VoID.triples, vf.createLiteral(intersection.size()), reportR);
                  }
               }
            }
            conn.commit();
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
         "usage: RepositorySummarizer { -(sysin) [reportURI | .] |\n"+
               "                              -r(emote) serverURL repositoryID <reportURI | .> [context-to-summarize ...] |\n"+
               "                              -s(parql) serverURL <reportURI | .> [context-to-summarize ...] |\n"+
               "                              -d(irectory) path/to/sesame-native-dir/ [context-to-summarize ...] |\n"+
               "                              -f(ile) path/to/a.rdf <reportURI | .> }\n"+
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

      System.err.println("VoIDLinksetsFromSPOBalance version: " + version);

      String sourceType = args[0];

      // The following if/else needs to populate the following for the RepositorySummarizer:
      Resource   specimenEndpoint     = null;
      Repository specimenRepository   = null;
      Collection<Resource> contextIDs = null;
      Repository reportRepository     = null;
      Resource   reportR              = null;       

      if( "-".equalsIgnoreCase(sourceType) || "-sysin".equalsIgnoreCase(sourceType) ) {

         Resource destinationContext = vf.createURI(VSR.BASE_URI+"PIPED_CONTEXT");

         specimenRepository = Constants.getPipeRepository(destinationContext);

         contextIDs = new ArrayList<Resource>(); contextIDs.add(destinationContext);

         if( args.length < 2 || ".".equalsIgnoreCase(args[1]) ) {
            reportR = vf.createURI(VSR.BASE_URI + NameFactory.getMillisecondToMinuteName("RepositorySummarizer"));
         }else {
            reportR = vf.createURI(args[1]);
         }
         reportRepository = specimenRepository;
      }else if( ("r".equalsIgnoreCase(sourceType) || "repository".equalsIgnoreCase(sourceType)) && args.length >= 4 ) {
         String serverURL      = args[1];
         String repositoryID   = args[2];

         //http://sourceforge.net/mailarchive/forum.php?thread_name=4EA7086D.8040708%40gmail.com&forum_name=sesame-general
         System.err.println("using http repository "+serverURL+" repoID "+repositoryID);
         specimenRepository = new HTTPRepository(serverURL, repositoryID);
         try {
            specimenRepository.initialize();
         } catch (RepositoryException e2) {
            e2.printStackTrace();
         }

         String reportName = args[3].equals(".") ? 
               VSR.BASE_URI + NameFactory.getMillisecondToMinuteName("RepositorySummarizer")
               : args[3];
               
         reportR = vf.createURI(reportName);

         contextIDs = new HashSet<Resource>();
         for( int i = 4; i < args.length; i++ ) {
            if( args[i].equalsIgnoreCase("-d" )) {
               System.err.println("adding default specimenContexts.");
               contextIDs.addAll(getURIs());
            }else {
               contextIDs.add(vf.createURI(args[i]));
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
      }else if( (sourceType.equalsIgnoreCase("-s") || sourceType.equalsIgnoreCase("-sparql")) && args.length >= 3 ) {
          String serverURL = args[1];
          specimenEndpoint = vf.createURI(serverURL);
          
          System.err.println("using SPARQL endpoint "+serverURL);
          specimenRepository = new SPARQLRepository(serverURL);
          try {
             specimenRepository.initialize();
          } catch (RepositoryException e) {
             e.printStackTrace();
          }
          
          String reportName = args[2].equals(".") ? 
                  VSR.BASE_URI + NameFactory.getMillisecondToMinuteName("RepositorySummarizer")
                  : args[2];
          reportR = vf.createURI(reportName);

          contextIDs = new HashSet<Resource>();
          for( int i = 3; i < args.length; i++ ) {
             if( args[i].equalsIgnoreCase("-d" )) {
                System.err.println("adding default specimenContexts.");
                contextIDs.addAll(getURIs());
             }else {
                contextIDs.add(vf.createURI(args[i]));
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

      }else if( (sourceType.equalsIgnoreCase("-d") || sourceType.equalsIgnoreCase("-directory")) && args.length >= 2 ) {
   
         String nativeRepositoryDirPath = args[1];
         System.err.println("using native repository "+nativeRepositoryDirPath);

         File dataDir = new File(args[1]);
         String indexes = "spoc,posc";//"spoc,posc,cosp";  //spoc posc
         specimenRepository = new SailRepository(new NativeStore(dataDir,indexes));
         try {
            specimenRepository.initialize();
         } catch (RepositoryException e) {
            e.printStackTrace();
         }

         contextIDs = DefaultQuerylet.getContexts(args, 3, specimenRepository);

         String reportName     = //args[3].equals(".") ? 
               VSR.BASE_URI + NameFactory.getMillisecondToMinuteName("RepositorySummarizer");
         //: args[3];
         reportR = vf.createURI(reportName);

         reportRepository = specimenRepository;
      }else if( (sourceType.equalsIgnoreCase("-f") || sourceType.equalsIgnoreCase("-file")) && args.length == 3 ) {

         String sourcePath = args[1];
         String reportURI  = args[2];

         System.err.println("using file:                                            " + args[1]);

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
               ? VSR.BASE_URI + NameFactory.getMillisecondToMinuteName("RepositorySummarizer")
                     : reportURI;                
         reportR = vf.createURI(reportName);
               
         reportRepository = specimenRepository;
      }else{
         System.err.println(USAGE);
         System.exit(1);
      }

      for( Resource context : contextIDs ) {
         if( context != null )
            System.err.println("will summarize context:                                "+context.stringValue());       
      }
      System.err.println("will report to context:                             "+reportR.stringValue());       

      // Create the user and their prefix mapping preferences.
      Resource userR            = vf.createURI(VSR.BASE_URI+"Tim_Lebo");//TODO hard coded.
      Resource userPrefContextR = vf.createURI(VSR.BASE_URI+"Tim_Lebos_prefix_mapping_preferences_26_feb_2009_1235681614857");
      System.err.println("checking for namespace abbreviation preferences in NG:    " + userPrefContextR.stringValue());   
      System.err.println("checking for namespace abbreviation preferences for user: " + userR.stringValue()); 
      PreferredPrefixMappingsQuerylet prefPrefixMappingsQ = new PreferredPrefixMappingsQuerylet(userPrefContextR, userR);
      int numPreferences = QueryletProcessor.processQuery(specimenRepository, prefPrefixMappingsQ);

      PrefixMappings pmap = numPreferences <= 0 ? new DefaultPrefixMappings() : prefPrefixMappingsQ.get();

      VoIDLinksetsFromSPOBalance rSum = new VoIDLinksetsFromSPOBalance(specimenEndpoint, specimenRepository, contextIDs, reportRepository, reportR, pmap);
      rSum.summarize();
   }
   
   public static final Collection<Resource> getURIs() {
      Collection<Resource> uris = new ArrayList<Resource>();
      uris.add(VSR.nameR("Tim_Lebos_prefix_mapping_preferences"));
      return uris;
   }
}