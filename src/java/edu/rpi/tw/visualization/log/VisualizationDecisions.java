package edu.rpi.tw.visualization.log;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.Calendar;
import java.util.HashMap;

import javax.xml.datatype.XMLGregorianCalendar;

import org.openrdf.model.Resource;
import org.openrdf.model.URI;
import org.openrdf.model.Value;
import org.openrdf.model.ValueFactory;
import org.openrdf.model.impl.ValueFactoryImpl;
import org.openrdf.model.vocabulary.RDF;
import org.openrdf.model.vocabulary.RDFS;
import org.openrdf.model.vocabulary.XMLSchema;
import org.openrdf.repository.Repository;
import org.openrdf.repository.RepositoryConnection;
import org.openrdf.repository.RepositoryException;
import org.openrdf.repository.http.HTTPRepository;
import org.openrdf.repository.sail.SailRepository;
import org.openrdf.rio.RDFHandlerException;
import org.openrdf.sail.memory.MemoryStore;

import edu.rpi.tw.data.csv.valuehandlers.DateTimeValueHandler;
import edu.rpi.tw.data.csv.valuehandlers.ResourceValueHandler;
import edu.rpi.tw.data.rdf.sesame.vocabulary.DCTerms;
import edu.rpi.tw.data.rdf.sesame.vocabulary.PROVO;
import edu.rpi.tw.data.rdf.sesame.vocabulary.SIO;
import edu.rpi.tw.data.rdf.sesame.vocabulary.VSR;
import edu.rpi.tw.data.rdf.utils.pipes.Constants;
import edu.rpi.tw.string.NameFactory;

/**
 * See https://github.com/timrdf/vsr/wiki/vsr2.xsl
 * and https://github.com/timrdf/vsr/wiki/Provenance-Capture-in-vsr2.xsl
 * and https://github.com/timrdf/vsr/blob/master/doc/diagrams/arrive-explain-resource-triple.png
 */
public class VisualizationDecisions {

   private ValueFactory         vf = ValueFactoryImpl.getInstance();
   
   private Repository           rep                = null;
   private Resource             context            = null;
   private Resource             generatingActivity = null;
   /* Used to create local names within the context */
   private int                  decisionCount = 0;

   private RepositoryConnection pconn             = null; // TODO: test to see if keeping one connection is faster.
   private boolean              usePersistentConn = true; // faster when not committing.
   private int                  commitInterval    = 1000;
   
   private String                  visUUID = null;
   
   private HashMap<String,Integer> delegations = new HashMap<String,Integer>();
   
   private long                    startTimeMS;

   /**
    * Cascade to {@link #VisualizationDecisions(String, String, String)} with self-generated context.
    */
   public VisualizationDecisions(String serverURL, String repositoryID) {
      this(serverURL, repositoryID, NameFactory.getMillisecondToDayName("vislog"));
   }

   /**
    * Commit provenance log to a Sesame server.
    * Call {@link #finish()} to clean up without a stderr dump; use {@link #export()} to clean up 
    * AND get the provenance dumped to stderr.
    * 
    * @param serverURL    - the URL of a Sesame server.
    * @param repositoryID - the repositoryID on the Sesame server.
    * @param context      - the URI of named graph within the Sesame serverURL:repositoryID
    */
   public VisualizationDecisions(String serverURL, String repositoryID, String context) {
      this(context);
      
      this.rep = new HTTPRepository(serverURL, repositoryID);
      this.context = vf.createURI(context);
      try {
         rep.initialize();
      } catch (RepositoryException e) {
         e.printStackTrace();
      }

      Calendar startTime = Calendar.getInstance();
      this.startTimeMS = startTime.getTimeInMillis();

      RepositoryConnection conn = null;
      try {
         conn = rep.getConnection();
         conn.add(this.context, RDF.TYPE, VSR.Graphic, this.context);
         conn.add(this.context, DCTerms.created, vf.createLiteral(this.startTimeMS), this.context);
         conn.commit();
      } catch (RepositoryException e) {
         e.printStackTrace();
      } finally {
         if( conn != null ) {
            try {
               conn.close();
            } catch (RepositoryException e) {
               e.printStackTrace();
            }
         }
      }
      if( usePersistentConn) {
         try {
            this.pconn = rep.getConnection();
         } catch (RepositoryException e) {
            e.printStackTrace();
         }
      }
   }

   /**
    * Log using an in-memory repository.
    * Only way to get results is to call {@link #export()}.
    * 
    * @param context
    */
   public VisualizationDecisions(String context) {
      
      this.context = vf.createURI(context);
      
      this.rep = new SailRepository(new MemoryStore());
      try {
         rep.initialize();
         pconn = rep.getConnection();
         
         this.generatingActivity = vf.createURI(context+"/activity");
         
         add(generatingActivity, RDF.TYPE, PROVO.Activity, this.context);
         
         XMLGregorianCalendar now = DateTimeValueHandler.getNowXMLGregorianCalendar();
         add(this.context, RDF.TYPE,             VSR.Graphic,        this.context);
         add(this.context, RDF.TYPE,             PROVO.Entity,       this.context);
         add(this.context, PROVO.wasGeneratedBy, generatingActivity, this.context);
         if( now != null ) {
            add(generatingActivity, PROVO.startedAtTime, vf.createLiteral(now), this.context);
         }
         
         this.visUUID = NameFactory.getUUIDName();
         
      } catch (RepositoryException e) {
         e.printStackTrace();
      }
   }
   /**
    * History note:
    * This method added Nov 1 2014 to avoid:
    * org.openrdf.repository.RepositoryException: Transaction failed: org.xml.sax.SAXException: Subject, predicate and object cannot be null for an AddStatementOperation (500)
    * 
    * @param subject
    * @param predicate
    * @param object
    * @param context
    * @throws RepositoryException 
    */
   private void add(Resource subject, URI predicate, Value object, Resource context) throws RepositoryException {
      if( subject != null && predicate != null && object != null && context != null ) {
         pconn.add(subject, predicate, object, context);
      }else {
         System.err.println("WARNING: avoided asserting triple b/c something was null:\n" + subject + "\n" + predicate + "\n" + object + "\n" + context);
      }
   }
   
   /**
    * 
    * @return
    */
   private String getDecisionURI() {
	   decisionCount++;
	   String decision = this.context.stringValue()+"/graphic/attribute/"+decisionCount;
	   try {
		   add(vf.createURI(decision), RDF.TYPE, SIO.Attribute, context);
	   } catch (RepositoryException e) {
		   e.printStackTrace();
	   }
	   return decision;
   }

   /**
    * 
    * @param actor    - the template that arrived at 'resource' to make some visual mapping decision.
    * @param resource - the RDF node about which 'actor' is about to make some visual mapping decision.
    * @param deferrer - the template that deferred to 'actor' to make the visual mapping decision.
    * 
    * @return
    */
   public String arriveResource(String actor, String resource, String deferrer) {
      delegation(actor,deferrer);
      return "";
   }

   /**
    * 
    * @param actor
    * @param resource
    * @return
    */
   public String arriveTriple(String actor,
                              String subject, String predicate,
                              String deferrer) {
      delegation(actor,deferrer);
      return ""; 
   }

   /**
    * 
    * @param actor
    * @param resource
    * @return
    */
   public String arriveTriple(String actor,
                              String subject, String predicate, String object,
                              String deferrer) {
      delegation(actor,deferrer);
      return ""; 
   }

   /**
    * Asserted into graph in {@link #assertDelegationCounts()}
    * 
    * @param actor
    * @param delegator
    */
   private void delegation(String actor, String delegator) {
      if( ResourceValueHandler.isURI(actor) ) {
         if( ResourceValueHandler.isURI(delegator) ) {
            String delegation = actor + " " + delegator;
            if( !this.delegations.containsKey(delegation) ) {
               this.delegations.put(delegation,0);
            }
            this.delegations.put(delegation, this.delegations.get(delegation) + 1);
         }else {
            System.err.println("edu.rpi.tw.visualization.log.VisualizationDecisions WARNING: delegator ("+delegator+") not specified as URI: "+actor);
         }
      }else {
         System.err.println("edu.rpi.tw.visualization.log.VisualizationDecisions WARNING: actor not specified as URI: "+actor);
      }
   }
   
   /**
    * 
    * @param subject       - of the triple.
    * @param focusR        - of the triple.
    * @param object        - of the triple.
    * @param actor         - name of the actor that acted on the triple.
    * @param action        - the action that the actor made on the triple.
    * @param visualForm    - URI of visual form created.
    * @param justification - reason the actor performed action on the triple.
    * $subject,$actor,$action,$visual-form-uri,$justification,$description
    */
   public String explainResource(String subject,
                                 String actor,
                                 String property, String value, String visualForm, 
                                 String justification, String description) {

      //	   System.err.println("s "+subject);
      //	   System.err.println("actor "+actor);
      //	   System.err.println("property ."+property+".");
      //	   System.err.println("value "+value);
      //	   System.err.println("visualForm "+visualForm);
      //	   System.err.println("justification "+justification);
      //	   System.err.println("desc "+description);

      //	s http://baseuri.com/version/2013-Feb-05/entity/96ec2e4b-13ad-42bf-b78c-0f4a43b0cfa0
      //	actor http://purl.org/twc/vocab/vsr#RDF_resource_visual_form_factory_390
      //	action vnode id = http://baseuri.com/version/2013-Feb-05/entity/96ec2e4b-13ad-42bf-b78c-0f4a43b0cfa0
      //	visualForm http://todo.org/visualformURIhttp://baseuri.com/version/2013-Feb-05/entity/96ec2e4b-13ad-42bf-b78c-0f4a43b0cfa0
      //	justification otherwise
      //	desc


      String decisionURI = getDecisionURI();     

      if( !ResourceValueHandler.isURI(subject) ) {
         System.err.println("subject is not a URI; edu.rpi.tw.visualization.log.VisualizationDecisions bailing");
         return decisionURI;
      }
      if( usePersistentConn ) {
         try {

            if( ResourceValueHandler.isURI(visualForm) ) {
               
               URI visualFormR = vf.createURI(visualForm);
               
               add(vf.createURI(visualForm), SIO.hasAttribute, vf.createURI(decisionURI), context);

               if( VSR.fill.stringValue().equals(property) ||
                     VSR.stroke.stringValue().equals(property) ) {

                  Resource colorR = vf.createURI(this.context.stringValue()+"/color/"+NameFactory.getMD5(value));
                  add(vf.createURI(visualForm), vf.createURI(property), colorR, context);
                  add(colorR, RDF.TYPE, VSR.Color,                              context);
                  add(colorR, VSR.rgb,  vf.createLiteral(value),                context);

               }else if( VSR.tooltip.stringValue().equals(property) ) {

                  Resource tooltipR = vf.createURI(this.context.stringValue()+"/tooltip/"+NameFactory.getMD5(value));

                  add(visualFormR, vf.createURI(property), tooltipR, context);
                  add(tooltipR,    PROVO.value, vf.createLiteral(value),    context);
               }else if( ResourceValueHandler.isURI(property) ) {
                  add(vf.createURI(visualForm), 
                        vf.createURI(property), 
                        ResourceValueHandler.isURI(value) ? vf.createURI(value) : vf.createLiteral(value),
                              context);
               }

               add(vf.createURI(visualForm), 
                     RDF.TYPE, 
                     VSR.Graphic, context);

               if( "a-root".equals(property) && "true".equals(value) ) {
                  add(vf.createURI(visualForm), 
                        RDF.TYPE, 
                        VSR.Root, context);
               }
               pconn.commit();

               /*
                * :actor p:decided_to :decisionURI_1 .
                */
               add(vf.createURI(decisionURI), 
                     PROVO.wasAttributedTo,
                     vf.createURI(actor), context);

               /*
                *  :decisionURI_1 p:produced     :visualForm_2;
                *                 dc:description "some desc";
                *                 dc:date        "5 feb" .         
                */
               add(vf.createURI(decisionURI), 
                     DCTerms.description, 
                     vf.createLiteral(description.replaceAll("^ *","")), context);

               add(vf.createURI(visualForm), SIO.hasAttribute, vf.createURI(decisionURI), context);



               /*
                *  :visualForm_2 a             tw:Visual_form;
                *                 p:composedBy :visual_artifact_0;
                *                 v:depicts    tbl:me .         
                */
               add(vf.createURI(visualForm), 
                     RDF.TYPE, 
                     VSR.Graphic, context);
               add(vf.createURI(visualForm), 
                     DCTerms.isPartOf, 
                     context, context);
               add(vf.createURI(visualForm), 
                     VSR.depicts, 
                     vf.createURI(subject), context);
               if( commitInterval > 0 && decisionCount % commitInterval == 0 ) {
                  pconn.commit();
               }
            }
         } catch (RepositoryException e) {
            e.printStackTrace();
         }
      }else {
         RepositoryConnection conn = null;
         try {
            conn = rep.getConnection();

            conn.add(vf.createURI(decisionURI), 
                  PROVO.wasAttributedTo, 
                  vf.createURI(actor), context);
            conn.commit();
         } catch (RepositoryException e) {
            e.printStackTrace();
         } finally {
            if( conn != null ) {
               try {
                  conn.close();
               } catch (RepositoryException e) {
                  e.printStackTrace();
               }
            }
         }
      }
      return decisionURI;
   }
   
   
   /**
    * 
    * @param subject       - of the triple.
    * @param focusR     - of the triple.
    * @param object        - of the triple.
    * @param actor         - name of the actor that acted on the triple.
    * @param action        - the action that the actor made on the triple.
    * @param visualForm    - URI of visual form created.
    * @param justification - reason the actor performed action on the triple.
    * $subject,$actor,$action,$visual-form-uri,$justification,$description
    */
   public String explainResource(String subject,
		   String actor,   String action,    String visualForm, 
		   String justification, String description) {

//	   System.err.println("s "+subject);
//	   System.err.println("actor "+actor);
//	   System.err.println("action "+action);
//	   System.err.println("visualForm "+visualForm);
//	   System.err.println("justification "+justification);
//	   System.err.println("desc "+description);

	   //	s http://baseuri.com/version/2013-Feb-05/entity/96ec2e4b-13ad-42bf-b78c-0f4a43b0cfa0
	   //	actor http://purl.org/twc/vocab/vsr#RDF_resource_visual_form_factory_390
	   //	action vnode id = http://baseuri.com/version/2013-Feb-05/entity/96ec2e4b-13ad-42bf-b78c-0f4a43b0cfa0
	   //	visualForm http://todo.org/visualformURIhttp://baseuri.com/version/2013-Feb-05/entity/96ec2e4b-13ad-42bf-b78c-0f4a43b0cfa0
	   //	justification otherwise
	   //	desc


	   String decisionURI = getDecisionURI();     

	   if( !ResourceValueHandler.isURI(subject) ) {
		   return decisionURI;
	   }
	   if( usePersistentConn ) {
		   try {

			   add(vf.createURI(visualForm), SIO.hasAttribute, vf.createURI(decisionURI), context);

			   /*
			    * :actor p:decided_to :decisionURI_1 .
			    */
			   add(vf.createURI(decisionURI), PROVO.wasAttributedTo, vf.createURI(actor), context);

			   /*
			    *  :decisionURI_1 p:produced     :visualForm_2;
			    *                 dc:description "some desc";
			    *                 dc:date        "5 feb" .         
			    */
			   add(vf.createURI(decisionURI), DCTerms.description, vf.createLiteral(description.replaceAll("^ *","")), context);

			   /*
			    *  :visualForm_2 a             tw:Visual_form;
			    *                 p:composedBy :visual_artifact_0;
			    *                 v:depicts    tbl:me .         
			    */
			   
			   add(vf.createURI(visualForm), RDF.TYPE,         VSR.Graphic,           context);
			   add(vf.createURI(visualForm), DCTerms.isPartOf, context,               context);
			   add(vf.createURI(visualForm), VSR.depicts,      vf.createURI(subject), context);
			   if( commitInterval > 0 && decisionCount % commitInterval == 0 ) {
				   pconn.commit();
			   }
		   } catch (RepositoryException e) {
			   e.printStackTrace();
		   }
	   }else {
		   RepositoryConnection conn = null;
		   try {
			   conn = rep.getConnection();

			  // TODO: get rid of this, or duplciate.
			   
			   conn.commit();
		   } catch (RepositoryException e) {
			   e.printStackTrace();
		   } finally {
			   if( conn != null ) {
				   try {
					   conn.close();
				   } catch (RepositoryException e) {
					   e.printStackTrace();
				   }
			   }
		   }
	   }
	   return decisionURI;
   }
   
   /**
    * 
    * @param subject       - of the triple.
    * @param focusR        - of the triple.
    * @param object        - of the triple.
    * @param actor         - name of the actor that acted on the triple.
    * @param action        - the action that the actor made on the triple.
    * @param justification - reason the actor performed action on the triple.
    */
   public String explain(String subject, String predicate, String object, 
                         String actor,   String action,    String justification, String description) {
      
      String decisionURI = getDecisionURI();     
                                          
      // TODO: add vsr:relatesTo from the subject depiction to the object depiction.
      
      if( usePersistentConn ) {
         try {
        	 
             //TODO add(vf.createURI(visualForm), SIO.hasAttribute, vf.createURI(decisionURI), context);
             
            add(vf.createURI(decisionURI), DCTerms.description,   vf.createLiteral(description.replaceAll("^ *","")), context);
       
            if( commitInterval > 0 && decisionCount % commitInterval == 0 ) {
               pconn.commit();
            }
         } catch (RepositoryException e) {
            e.printStackTrace();
         }
      }else {
         RepositoryConnection conn = null;
         try {
            conn = rep.getConnection();

            // TODO: remove this.
            
            conn.commit();
         } catch (RepositoryException e) {
            e.printStackTrace();
         } finally {
            if( conn != null ) {
               try {
                  conn.close();
               } catch (RepositoryException e) {
                  e.printStackTrace();
               }
            }
         }
      }
      return decisionURI;
   }
   
   /**
    * "8"
    * 
    * "6" (with Action) calls this with empty values for visualForm and value. TODO
    * 
    * @param subject       - of the triple.
    * @param focusR        - of the triple.
    * @param object        - of the triple.
    * @param actor         - name of the actor that acted on the triple.
    * @param action        - the action that the actor made on the triple.
    * @param justification - reason the actor performed action on the triple.
    */
   public String explainTriple(String subject, String predicate, String object,
                        		 String actor,
                        		 String visualForm, String property, String value,
                               String justification, String description) {

	   String decisionURI = getDecisionURI();     

	   // TODO: add vsr:relatesTo from the subject depiction to the object depiction.

	   try {

		   if( ResourceValueHandler.isURI(visualForm)) {
			   
			   Resource visualFormR = vf.createURI(visualForm);
			   
			   add(visualFormR, SIO.hasAttribute, vf.createURI(decisionURI), context);

			   if( ResourceValueHandler.isURI(actor)) {
				   URI actorR = vf.createURI(actor);
				   add(actorR, RDF.TYPE, PROVO.Agent, context);
				   add(actorR, PROVO.hadPlan, vf.createURI(actor+visUUID), context);
				   add(vf.createURI(actor+visUUID), RDF.TYPE, PROVO.Plan, context);
				   add(vf.createURI(decisionURI), PROVO.wasAttributedTo, actorR, context);
			   }

			   if( ResourceValueHandler.isURI(property) ) {
				   
				   if( VSR.fill.stringValue().equals(property) ) {

					   Resource colorR = vf.createURI(this.context.stringValue()+"/color/"+NameFactory.getMD5(value));
					   add(vf.createURI(visualForm), vf.createURI(property), colorR,  context);
					   add(colorR, RDF.TYPE, VSR.Color,                               context);
					   add(colorR, VSR.rgb,  vf.createLiteral(value),                 context);

				   }else if (VSR.stroke.stringValue().equals(property)) {

					   Resource strokeR = vf.createURI(this.context.stringValue()+"/stroke/"+NameFactory.getMD5(visualForm));
					   Resource colorR  = vf.createURI(this.context.stringValue()+"/color/"+NameFactory.getMD5(value));

					   add(vf.createURI(visualForm), vf.createURI(property), strokeR, context);
					   add(strokeR, RDF.TYPE, VSR.Stroke,                             context);
					   add(strokeR, VSR.fill,  colorR,                                context);	  

					   add(colorR, RDF.TYPE,  VSR.Color,                              context);	 
					   add(colorR, VSR.rgb,   vf.createLiteral(value),                context);	 

				   }else {
					   
					   add(vf.createURI(visualForm), vf.createURI(property), 
							   ResourceValueHandler.isURI(value) ? vf.createURI(value) : vf.createLiteral(value),
									   context);
				   
				   }
			   }
		   }



		   add(vf.createURI(decisionURI), DCTerms.description, vf.createLiteral(description.replaceAll("^ *","")), context);

		   if( commitInterval > 0 && decisionCount % commitInterval == 0 ) {
			   pconn.commit();
		   }
	   } catch (RepositoryException e) {
		   e.printStackTrace();
	   }

	   return decisionURI;
   }
   
   /**
    * "10"
    * 
    * @param subject     - the subject   of the triple being visualized.
    * @param predicate   - the predicate of the triple being visualized.
    * @param object      - the object    of the triple being visualized.
    * @param actor       - the actor deciding the visual mapping.
    * @param visualForm  - the URI of the visual edge that depicts the triple 'subject', 'predicate', 'object'.
    * 
    * The following describe 'from' and 'to' *after* the optional force-based swapping decision.
    * 
    * @param from_domain - the identifier, in domain space, of this visual connections' source visual element.
    * @param to_domain   - the identifier, in domain space, of this visual connections' target visual element.
    * @param from        - the local identifier, in visual space, of this visual connection's source visual element.
    * @param to          - the local identifier, in visual space, of this visual connection's target visual element.
    * 
    * @param justification - a structured representation for why this visual mapping was decided.
    * @param description   - a less structured ("human readable") representation for why this visual mapping was decided.
    * 
    * @return a URI for the visual mapping decision reported by calling this method.
    */
   public String explainTriple(String subject, String predicate, String object,
                               String actor,
                               String visualForm,
                               String from_domain, String to_domain,
                               String from,        String to,
                               String justification, String description) {

      String decisionURI = getDecisionURI();

      try {

         if( ResourceValueHandler.isURI(visualForm) ) {

            Resource visualFormR = vf.createURI(visualForm);

            add(visualFormR, SIO.hasAttribute, vf.createURI(decisionURI), context);

            if( ResourceValueHandler.isURI(actor)) {
               URI actorR = vf.createURI(actor);
               add(actorR,                      RDF.TYPE,              PROVO.Agent,                 context);
               add(actorR,                      PROVO.hadPlan,         vf.createURI(actor+visUUID), context);
               add(vf.createURI(actor+visUUID), RDF.TYPE,              PROVO.Plan,                  context);
               add(vf.createURI(decisionURI),   PROVO.wasAttributedTo, actorR,                      context);
            }

            Resource toR = vf.createURI(this.context.stringValue()+"/graphic/"+to);
            add(visualFormR, VSR.to,             toR,           context); 

            Resource fromR = vf.createURI(this.context.stringValue()+"/graphic/"+from);
            add(fromR,       SIO.hasAttribute,   visualFormR,   context);	
            add(fromR,       VSR.relatesTo,      toR,           context);  
            add(visualFormR, RDF.TYPE,           SIO.Attribute, context);
            add(visualFormR, SIO.refersTo,       toR,           context);
         }

         add(vf.createURI(decisionURI), DCTerms.description, vf.createLiteral(description.replaceAll("^ *","")), context);

         if( commitInterval > 0 && decisionCount % commitInterval == 0 ) {
            pconn.commit();
         }
      } catch (RepositoryException e) {
         e.printStackTrace();
      }

      return decisionURI;
   }
   
   /**
    * The transformation has finished. Clean up (i.e., commit and close connection).
    * (If repository was a remote server, the provenance will live there)
    * 
    * Similar to {@link #export()} but does not dump to stderr.
    * 
    * @return the number of triples in the provenance log.
    */
   public long finish() {
      assertDelegationCounts();
      
      long numTriples = 0;
      if( this.usePersistentConn ) {
         try {
            pconn.commit();
            numTriples = pconn.size(context);
            pconn.close();
         } catch (RepositoryException e) {
            e.printStackTrace();
         } finally {
            try {
               pconn.close();
            } catch (RepositoryException e) {
               e.printStackTrace();
            }
         }
      }
      return numTriples;
   }

   /**
    * The transformation has finished. Clean up (i.e., commit and close connection). Dump provenance to the give file path.
    * 
    * @return
    */
   public long export(String dumpFile) {
      FileOutputStream out;
      try {
         out = new FileOutputStream(dumpFile);
         return export(out);
      }catch (FileNotFoundException e) {
         e.printStackTrace();
      }
      return export(System.err);
   }
   
   /**
    * The transformation has finished. Clean up (i.e., commit and close connection). Dump provenance to stderr.
    * 
    * Similar to {@link #finish()} but dumps to stderr.
    * 
    * @return the number of triples in the provenance log.
    */
   public long export() {
      return export(System.err);
   }
   
   /**
    * 
    * @param out
    * @return
    */
   private long export(OutputStream out) {
      
      assertDelegationCounts();

      long numTriples = 0;
      if( this.usePersistentConn ) {
         try {
            System.err.println("# pconn open: " + pconn.isOpen());
            XMLGregorianCalendar now = DateTimeValueHandler.getNowXMLGregorianCalendar();
            if( now != null ) {
               add(context, PROVO.generatedAtTime, vf.createLiteral(now), context);
               add(this.generatingActivity, PROVO.endedAtTime, vf.createLiteral(now), context);
            }
            pconn.setNamespace("vsr",        VSR.BASE_URI);
            pconn.setNamespace("rdfs",       RDFS.NAMESPACE);
            pconn.setNamespace(PROVO.PREFIX, PROVO.BASE_URI);
            pconn.setNamespace("xsd",        XMLSchema.NAMESPACE);
            pconn.setNamespace("dcterms",    DCTerms.BASE_URI);
            pconn.setNamespace(SIO.PREFIX,   SIO.BASE_URI);

            pconn.commit();
            numTriples = pconn.size(context);
            if( out != null ) {
               pconn.export(Constants.handlerForFileExtension("ttl", out));
            }
            pconn.close();
         }catch (RepositoryException e) {
            e.printStackTrace();
         }catch (RDFHandlerException e) {
            e.printStackTrace();
         }finally {
            try {
               pconn.close();
            }catch (RepositoryException e) {
               e.printStackTrace();
            }
         }
      }
      return numTriples;
   }

   
   /**
    * 
    */
   private void assertDelegationCounts() {
   
      for( String delegation : this.delegations.keySet() ) {
         URI delegate  = vf.createURI(delegation.replaceAll(" .*", ""));
         URI delegator = vf.createURI(delegation.replaceAll(".* ", ""));
         
         URI delegationR = vf.createURI(context+"/delegation/"+NameFactory.getMD5(delegation));
         
         //System.err.println("# " + delegate + " acted on behalf of " + delegator + " " + this.delegations.get(delegation));
         try {
            add(delegate,    RDF.TYPE,                  PROVO.Agent,      context);
            add(delegate,    PROVO.actedOnBehalfOf,     delegator,        context);
            add(delegate,    PROVO.qualifiedDelegation, delegationR,      context);
            add(delegator,   RDF.TYPE,                  PROVO.Agent,      context);
            add(delegationR, RDF.TYPE,                  PROVO.Delegation, context);
            add(delegationR, PROVO.agent,               delegator,        context);
            add(delegationR, SIO.count,                 vf.createLiteral(this.delegations.get(delegation)), context);
         } catch (RepositoryException e) {
            e.printStackTrace();
         }
      }   
   }
   
   
   public static final String USAGE = "usage: VisualizationDecisions serverURL repositoryID [reportContext]";
   /**
    * 
    * @param args
    */
   public static void main(String args[]) {
      if( args.length < 2 || args.length > 3 ) {
         System.err.println(USAGE);
         System.exit(1);
      }

      VisualizationDecisions log = null;
      if( args.length == 2 ) {
         log = new VisualizationDecisions(args[0],args[1]);
      }else {
         log = new VisualizationDecisions(args[0],args[1],args[2]);
      }
      log.explain(VSR.name("sub"), 
                  VSR.nameProperty("pred"), 
                  VSR.name("obj"), 
                  VSR.name("Default_statement_handler"), 
                  VSR.name("Draw_resource_statement_literally"), 
                  VSR.name("because_Im_your_mom"),"because I'm your mom");
   }
}