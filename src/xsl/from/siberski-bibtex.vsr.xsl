<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"

   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:con="http://www.w3.org/2000/10/swap/pim/contact#"
   xmlns:frbr="http://purl.org/vocab/frbr/core#"
   xmlns:ov="http://open.vocab.org/terms/"
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:dce="http://purl.org/dc/elements/1.1/"
   xmlns:foaf="http://xmlns.com/foaf/0.1/"
   xmlns:dcat="http://www.w3.org/ns/dcat#"
   xmlns:void="http://rdfs.org/ns/void#"
   xmlns:sd="http://www.w3.org/ns/sparql-service-description#"
   xmlns:datafaqs="http://purl.org/twc/vocab/datafaqs#"
   xmlns:prov="http://www.w3.org/ns/prov#"
   xmlns:bte="http://purl.org/twc/vocab/between-the-edges/"
   xmlns:qb="http://purl.org/linked-data/cube#"
   xmlns:sio="http://semanticscience.org/resource/"
   xmlns:nfo="http://www.semanticdesktop.org/ontologies/nfo/#"
   xmlns:pmlp="http://inference-web.org/2.0/pml-provenance.owl#"
   xmlns:pmlj="http://inference-web.org/2.0/pml-justification.owl#"
   xmlns:pmlt="http://inference-web.org/2.0/pml-trust.owl#"
   xmlns:bibo="http://purl.org/ontology/bibo/"
   xmlns:skos="http://www.w3.org/2004/02/skos/core#"
   xmlns:rev="http://purl.org/stuff/rev#"
   xmlns:tag="http://www.holygoat.co.uk/owl/redwood/0.1/tags/"


   xmlns:vsr="http://purl.org/twc/vocab/vsr#"
   xmlns:jvr="jvr"
   xmlns:nmf="java:edu.rpi.tw.string.NameFactory"
   xmlns:idm="java:edu.rpi.tw.string.IDManager"
   xmlns:log="java:edu.rpi.tw.visualization.log.VisualizationDecisions"

   xmlns:acv="accountable visualization"
   xmlns:pmap="edu.rpi.tw.string.pmm.DefaultPrefixMappings"
   xmlns:xutil="https://github.com/timrdf/vsr/tree/master/src/xsl/util"
   xmlns:xsdabv="https://github.com/timrdf/vsr/tree/master/src/xsl/util/xsd-datatype-abbreviations.xsl"
   xmlns:pmm="edu.rpi.tw.string.pmm"
   xmlns:xfm="transform namespace">

<!-- Import the core RDF visual strategy. -->
<xsl:import href="../from/rdf2.xsl"/>
<xsl:import href="../from/rdf-abbrev.xsl"/>

<!-- XSLTDoc this visual strategy -->
<xd:doc type="stylesheet">
   <xd:short></xd:short>
   <xd:detail>See <a href="https://github.com/timrdf/vsr/wiki/vsr2.xsl">https://github.com/timrdf/vsr/wiki/vsr2.xsl</a>.
   </xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- Include any new namespaces that your visual strategy involves,
     so that terms in the namespace can be mentioned like:
         $dcterms:isReferencedBy
     Also, the variable e.g. $dcterms represents the namespace 
     itself and $dcterms:ALL is a list of all terms.

     https://github.com/timrdf/vsr/blob/master/src/ns.sh
     can be used to add src/xsl/ns/PREFIX-ns.xsl
     automatically from the prefix (via prefix.cc).
 -->
<xsl:include href="../ns/owl-ns.xsl"/>
<xsl:include href="../ns/dcterms-ns.xsl"/>
<xsl:include href="../ns/dce-ns.xsl"/>
<xsl:include href="../ns/con-ns.xsl"/>
<xsl:include href="../ns/dcat-ns.xsl"/>
<xsl:include href="../ns/void-ns.xsl"/>
<xsl:include href="../ns/skos-ns.xsl"/>
<xsl:include href="../ns/bibo-ns.xsl"/>
<xsl:include href="../ns/foaf-ns.xsl"/>
<xsl:include href="../ns/datafaqs-ns.xsl"/>
<xsl:include href="../ns/sd-ns.xsl"/>
<xsl:include href="../ns/prov-ns.xsl"/>
<xsl:include href="../ns/bte-ns.xsl"/>
<xsl:include href="../ns/qb-ns.xsl"/>
<xsl:include href="../ns/sio-ns.xsl"/>
<xsl:include href="../ns/nfo-ns.xsl"/>
<xsl:include href="../ns/pmlp-ns.xsl"/>
<xsl:include href="../ns/pmlj-ns.xsl"/>
<xsl:include href="../ns/pmlt-ns.xsl"/>
<xsl:include href="../ns/rev-ns.xsl"/>
<xsl:include href="../ns/frbr-ns.xsl"/>
<xsl:include href="../ns/tag-ns.xsl"/>
<xsl:include href="../util/string-chomp.xsl"/>

<!-- 
   These are the properties and classes that appear in the domain graph.
   The visual design process involves deciding what should be done with
   each term that the visualization engine will run in to.
-->

<xsl:variable name="TODO" select="(
)">
</xsl:variable>

<!-- 
   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
   The following variables are passed to the core RDF templates
   and are used to exclude or alter the rendering of the domain form.
   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
-->

<!-- - - - - - - - - - - -->
<!-- Subject strategies -->
<!-- - - - - - - - - - - -->

<!-- SUB-SURFACING STRATEGIES -->

<!-- This is experimental; keep it false. -->
<xsl:variable name="clean-visual-element-minting" select="true()"/>

<!--
   - - - - - - - - - - - - - - - - - - - - - -
   Sometimes, simply excluding a relation can be an effective way to
   simplify the visual artifact. They could be excluded because
   it is not relevant to the visual message, or they could be excluded
   because it is rendered via some other means (such as those listed above).

   "Blacklist" == "negative bertin:elevation" == "prevent from surfacing"
   - - - - - - - - - - - - - - - - - - - - - -
-->

<!-- 
   Do not render visual elements to depict these resources.
-->
<xsl:variable name="TEMPLATE-blacklisted-subjects" select="(
)"/>

<!-- 
   Do not render visual elements to depict resources that are instances of these classes.

   An instances of blacklisted subject classes:
     * Does NOT render a visual element,
     * Does NOT render visual edges for which it is the subject of a triple.
   Note that an instance of a blacklisted subject classes will still render visual edges for which it is the object of a triple.
   To exclude this, make add the calss to TEMPLATE-blacklisted-object-classes.

   $bibo:Document,
-->
<xsl:variable name="TEMPLATE-blacklisted-subject-classes" select="(
   $sio:Attribute,
   'http://openprovenance.org/ontology#WasControlledBy',
   $skos:Concept,
   $frbr:Expression,
   $rev:Review,
   'http://purl.org/stuff/rev#Review',
   'http://moat-project.org/ns#Tag',
   $foaf:Person
)"/>

<!-- 
   Do not render visual elements to depict resources that are named within these namespaces.
-->
<xsl:variable name="TEMPLATE-blacklisted-subject-namespaces" select="(
)"/>



<!-- 
   By default, everything is depicted within the plane.
   Use blacklisting         to push depictions into the sub-surface (and thus, not visible).
   Use elevation strategies to pull depictions into elevated planes (and thus, slightly less important and less efficiently read).
-->



<!-- ELEVATION STRATEGIES -->

<!--
   Use the fill color elevation to avoid encoding rdf:type into the plane.

   If there are many instances of a given class, it can be much more effective
   to color the instances by the class instead of rendering a visual edge
   for the rdf:type relation.
   If there are few enough classes, the type of the instances can be 
   uniquely determined just be observing their visual node's color.
-->
<xsl:variable name="TEMPLATE-class-strategy">
   <visual-form fill-color="1 0.98823529411 0.5294117647">       <!-- Yellow -->
      <class><xsl:value-of select="'http://dbpedia.org/class/yago/Employee-ownedCompanies'"/></class>
   </visual-form>
   <visual-form fill-color="0.62352941176 0.69411764705 0.98823529411"> <!-- Blue -->
      <class><xsl:value-of select="'http://dbpedia.org/class/yago/Employee-ownedCompanies'"/></class>
      <class><xsl:value-of select="''"/></class>
   </visual-form>
   <visual-form fill-color="0.99607843137 0.82745098039 0.49803921568">       <!-- Orange -->
      <class><xsl:value-of select="'http://moat-project.org/ns#Tag'"/></class>
   </visual-form>
   <visual-form fill-color="1 1 .847">                <!-- Yellow -->
      <class><xsl:value-of select="'http://purl.org/vocommons/voaf#VocabularySpace'"/></class>
   </visual-form>
   <visual-form fill-color=".5 .25 .0000 .45"> <!-- Brown -->
      <class><xsl:value-of select="'http://rdfs.org/ns/void#Dataset'"/></class>
      <class><xsl:value-of select="''"/></class>
   </visual-form>
   <visual-form fill-color=".25 .5 0 .45">       <!-- Green -->
      <class><xsl:value-of select="'http://xmlns.com/foaf/0.1/Organization'"/></class>
   </visual-form>
   <visual-form fill-color=".8392 .9882 .8000">       <!-- Green -->
      <class><xsl:value-of select="$foaf:Person"/></class>
   </visual-form>
   <visual-form fill-color="1 0 0 .45">       <!-- Red -->
      <class><xsl:value-of select="$foaf:Organization"/></class>
   </visual-form>
   <visual-form fill-color=".8196 .8196 1.000">       <!-- Blue -->
      <class><xsl:value-of select="'http://purl.org/vocab/frbr/core#Manifestation'"/></class>
   </visual-form>
   <visual-form fill-color="0 0 1 .45">       <!-- Dark Blue -->
      <class><xsl:value-of select="'http://purl.org/vocab/frbr/core#Expression'"/></class>
   </visual-form>
   <visual-form fill-color=".9882 .9451 .8553">       <!-- Peach/Orange -->
      <class><xsl:value-of select="'http://purl.org/stuff/rev#Review'"/></class>
   </visual-form>
   <visual-form fill-color=".8 .8 .8">                <!-- Light Gray -->
      <class><xsl:value-of select="''"/></class>
   </visual-form>
   <visual-form fill-color=".5 .5 .5">                <!-- Gray -->
      <class><xsl:value-of select="$qb:Observation"/></class>
   </visual-form>
   <visual-form fill-color="0 0 0">       <!-- Black -->
      <class><xsl:value-of select="''"/></class>
   </visual-form>
   <visual-form fill-color=".8196 .8196 1.000">       <!-- Blue -->
      <class><xsl:value-of select="$foaf:Person"/></class>
   </visual-form>
   <visual-form fill-color=".8196 .8196 1.000">       <!-- Blue -->
   </visual-form>
   <visual-form fill-color=".77 1 .77">
   </visual-form>
   <visual-form fill-color=".5 0 1">
      <class><xsl:value-of select="''"/></class>
   </visual-form>
   <visual-form fill-color="1 1 .77">
   </visual-form>
   <visual-form fill-color=".770 .790 1">
   </visual-form>
   <visual-form fill-color=".8901 .9019 1">
   </visual-form>
   <visual-form fill-color="1 .6491 .6980">
   </visual-form>
   <visual-form fill-color=".9647 .8353 .8314">       <!-- Pink -->
   </visual-form>
</xsl:variable>

<!--
   Use fill color elevation to convey the distinction of the resource's URI's namespace.

   Sometimes it is important to distinguish instances by the namespace
   of their URIs.
-->
<xsl:variable name="TEMPLATE-namespace-strategy">
   <visual-form fill-color=".77 .79 1"> <!-- Purple -->
      <namespace>http://inference-web.org/registry/</namespace>
   </visual-form>
   <visual-form fill-color=".77 1 .77"> <!-- Green -->
      <namespace>http://rdf.freebase.com/ns/</namespace>
   </visual-form>
   <visual-form fill-color="1 1 .77">   <!-- Yellow -->
      <namespace>a</namespace>
   </visual-form>
   <visual-form fill-color=".8901 .9019 1">
      <namespace>b</namespace>
   </visual-form>
   <visual-form fill-color="1 .6491 .6980">
      <namespace>c</namespace>
   </visual-form>
</xsl:variable>

<!-- 
   If a visual element depicts a resource of any of these classes, 
   do not render the resource's URI/bnodeID at the label elevation.

   Instances of the classes in this list do NOT need to show their 
   URI or bnodeID in their label, presumably because the do not matter (or, are too long).

   Elevate the type into the label.
-->
<xsl:variable name="TEMPLATE-anonymous-instance-classes" select="(
   $prov:Entity,
   'http://purl.org/twc/vocab/conversion/Curl',
   'http://purl.org/twc/vocab/conversion/HTTPHeader',
   'http://openprovenance.org/ontology#WasControlledBy',
   $prov:Quotation,
   $nfo:FileHash,
   $pmlp:SourceUsage,
   $pmlj:InferenceStep,
   $pmlj:NodeSet
)"/>

<!-- 
   If a visual element depicts a resource that is described with one of these predicates,
   use the resource's predicate's value in the label elevation.
   
   Avoids encoding in the plane.

   This variable lists the RDF predicates that serve the role of rdfs:label.
   These predicates will not be rendered as a visual edge, since they appear 
   on their subject's visual node's label.
   If a label is not given, the URI, the URI's curie, or the URI's local name
   may be used.
-->
<xsl:variable name="TEMPLATE-label-predicates" select="(
   $rdfs:label
)"/>

<!--
   If a visual element depicts a resource that is described with one of these predicates,
   use the **predicate and value** in the label elevation.

   Avoids encoding in the plane.

   Often, many values are combined and rendered in the label of a single
   RDF resource's visual node. This saves space in the visual artifact,
   without losing information (as long as the user knows how to interpet
   and disambiguate the combined values).

   e.g. rendering a person's address in their label - instead of rendering
   the full vCard subgraph as visual edges - can be a useful way to save
   space.

   This list of predicates often includes the TEMPLATE-label-predicates
   list, too (since it is a special case of this).
-->
<xsl:variable name="TEMPLATE-in-label-predicates" select="(
   $rdfs:label,
   $sio:count,
   $dcterms:description,
   $dcterms:title,
   $prov:alternateOf,
   $foaf:nick,
   $con:givenName,
   $con:familyName,
   $dce:title,
   $foaf:mbox_sha1sum,
   $foaf:mbox,
   $foaf:lastName,
   $foaf:name,
   $foaf:givenname,
   $foaf:age,
   $foaf:family_name,
   $foaf:title,
   $foaf:myersBriggs,
   $foaf:homepage,
   $foaf:geekcode,
   $foaf:firstName,
   $foaf:familyName,
   $foaf:surname,
   $foaf:gender,
   $foaf:givenName,

   $nfo:fileName,
   $pmlp:hasRawString,
   $dcterms:description,
   $dcterms:modified,
   $nfo:hashAlgorithm,
   $pmlp:hasModificationDateTime,
   $pmlp:hasUsageDateTime,
   $nfo:hashValue,
   $prov:atTime,
   $foaf:accountName,
   $dcterms:identifier,
   $dcterms:date,
   $dcterms:issued,
   $dcterms:modified,
   $bibo:shortTitle,
   'http://purl.org/vocommons/voaf#propertyNumber',
   'http://purl.org/vocommons/voaf#classNumber',
   'http://purl.org/vocab/vann/preferredNamespacePrefix',
   'http://purl.org/vocab/vann/preferredNamespaceUri',
   $owl:versionInfo,
   $tag:name,
   $ov:shortName,
   $void:uriSpace,
   $dce:creator,
   $dce:date
)"/>

<!--
   If a visual element depicts a resource that is described with one of these predicates,
   use the **predicate and value** in the **notes** elevation.

   Avoids encoding in the plane.

   A 'notes' elevation is a contextually-constrained version of the 'label' elevation, which persists across time.
   Time is one aspect of context.

   If it is important to convey values about a resource, but it is not
   necessary to show all values for all resources at the same time,
   then rendering the values in the resource's visual node's notes
   attribute can be an effective strategy.
-->
<xsl:variable name="TEMPLATE-notes-predicates" select="(
   $dcterms:description
)"/>


<!-- 
-->
<xsl:variable name="TEMPLATE-tooltip-predicates" select="(
)"/>


<!--
-->
<xsl:variable name="TEMPLATE-rooted-classes" select="(
)"/>


<!-- - - - - - - - - - - -->
<!-- Predicate strategies -->
<!-- - - - - - - - - - - -->

<!--
   These properties follow the qualification pattern, c.f. PROV-O and SIO
   sio:has-attribute   [ a sio:Attribute, ?other ] is the qualifying property for the binary property ?other.
   prov:qualifiedUsage [ a prov:Usage ]            is the qualifying property for the binary property prov:used.
-->
<xsl:variable name="TEMPLATE-qualifying-predicates" select="(
   $sio:has-attribute,

   $prov:qualifiedUsage,
   $prov:qualifiedQuotation,
   $prov:qualifiedStart,
   $prov:qualifiedEnd,
   $prov:qualifiedInvalidation,
   $prov:qualifiedDelegation,
   $prov:qualifiedAttribution,
   $prov:qualifiedRevision,
   $prov:qualifiedPrimarySource,
   $prov:qualifiedDerivation,
   $prov:qualifiedAssociation,
   $prov:qualifiedGeneration,
   $prov:qualifiedCommunication,
   $prov:qualifiedInfluence
)"/>
<xsl:variable name="TEMPLATE-qualification-classes" select="(
   $prov:Influence,

   $prov:EntityInfluence,
   $prov:Start,
   $prov:Usage,
   $prov:Derivation,
   $prov:Revision,
   $prov:PrimarySource,
   $prov:Quotation,
   $prov:End,

   $prov:ActivityInfluence,
   $prov:Generation,
   $prov:Communication,
   $prov:Invalidation,
   $prov:Attribution,

   $prov:AgentInfluence,
   $prov:Association,
   $prov:Delegation
)"/>
<xsl:variable name="TEMPLATE-qualified-object-predicates" select="(
   $sio:refers-to,

   $prov:entity,
   $prov:agent,
   $prov:activity
)"/>


<!-- SUB-SURFACING STRATEGIES -->

<xsl:variable name="TEMPLATE-blacklisted-predicates" select="(
   'http://openprovenance.org/ontology#endTime',
   'http://openprovenance.org/ontology#effect',
   'http://openprovenance.org/ontology#cause',
   'http://purl.org/net/provenance/ns#involvedActor',
   'http://obofoundry.org/ro/ro.owl#has_agent',
   $pmlj:hasIndex,
   $dcterms:creator,
   $bibo:doi,
   $sio:has-member,
   $dcterms:subject,
   $skos:broader,
   $frbr:realization,
   $rev:hasReview,
   $dcterms:language,
   $rev:text,
   $dcterms:publisher,
   $rdfs:isDefinedBy,
   $rdfs:seeAlso,
   $frbr:embodiment
)"/>

<xsl:variable name="TEMPLATE-blacklisted-predicate-namespaces" select="(
)"/>

<!--
   These predicates should not be shown b/c they are redundant with their inverses.
   This list can include binary predicates or their qualification classes.
-->
<xsl:variable name="TEMPLATE-preferred-inverses">
   <undesirable-inverse     about="{$prov:hadDelegate}">
      <preferred-inverse resource="{$prov:actedOnBehalfOf}"/>
   </undesirable-inverse>
</xsl:variable>

<!-- SURFACE STRATEGIES -->

<!--
   Although a visual edge may have arrow heads to indicate direction,
   the underlying edge may have a "force" directionality that aligns or
   opposes this induced directionality.
   The "force" directionality of a visual edge affects automated
   layout algorithms.
   Choosing the "force directionality" of each domain relation's
   visual edge can result in more intuitive graph layouts.
-->
<xsl:variable name="TEMPLATE-swap-directionality-predicates" select="(
   $rdfabbr-swap-directionality-predicates,
   $prov:wasDerivedFrom,
   $prov:generatedAtTime,
   concat($rdf,'type'),
   $pmlj:hasConclusion,
   $nfo:hasHash,
   $skos:broader,
   $dcterms:subject
)"/>

<!-- - - - - - - - - - - -->
<!-- Object strategies -->
<!-- - - - - - - - - - - -->

<!-- SUB-SURFACING STRATEGIES -->

<xsl:variable name="TEMPLATE-blacklisted-objects" select="(
   $rdfabbr-blacklisted-objects,
   $TEMPLATE-class-strategy/visual-form/class/text(), $TEMPLATE-anonymous-instance-classes,
   $pmlp:Information,
   $pmlj:InferenceStep,
   $pmlj:NodeSet,
   $pmlp:InferenceEngine,
   $nfo:FileDataObject
)"/>

<!-- 
   An instance of blacklisted object classes:
     * Does NOT render a visual element,
       (Note that an instance of a blacklisted object classes will still render visual edges for which it is the object of a triple.
        To exclude this, make add the calss to TEMPLATE-blacklisted-subject-classes.)
     * Does NOT render visual edges for which it is the object of a triple.
-->
<xsl:variable name="TEMPLATE-blacklisted-object-classes" select="(
   'http://openprovenance.org/ontology#WasControlledBy',
   $bibo:Document,
   $skos:Concept,
   $frbr:Expression,
   'http://moat-project.org/ns#Tag',
   $foaf:Person,
   $foaf:Organization
)"/>

<!--
-->
<xsl:variable name="TEMPLATE-blacklisted-object-namespaces" select="(
)"/>

<!-- SURFACE STRATEGIES -->

<!--
-->
<xsl:variable name="TEMPLATE-namespaces-to-relax-in-ranges" select="(
)"/>

<!-- 
   Instances of the following classes render a distinct visual element
   for each of its occurrences as an object of a data triple.
-->
<xsl:variable name="TEMPLATE-relaxed-object-classes" select="(
)"/>

<!-- 
   If a predicate is rendered as a visual edge, it can be useful to
   mint new visual nodes for every occurrence of the triple's object.
   This will increase the planarity of the resulting visual graph.
-->
<xsl:variable name="TEMPLATE-namespaces-to-relax" select="(
   $xs,
   $rdf
)"/>

<!--
   Explicit list of literals. More specific than TEMPLATE-relax-identical-literals.
-->
<xsl:variable name="TEMPLATE-literals-to-relax" select="(
)"/>

<!--
   Boolean. Do it for all literals.
-->
<xsl:variable name="TEMPLATE-relax-identical-literals" select="(
)"/>


<!-- This template handles all resources. -->
<!--xsl:template match="rdf:Description[@rdf:about | @rdf:nodeID]" mode="visual-element"-->
<xsl:template match="@rdf:about | @rdf:resource | @rdf:nodeID | @rdf:ID">
   <xsl:param name="deferrer" select="''"/>

   <!-- The URI for _this_ template, and its type. -->
   <xsl:variable name="owl:sameAs" select="concat($rl,'TEMPLATE_subject_visual_form_factory_default_620')"/>
   <xsl:variable name="rdf:type"   select="$vsr:VisualElementFactory"/>

   <!-- Orient with the resource that we're considering to render, and log it. -->
   <xsl:variable name="resource"   select="."/>
   <xsl:message select="acv:arriveResource($owl:sameAs,$resource,$deferrer)"/>

   <!-- Elements for all property/value pairs describing this subject -->
   <xsl:variable name="s"          select="key('descriptions-by-subject',$resource)"/> 
   <xsl:variable name="o"          select="key('descriptions-by-object', $resource)"/> 

   <!-- Gather certain properties -->
   <xsl:variable name="rdf-types"        select="$s/rdf:type/@rdf:resource"/>
   <xsl:variable name="void-triples"     select="$s/void:triples/text()"/>

   <!-- Classify domain form -->

   <!-- Determine visual properties based on classifications -->
   <!--xsl:variable name="label">
      <xsl:variable name="plural" select="if (number($s/sio:count[1]) gt 1) then 's' else ''"/>
      <xsl:choose>
      <xsl:when test="$vsr:TypedLiteralObjectDataset = $rdf-types">     
         <xsl:variable name="type"   select="$s/owl:hasValue/@rdf:resource"/>
         <xsl:choose>
            <xsl:when test="$type">
               <xsl:variable name="value"  select="concat($s/sio:count[1],' literal',$plural,' typed ',pmm:tryQName($type))"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,'label',string($value),'$visual-form-uri','consolidate 3 triples to a label.')"/> 
               <xsl:value-of select="$value"/>  
            </xsl:when>
            <xsl:otherwise>
               <xsl:variable name="value" select="concat($s/sio:count[1],' untyped literal',$plural)"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,'label',string($value),'$visual-form-uri','consolidate 3 triples to a label.')"/> 
               <xsl:value-of select="$value"/>  
            </xsl:otherwise>
         </xsl:choose>
      </xsl:when>
      <xsl:when test="$vsr:TypedLiteralObjectsValueDataset = $rdf-types">     
         <xsl:variable name="type"   select="key('descriptions-by-subject',
                                                 $o[void:subset[@rdf:resource=$resource]]/(@rdf:about|@rdf:nodeID|@rdf:ID))
                                             /owl:hasValue/@rdf:resource"/>
         <xsl:variable name="literal" select="xutil:chomp($s/owl:hasValue)"/>
         <xsl:choose>
            <xsl:when test="$type">
               <xsl:variable name="value"  select="concat($s/sio:count[1],' occurrence',$plural,' of ',pmm:tryQName($type),' ',$DQ,$literal,$DQ)"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,'label',string($value),'$visual-form-uri','consolidate 3 triples to a label.')"/> 
               <xsl:value-of select="$value"/>  
            </xsl:when>
            <xsl:otherwise>
               <xsl:variable name="value"  select="concat($s/sio:count[1],' occurrence',$plural,' of untyped ',$DQ,$literal,$DQ)"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,'label',string($value),'$visual-form-uri','consolidate 3 triples to a label.')"/> 
               <xsl:value-of select="$value"/>  
            </xsl:otherwise>
         </xsl:choose>
      </xsl:when>
      <xsl:when test="$vsr:PredicateOccurrenceDataset = $rdf-types">     
         <xsl:variable name="type"   select="$s/owl:hasValue/@rdf:resource"/>
         <xsl:variable name="value"  select="concat($s/sio:count[1],' occurrence',$plural,' of the ',pmm:tryQName($type),' predicate')"/>
         <xsl:message select="acv:explainResource($resource,$owl:sameAs,'label',string($value),'$visual-form-uri','consolidate 3 triples to a label.')"/> 
         <xsl:value-of select="$value"/>  
      </xsl:when>
      <xsl:when test="$sd:NamedGraph = $rdf-types">     
         <xsl:variable name="value" select="concat('GRAPH named ',$NL,$s/sd:name[1]/@rdf:resource,$NL,' at ',$s/prov:hadLocation[1]/@rdf:resource)"/>
         <xsl:message select="acv:explainResource($resource,$owl:sameAs,'label',$value,'$visual-form-uri','consolidate 3 triples to a label.')"/> 
         <xsl:value-of select="$value"/>  
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="''"/>  
         <xsl:message select="acv:explainResource($resource,$owl:sameAs,'label','','$visual-form-uri','xsl:otherwise')"/> 
      </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="shape">
      <xsl:choose>
      <xsl:when test="$dcat:Dataset = $rdf-types">     
         <xsl:value-of select="'Circle'"/>  
         <xsl:message select="acv:explainResource($resource,$owl:sameAs,'shape','Circle','$visual-form-uri','a dcat:Dataset')"/> 
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="''"/>  
         <xsl:message select="acv:explainResource($resource,$owl:sameAs,'shape','Rectangle','$visual-form-uri','xsl:otherwise')"/> 
      </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="height">
      <xsl:choose>
      <xsl:when test="$dcat:Dataset = $rdf-types and string-length($void-triples)">     
         <xsl:variable name="value" select="'30'"/>
         <xsl:value-of select="$value"/>  
         <xsl:message select="acv:explainResource($resource,$owl:sameAs,'height',string($value),'$visual-form-uri','a dcat:Dataset')"/> 
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="''"/>  
         <xsl:message select="acv:explainResource($resource,$owl:sameAs,'height','','$visual-form-uri','xsl:otherwise')"/> 
      </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="fit-text">
      <xsl:choose>
      <xsl:when test="$dcat:Dataset = $rdf-types and string-length($void-triples)">     
         <xsl:variable name="value" select="'Overflow'"/>
         <xsl:value-of select="$value"/>  
         <xsl:message select="acv:explainResource($resource,$owl:sameAs,'fit-text',$value,'$visual-form-uri','a dcat:Dataset')"/> 
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="''"/>  
         <xsl:message select="acv:explainResource($resource,$owl:sameAs,'fit-text','','$visual-form-uri','xsl:otherwise')"/> 
      </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="draw-stroke">
      <xsl:choose>
      <xsl:when test="$dcat:Dataset = $rdf-types and string-length($void-triples)">     
         <xsl:variable name="value" select="true()"/>
         <xsl:value-of select="$value"/>  
         <xsl:message select="acv:explainResource($resource,$owl:sameAs,'draw-stroke','true','$visual-form-uri','a dcat:Dataset')"/> 
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="''"/>  
         <xsl:message select="acv:explainResource($resource,$owl:sameAs,'draw-stroke','','$visual-form-uri','xsl:otherwise')"/> 
      </xsl:otherwise>
      </xsl:choose>
   </xsl:variable-->

   <!-- Invoke the core template with the visual properties determined by this template. -->
   <xsl:apply-templates select="../dot" mode="default">
      <xsl:with-param name="deferrer"                      select="$owl:sameAs"/>

      <xsl:with-param name="blacklisted-subject-classes"   select="$TEMPLATE-blacklisted-subject-classes" tunnel="yes"/>
      <!--xsl:with-param name="view-context"                  select="$TEMPLATE-view-context" tunnel="yes"/-->
      <xsl:with-param name="namespaces-to-relax"           select="$TEMPLATE-namespaces-to-relax" tunnel="yes"/>
      <!--xsl:with-param name="namespaces-to-relax-in-ranges" select=""/-->

      <xsl:with-param name="class-strategy"                select="$TEMPLATE-class-strategy"      tunnel="yes"/>
      <xsl:with-param name="namespace-strategy"            select="$TEMPLATE-namespace-strategy"  tunnel="yes"/>

      <xsl:with-param name="anonymous-instance-classes"    select="$TEMPLATE-anonymous-instance-classes" tunnel="yes"/>
      <xsl:with-param name="label-predicates"              select="$TEMPLATE-label-predicates"    tunnel="yes"/>
      <xsl:with-param name="in-label-predicates"           select="$TEMPLATE-in-label-predicates" tunnel="yes"/>
      <!--xsl:with-param name="show-bnode-IDs" select="true()"/-->

      <xsl:with-param name="notes-predicates"              select="$TEMPLATE-notes-predicates"    tunnel="yes"/>

      <xsl:with-param name="tooltip-predicates"            select="$TEMPLATE-tooltip-predicates"  tunnel="yes"/>
      <xsl:with-param name="rooted-classes"                select="$TEMPLATE-rooted-classes"      tunnel="yes"/>

      <!-- a-root  tunnel="yes"-->
      <!--xsl:with-param name="label"       select="$label"       tunnel="yes"/>
      <xsl:with-param name="fill-color" select="" tunnel="yes"/>
      <xsl:with-param name="stroke-color2" select="" tunnel="yes"/>
      <xsl:with-param name="shape"       select="$shape"       tunnel="yes"/>
      <xsl:with-param name="height"      select="$height"      tunnel="yes"/>
      <xsl:with-param name="width"      select="$width"      tunnel="yes"/>
      <xsl:with-param name="fit-text"    select="$fit-text"    tunnel="yes"/>
      <xsl:with-param name="draw-stroke" select="$draw-stroke" tunnel="yes"/-->
   </xsl:apply-templates>
</xsl:template>

<!-- This template handles all properties that do not apply to any other template. -->
<xsl:template match="rdf:Description/*" priority="-.25">
   <xsl:param    name="deferrer"   select="''"/>

   <!-- The URI for _this_ template, and its type. -->
   <xsl:variable name="owl:sameAs" select="'TEMPLATE_Cleanup_crew_824'"/>
   <xsl:variable name="rdf:type"   select="$vsr:CleanupCrew"/>

   <!-- Orient with the triple that we're considering to render, and log it. -->
   <xsl:variable name="subject"   select="vsr:getSubject(.)"/>
   <xsl:variable name="predicate" select="xfm:uri(.)"/>
   <xsl:variable name="object"    select="vsr:getObject(.)"/>
   <xsl:message                   select="acv:arriveTriple($owl:sameAs,$subject,$predicate,$object,$deferrer)"/>

   <!--
      <entity/c4e4eb06-03a5-4b24-9b77-a9fce632502f>
         sio:has-attribute <relationship/e712752f-8b74-4c7a-8afc-fad91d8f1b2e> .     < - - - - - - - - -
                           <relationship/e712752f-8b74-4c7a-8afc-fad91d8f1b2e>
                              a sio:Attribute, <java:com.boeing.compass.process.activity.relationship.PerformedBy>;
                              sio:refers-to <entity/3af58f9e-9418-4c0f-a18a-4d8064f67efb>;
                              a <java:com.boeing.compass.process.activity.relationship.PerformedBy>;
   -->

   <!-- Elements for all property/value pairs describing this subject -->
   <xsl:variable name="parent"     select="key('descriptions-by-object', $subject)"/> 
   <xsl:variable name="s"          select="key('descriptions-by-subject',$subject)"/> 
   <xsl:variable name="o"          select="key('descriptions-by-subject',$object)"/> 

   <!-- Handling qualifications -->
   <xsl:variable name="q-parents"  select="key('descriptions-by-object', $parent/*[xfm:uri(.) = $TEMPLATE-qualified-object-predicates]/../@rdf:about)"/> 
   <xsl:variable name="q-ps"       select="key('descriptions-by-subject',$q-parents/@rdf:about)"/>
   <xsl:variable name="q-object"   select="$o/*[xfm:uri(.) = $TEMPLATE-qualified-object-predicates]/(@rdf:resource | */rdf:about)[1]"/>
   <xsl:variable name="q-o"        select="key('descriptions-by-subject',$q-object)"/>

   <!--xsl:for-each select="$:TaskTypes">
      <xsl:message select="concat('task types     ',.)"/>
   </xsl:for-each>

   <xsl:for-each select="$:ResourceTypes">
      <xsl:message select="concat('resource types ',.)"/>
   </xsl:for-each>

   <xsl:for-each-group select="$parent" group-by="@rdf:about">
      <xsl:message select="concat('parent  ',current-grouping-key())"/>
   </xsl:for-each-group>

   <xsl:for-each select="$parent/*">
      <xsl:message select="concat(' - -  ',../@rdf:about,' ',xfm:uri(.),' ',@rdf:resource)"/>
   </xsl:for-each>

   <xsl:for-each-group select="$q-parents" group-by="@rdf:about">
      <xsl:message select="concat('q-parent  ',current-grouping-key())"/>
   </xsl:for-each-group-->

   <!--xsl:for-each select="$q-ps/*">
      <xsl:message select="concat('q-ps  ',../@rdf:about,' ',xfm:uri(.),' ',@rdf:resource)"/>
   </xsl:for-each-->

   <!--xsl:for-each-group select="$s/*" group-by="xfm:uri(.)">
      <xsl:message select="concat('subject has property  ',current-grouping-key())"/>
   </xsl:for-each-group>

   <xsl:for-each-group select="$o/*" group-by="xfm:uri(.)">
      <xsl:message select="concat('object has property  ',current-grouping-key())"/>
   </xsl:for-each-group>

   <xsl:for-each-group select="$s/rdf:type" group-by="@rdf:resource">
      <xsl:message select="concat('subject a  ',current-grouping-key())"/>
   </xsl:for-each-group>

   <xsl:for-each-group select="$o/rdf:type" group-by="@rdf:resource">
      <xsl:message select="concat('object a   ',current-grouping-key())"/>
   </xsl:for-each-group>

   <xsl:for-each-group select="$q-o/rdf:type" group-by="@rdf:resource">
      <xsl:message select="concat('q-object a ',current-grouping-key())"/>
   </xsl:for-each-group-->

   <!--xsl:variable name="parent-a-task"      select="$q-ps/rdf:type[@rdf:resource = $:TaskTypes]"/>
   <xsl:variable name="subject-a-task"     select="$s/rdf:type[@rdf:resource = $:TaskTypes]"/>
   <xsl:variable name="subject-a-resource" select="$s[rdf:type[@rdf:resource = $:ResourceTypes]]"/>
   <xsl:variable name="object-a-resource"  select="($o | $q-o)/rdf:type[@rdf:resource = $:ResourceTypes]"/>
   <xsl:variable name="object-a-task"      select="($o | $q-o)/rdf:type[@rdf:resource = $:TaskTypes]"/>

   <xsl:if test="$subject-a-task and $object-a-resource">
      <xsl:message select="concat('         depth 1;','')"/>
      <xsl:message select="concat('         subject view-context: nil','')"/>
      <xsl:message select="concat('         object  view-context: subject/task: ',$subject)"/>
      <xsl:apply-templates select="." mode="view-contextualized">
         <xsl:with-param name="object-view-context" select="$subject" tunnel="yes"/>
      </xsl:apply-templates>
   </xsl:if>
   <xsl:if test="$parent-a-task and $subject-a-resource and $object-a-resource">
      <xsl:variable name="triple" select="."/>
      <!- Loop over parent-a-task ->
      <xsl:for-each-group select="$q-ps" group-by="@rdf:about">
         <xsl:message select="concat('         depth 2;','')"/>
         <xsl:message select="concat('         subject view-context    ', current-grouping-key())"/>
         <xsl:message select="concat('         object  view-context ^+ ',$subject-a-resource[1]/@rdf:about)"/>
         <xsl:apply-templates select="$triple" mode="view-contextualized">
            <xsl:with-param name="subject-view-context" select="current-grouping-key()"                                               tunnel="yes"/>
            <xsl:with-param name="object-view-context"  select="concat(current-grouping-key(),' ',$subject-a-resource[1]/@rdf:about)" tunnel="yes"/>
         </xsl:apply-templates>
      </xsl:for-each-group>
   </xsl:if>
   <xsl:if test="$subject-a-task and $object-a-task"-->
      <xsl:apply-templates select="." mode="view-contextualized"/>
   <!--/xsl:if-->
</xsl:template>

<xsl:template match="rdf:Description/*" priority="-.25" mode="view-contextualized">
   <xsl:param    name="deferrer"   select="''"/>
   <!-- The URI for _this_ template, and its type. -->
   <xsl:variable name="owl:sameAs" select="'TEMPLATE_view-contextualized_950'"/>
   <xsl:variable name="rdf:type"   select="'blah'"/>

   <!-- Orient with the triple that we're considering to render, and log it. -->
   <xsl:variable name="subject"   select="vsr:getSubject(.)"/>
   <xsl:variable name="predicate" select="xfm:uri(.)"/>
   <xsl:variable name="object"    select="vsr:getObject(.)"/>
   <xsl:message                   select="acv:arriveTriple($owl:sameAs,$subject,$predicate,$object,$deferrer)"/>

   <!-- We don't apply any logic in this default template, 
        but we pass down the visual strategy parameters to the core RDF templates. -->
   <xsl:apply-templates select="." mode="blacklist_checker">

      <!-- Predicates in these lists are rendered in forms other than visual edges -->
      <xsl:with-param name="anonymous-instance-classes"       select="$TEMPLATE-anonymous-instance-classes"     tunnel="yes"/>
      <xsl:with-param name="class-strategy"                   select="$TEMPLATE-class-strategy"                 tunnel="yes"/>
      <xsl:with-param name="namespace-strategy"               select="$TEMPLATE-namespace-strategy"/>
      <xsl:with-param name="label-predicates"                 select="$TEMPLATE-label-predicates"               tunnel="yes"/>
      <xsl:with-param name="in-label-predicates"              select="$TEMPLATE-in-label-predicates"            tunnel="yes"/>
      <xsl:with-param name="notes-predicates"                 select="$TEMPLATE-notes-predicates"               tunnel="yes"/>

      <!-- Alter the characteristics of the visual edges that remain. -->
      <xsl:with-param name="swap-directionality-predicates"   select="$TEMPLATE-swap-directionality-predicates" tunnel="yes"/>

      <!-- Predicates in these lists are rendered in forms other than visual edges, or are simply excluded. -->
      <xsl:with-param name="blacklisted-subjects"             select="$TEMPLATE-blacklisted-subjects"                       />
      <xsl:with-param name="blacklisted-subject-namespaces"   select="$TEMPLATE-blacklisted-subject-namespaces"             />
      <xsl:with-param name="blacklisted-subject-classes"      select="$TEMPLATE-blacklisted-subject-classes"    />
      <xsl:with-param name="qualifying-predicates"            select="$TEMPLATE-qualifying-predicates"          tunnel="yes"/>
      <xsl:with-param name="qualification-classes"            select="$TEMPLATE-qualification-classes"          tunnel="yes"/>
      <xsl:with-param name="qualified-object-predicates"      select="$TEMPLATE-qualified-object-predicates"    tunnel="yes"/>
      <xsl:with-param name="blacklisted-predicates"           select="$TEMPLATE-blacklisted-predicates"/>
      <xsl:with-param name="preferred-inverses"               select="$TEMPLATE-preferred-inverses"                         />
      <xsl:with-param name="blacklisted-predicate-namespaces" select="$TEMPLATE-blacklisted-subject-namespaces"             />
      <xsl:with-param name="blacklisted-objects"              select="$TEMPLATE-blacklisted-objects"                        />
      <xsl:with-param name="blacklisted-object-classes"       select="$TEMPLATE-blacklisted-object-classes"                 />
      <xsl:with-param name="blacklisted-object-namespaces"    select="()"                                                   />
      <xsl:with-param name="relaxed-object-classes"           select="$TEMPLATE-relaxed-object-classes"         tunnel="yes"/>
      <xsl:with-param name="namespaces-to-relax"              select="$TEMPLATE-namespaces-to-relax"            tunnel="yes"/> <!-- TODO: rename to relaxed-namespaces -->
   </xsl:apply-templates>
</xsl:template>

</xsl:transform>
