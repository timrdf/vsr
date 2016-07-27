<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:math="java:java.lang.Math"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:void="http://rdfs.org/ns/void#"
   xmlns:datafaqs="http://purl.org/twc/vocab/datafaqs#"
   xmlns:foaf="http://xmlns.com/foaf/0.1/"
   xmlns:dcat="http://www.w3.org/ns/dcat#"
   xmlns:sd="http://www.w3.org/ns/sparql-service-description#"
   xmlns:fn="http://www.w3.org/2005/xpath-functions"
   xmlns:ov="http://open.vocab.org/terms/"
   xmlns:tag="http://www.holygoat.co.uk/owl/redwood/0.1/tags/"
   xmlns:prov="http://www.w3.org/ns/prov#"

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
<xsl:include href="../ns/dcterms-ns.xsl"/>
<xsl:include href="../ns/dcat-ns.xsl"/>
<xsl:include href="../ns/void-ns.xsl"/>
<xsl:include href="../ns/foaf-ns.xsl"/>
<xsl:include href="../ns/prov-ns.xsl"/>
<xsl:include href="../ns/datafaqs-ns.xsl"/>
<xsl:include href="../ns/sd-ns.xsl"/>
<xsl:include href="../ns/tag-ns.xsl"/>
<xsl:include href="../util/scale255.xsl"/>

<!--
   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   The following variables are passed to the core RDF templates
   and are used to exclude or alter the rendering of the domain form.
   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-->

<!--
   If there are many instances of a given class, it can be much more effective
   to color the instances by the class instead of rendering a visual edge
   for the rdf:type relation.
   If there are few enough classes, the type of the instances can be
   uniquely determined just be observing their visual node's color.
-->
<xsl:variable name="LINKSETS-class-strategy">
   <visual-form fill-color=".9647 .8353 .8314">       <!-- Pink -->
      <class><xsl:value-of select="$void:Linkset"/></class>
   </visual-form>
   <visual-form fill-color=".5020 .2510 .0000 .2500"> <!-- Brown -->
      <class><xsl:value-of select="$datafaqs:CKANGroup"/></class>
   </visual-form>
   <visual-form fill-color=".8392 .9882 .8000" shape="{$vsr:Circle}">  <!-- Green -->
      <class><xsl:value-of select="$dcat:Dataset"/></class>
   </visual-form>
   <visual-form fill-color=".9882 .9451 .8553">       <!-- Peach/Orange -->
      <class><xsl:value-of select="$datafaqs:CKANDataset"/></class>
   </visual-form>
   <visual-form fill-color="1 1 .847">                <!-- Yellow -->
      <class><xsl:value-of select="''"/></class>
   </visual-form>
   <visual-form fill-color=".8 .8 .8">                <!-- Light Gray -->
      <class><xsl:value-of select="''"/></class>
   </visual-form>
   <visual-form fill-color=".5 .5 .5">                <!-- Gray -->
      <class><xsl:value-of select="''"/></class>
   </visual-form>
   <visual-form fill-color=".8196 .8196 1.000">       <!-- Blue -->
      <class><xsl:value-of select="''"/></class>
   </visual-form>
   <visual-form fill-color=".77 1 .77">
      <class><xsl:value-of select="'z'"/></class>
   </visual-form>
   <visual-form fill-color="1 1 .77">
      <class><xsl:value-of select="'q'"/></class>
   </visual-form>
   <visual-form fill-color=".770 .790 1">
      <class><xsl:value-of select="'a'"/></class>
   </visual-form>
   <visual-form fill-color=".8901 .9019 1">
      <class><xsl:value-of select="'b'"/></class>
   </visual-form>
   <visual-form fill-color="1 .6491 .6980">
      <class><xsl:value-of select="'c'"/></class>
   </visual-form>
</xsl:variable>

<!--
   Sometimes it is important to distinguish instances by the namespace
   of their URIs.
-->
<xsl:variable name="LINKSETS-namespace-strategy">
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

<xsl:variable name="LINKSETS-anonymous-instance-classes" select="(
)"/>

<!--
   This variable lists the RDF predicates that serve the role of rdfs:label.
   These predicates will not be rendered as a visual edge, since they appear
   on their subject's visual node's label.
   If a label is not given, the URI, the URI's curie, or the URI's local name
   may be used.
-->
<xsl:variable name="LINKSETS-label-predicates" select="(
)"/>

<!--
   Often, many values are combined and rendered in the label of a single
   RDF resource's visual node. This saves space in the visual artifact,
   without losing information (as long as the user knows how to interpet
   and disambiguate the combined values).

   e.g. rendering a person's address in their label - instead of rendering
   the full vCard subgraph as visual edges - can be a useful way to save
   space.

   This list of predicates often includes the LINKSETS-label-predicates
   list, too (since it is a special case of this).
-->
<xsl:variable name="LINKSETS-in-label-predicates" select="(
   $rdfs:label,
   $rdf:value
)"/>

<!--
   If it is important to convey values about a resource, but it is not
   necessary to show all values for all resources at the same time,
   then rendering the values in the resource's visual node's notes
   attribute can be an effective strategy.
-->
<xsl:variable name="LINKSETS-notes-predicates" select="(
   $dcterms:description
)"/>


<!--
-->
<xsl:variable name="LINKSETS-tooltip-predicates" select="(
)"/>


<!--
-->
<xsl:variable name="LINKSETS-rooted-classes" select="(
)"/>

<!--
   Although a visual edge may have arrow heads to indicate direction,
   the underlying edge may have a "force" directionality that aligns or
   opposes this induced directionality.
   The "force" directionality of a visual edge affects automated
   layout algorithms.
   Choosing the "force directionality" of each domain relation's
   visual edge can result in more intuitive graph layouts.
-->
<xsl:variable name="LINKSETS-swap-directionality-predicates" select="(
   $rdfabbr-swap-directionality-predicates
)"/>

<!--
   If a predicate is rendered as a visual edge, it can be useful to
   mint new visual nodes for every occurrence of the triple's object.
   This will increase the planarity of the resulting visual graph.
-->
<xsl:variable name="LINKSETS-namespaces-to-relax" select="(
)"/>

<!--
-->
<xsl:variable name="LINKSETS-namespaces-to-relax-in-ranges" select="(
)"/>

<!--
   Explicit list of literals. More specific than LINKSETS-relax-identical-literals.
-->
<xsl:variable name="LINKSETS-literals-to-relax" select="(
)"/>

<!--
   Boolean. Do it for all literals.
-->
<xsl:variable name="LINKSETS-relax-identical-literals" select="(
)"/>



<!--
   - - - - - - - - - - - - - - - - - - - - - -
   Sometimes, simply excluding a relation can be an effective way to
   simplify the visual artifact. They could be excluded because
   it is not relevant to the visual message, or they could be excluded
   because it is rendered via some other means (such as those listed above).
   - - - - - - - - - - - - - - - - - - - - - -
-->

<xsl:variable name="LINKSETS-blacklisted-subjects" select="(
)"/>

<xsl:variable name="LINKSETS-blacklisted-subject-namespaces" select="(
)"/>

<xsl:variable name="LINKSETS-blacklisted-subject-classes" select="(
   $void:Linkset,
   $dcat:Distribution,
   'http://purl.org/dc/terms/IMT',
   $tag:Tag,
   $sd:NamedGraph,
   $vsr:Graphic,
   'http://provenanceweb.org/ns/pml#Answer',
   'http://purl.org/twc/vocab/vsr/svg#circle'
)"/>

<xsl:variable name="LINKSETS-blacklisted-predicates" select="(
   'http://www.holygoat.co.uk/owl/redwood/0.1/tags/taggedWithTag',
   $rdfabbr-blacklisted-predicates,
   $void:subset,
   $dcterms:title,
   $foaf:name,
   $dcterms:identifier,
   $void:target,
   $dcat:keyword,
   $dcterms:creator,
   $dcterms:rights,
   $owl:sameAs,
   $foaf:mbox,
   $ov:shortName,
   $foaf:homepage,
   $void:sparqlEndpoint,
   $sd:endpoint,
   $void:uriSpace,
   $prov:atLocation,
   $sd:name,
   $prov:specializationOf
)"/>

<xsl:variable name="LINKSETS-blacklisted-predicate-namespaces" select="(
)"/>

<xsl:variable name="LINKSETS-blacklisted-objects" select="(
   $rdfabbr-blacklisted-objects,
   $LINKSETS-class-strategy/visual-form/class/text(),
   $owl:Thing,
   $dcat:Dataset,
   $sd:Service,
   $datafaqs:CKANDataset
)"/>

<xsl:variable name="LINKSETS-blacklisted-object-classes" select="(
   $dcat:Distribution,
   $datafaqs:CKANGroup,
   $tag:Tag,
   $sd:NamedGraph
)"/>

<xsl:variable name="LINKSETS-blacklisted-object-namespaces" select="(
)"/>

<!-- This is experimental; keep it false. -->
<xsl:variable name="clean-visual-element-minting" select="false()"/>






<!-- This template handles all resources. -->
<xsl:template match="@rdf:about | @rdf:resource | @rdf:nodeID | @rdf:ID">
   <xsl:param name="deferrer"/>

   <!-- The URI for _this_ template, and its type. -->
   <xsl:variable name="owl:sameAs" select="concat($rl,'LINKSETS_subject_visual_form_factory_default_290')"/>
   <xsl:variable name="rdf:type"   select="$vsr:VisualElementFactory"/>

   <!-- Orient with the resource that we're considering to render, and log it. -->
   <xsl:variable name="subject"    select="."/>
   <xsl:message select="acv:arriveResource($owl:sameAs,$subject,$deferrer)"/>

   <!-- Elements for all property/value pairs describing this subject -->
   <xsl:variable name="s"          select="key('descriptions-by-subject',$subject)"/>

   <!-- Gather certain properties -->
   <xsl:variable name="rdf-types"     select="$s/rdf:type/@rdf:resource"/>
   <xsl:variable name="a-dataset"     select="$dcat:Dataset = $rdf-types or $datafaqs:CKANDataset"/>
   <xsl:variable name="void-triples"  select="$s/void:triples/text()"/>
   <xsl:variable name="void-triplesL">
      <xsl:number value="$void-triples"/>
   </xsl:variable>
   <xsl:variable name="tags"            select="$s/tag:taggedWithTag/@rdf:resource"/>

   <!-- Classify domain form -->

   <!-- Inherit from previous view -->
   <!-- <file:///localhost/80b4f060-7174-44a3-960f-057f5f4592aa/automatic/graphic/21908>
           a vsr:Graphic , <http://purl.org/twc/vocab/vsr/svg#circle> ;
           dcterms:identifier "dataset-eurostat-rdf" ;
           vsr:depicts <http://datahub.io/dataset/eurostat-rdf> ;
           rdfs:label "Eurostat" ;
           vsr:x 591.221649 ;
           vsr:y 923.862269 .
   -->
   <xsl:variable name="sp"                   select="key('descriptions-by-object',$subject)"/>
   <xsl:for-each select="$sp/*[xfm:uri(.)=$vsr:depicts]">
      <xsl:message select="concat(@rdf:about,' ',xfm:uri(.))"/>
   </xsl:for-each>
   <xsl:variable name="previous-graphic-ref" select="$sp/*[xfm:uri(.)=$vsr:depicts][1]/../(@rdf:about|@rdf:resource|rdf:nodeID)"/>
   <xsl:variable name="previous-graphic"     select="key('descriptions-by-subject',$previous-graphic-ref)"/>
   <xsl:message select="concat(' previous graphic of ',$subject,': ',$previous-graphic-ref,' ',count($previous-graphic/vsr:x))"/>

   <!-- Determine visual properties based on classifications -->
   <xsl:variable name="label">
      <xsl:choose>
      <xsl:when test="starts-with($subject,'http://thedatahub.org/dataset/')">    
         <xsl:variable name="value" select="concat(substring-after($subject,'http://thedatahub.org/dataset/'),$NL,'(',$void-triplesL,')')"/> 
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,'label',$value,'$visual-form-uri','a void:Linkset')"/>
         <xsl:value-of select="$value"/>
      </xsl:when>
      <xsl:when test="starts-with($subject,'http://datahub.io/dataset/')">    
         <xsl:variable name="value" select="concat(substring-after($subject,'http://datahub.io/dataset/'),$NL,'(',$void-triplesL,')')"/> 
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,'label',$value,'$visual-form-uri','a void:Linkset')"/>
         <xsl:value-of select="$value"/>
      </xsl:when>
      <xsl:when test="$void:Linkset = $rdf-types">    
         <xsl:value-of select="'some linkset'"/> 
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,'label','some linkset','$visual-form-uri','a void:Linkset')"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="''"/> 
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,'label','','$visual-form-uri','xsl:otherwise')"/>
      </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="shape">
      <xsl:choose>
      <xsl:when test="$a-dataset">    
         <xsl:value-of select="'Circle'"/> 
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,'shape','Circle','$visual-form-uri','a dcat:Dataset or datafaqs:CKANDataset')"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="''"/> 
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,'shape','','$visual-form-uri','xsl:otherwise')"/>
      </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="position-scale" select="4"/>

   <xsl:variable name="x">
      <xsl:choose>
      <xsl:when test="$previous-graphic/vsr:x">    
         <xsl:variable name="value" select="$position-scale * ($previous-graphic/vsr:x[1] - 1070) + $position-scale * 1070"/> <!-- DBPedia's center -->
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:x,string($value),'$visual-form-uri','previous graphic')"/>
         <xsl:value-of select="$value"/> 
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="''"/> 
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:x,'','$visual-form-uri','xsl:otherwise')"/>
      </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="y">
      <xsl:choose>
      <xsl:when test="$previous-graphic/vsr:y">    
         <xsl:variable name="value" select="$position-scale * ($previous-graphic/vsr:y[1] - 845) + $position-scale * 845"/> <!-- DBPedia's center -->
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:y,string($value),'$visual-form-uri','previous graphic')"/>
         <xsl:value-of select="$value"/> 
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="''"/> 
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:x,'','$visual-form-uri','xsl:otherwise')"/>
      </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="height">
      <xsl:choose>
      <!--xsl:when test="$previous-graphic/vsr:height"> <!- Added Jul 2016 to follow suit with LOD Cloud Diagram ->
         <xsl:variable name="value" select="$previous-graphic/vsr:height"/>
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:height,string($value),'$visual-form-uri','previous graphic')"/>
         <xsl:value-of select="$value"/> 
      </xsl:when-->
      <xsl:when test="$a-dataset and string-length($void-triples)">    
         <xsl:variable name="value" select="50 * 2 * math:sqrt(math:log(xs:double($void-triples)) div 3.14159)"/>
         <xsl:value-of select="$value"/> 
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,'height',string($value),'$visual-form-uri','a dcat:Dataset')"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="''"/> 
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,'height','','$visual-form-uri','xsl:otherwise')"/>
      </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="width">
      <xsl:choose>
      <!--xsl:when test="$previous-graphic/vsr:width"> <!- Added Jul 2016 to follow suit with LOD Cloud Diagram ->
         <xsl:variable name="value" select="$previous-graphic/vsr:width"/>
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:width,string($value),'$visual-form-uri','previous graphic')"/>
         <xsl:value-of select="$value"/> 
      </xsl:when-->
      <xsl:when test="$a-dataset and string-length($void-triples)">    
         <xsl:variable name="value" select="50 * 2 * math:sqrt(math:log(xs:double($void-triples)) div 3.14159)"/>
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,'width',string($value),'$visual-form-uri','a dcat:Dataset')"/>
         <xsl:value-of select="$value"/> 
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="''"/> 
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,'width','','$visual-form-uri','xsl:otherwise')"/>
      </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="fit-text">
      <xsl:choose>
      <xsl:when test="$a-dataset and string-length($void-triples)">    
         <xsl:variable name="value" select="'Overflow'"/>
         <xsl:value-of select="$value"/> 
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,'fit-text',$value,'$visual-form-uri','a dcat:Dataset')"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="''"/> 
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,'fit-text','','$visual-form-uri','xsl:otherwise')"/>
      </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="fill-color">
      <xsl:choose>
      <xsl:when test="('http://datahub.io/tag/crossdomain', 'http://thedatahub.org/tag/crossdomain') = $tags">    
         <xsl:variable name="value" select="xfm:scale255(235,247,246)"/>
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:fill,$value,'$visual-form-uri','crossdomain')"/>
         <xsl:value-of select="$value"/> 
      </xsl:when>
      <xsl:when test="('http://datahub.io/tag/lifesciences','http://thedatahub.org/tag/lifesciences') = $tags">    
         <xsl:variable name="value" select="xfm:scale255(246,223,232)"/>
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:fill,$value,'$visual-form-uri','lifesciences')"/>
         <xsl:value-of select="$value"/> 
      </xsl:when>
      <xsl:when test="('http://datahub.io/tag/publications','http://thedatahub.org/tag/publications') = $tags">    
         <xsl:variable name="value" select="xfm:scale255(233,253,212)"/>
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:fill,$value,'$visual-form-uri','publications')"/>
         <xsl:value-of select="$value"/> 
      </xsl:when>
      <xsl:when test="('http://datahub.io/tag/usergeneratedcontent','http://thedatahub.org/tag/usergeneratedcontent') = $tags">    
         <xsl:variable name="value" select="xfm:scale255(255,237,224)"/>
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:fill,$value,'$visual-form-uri','usergeneratedcontent')"/>
         <xsl:value-of select="$value"/> 
      </xsl:when>
      <xsl:when test="('http://datahub.io/tag/media','http://thedatahub.org/tag/media') = $tags">    
         <xsl:variable name="value" select="xfm:scale255(232,239,254)"/>
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:fill,$value,'$visual-form-uri','media')"/>
         <xsl:value-of select="$value"/> 
      </xsl:when>
      <xsl:when test="('http://datahub.io/tag/government','http://thedatahub.org/tag/government') = $tags">    
         <xsl:variable name="value" select="xfm:scale255(207,253,235)"/>
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:fill,$value,'$visual-form-uri','government')"/>
         <xsl:value-of select="$value"/> 
      </xsl:when>
      <xsl:when test="('http://datahub.io/tag/geographic','http://thedatahub.org/tag/geographic') = $tags">    
         <xsl:variable name="value" select="xfm:scale255(254,240,183)"/>
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:fill,$value,'$visual-form-uri','government')"/>
         <xsl:value-of select="$value"/> 
      </xsl:when>
      <xsl:otherwise>
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:fill,'','$visual-form-uri','xsl:otherwise')"/>
         <xsl:value-of select="''"/> 
      </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="stroke-color">
      <xsl:choose>
      <xsl:when test="'http://datahub.io/tag/crossdomain' = $tags"> <!-- 60, 84, 74 -->
         <xsl:variable name="value" select="concat(60 div 255,' ',84 div 255,' ',74 div 255)"/>
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:fill,$value,'$visual-form-uri','crossdomain')"/>
         <xsl:value-of select="$value"/> 
      </xsl:when>
      <xsl:when test="'http://datahub.io/tag/lifesciences' = $tags"> <!-- 207, 60, 155-->
         <xsl:variable name="value" select="concat(207 div 255,' ',60 div 255,' ',155 div 255)"/>
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:fill,$value,'$visual-form-uri','lifesciences')"/>
         <xsl:value-of select="$value"/> 
      </xsl:when>
      <xsl:when test="'http://datahub.io/tag/publications' = $tags"> <!-- 62, 200, 68-->
         <xsl:variable name="value" select="concat(62 div 255,' ',200 div 255,' ',68 div 255)"/>
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:fill,$value,'$visual-form-uri','publications')"/>
         <xsl:value-of select="$value"/> 
      </xsl:when>
      <xsl:when test="'http://datahub.io/tag/usergeneratedcontent' = $tags"> <!-- 253, 117, 73-->
         <xsl:variable name="value" select="concat(253 div 255,' ',117 div 255,' ',73 div 255)"/>
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:fill,$value,'$visual-form-uri','usergeneratedcontent')"/>
         <xsl:value-of select="$value"/> 
      </xsl:when>
      <xsl:when test="'http://datahub.io/tag/media' = $tags"> <!-- 55, 127, 204-->
         <xsl:variable name="value" select="concat(55 div 255,' ',127 div 255,' ',204 div 255)"/>
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:fill,$value,'$visual-form-uri','media')"/>
         <xsl:value-of select="$value"/> 
      </xsl:when>
      <xsl:when test="'http://datahub.io/tag/government' = $tags"> <!-- 33, 202, 177-->
         <xsl:variable name="value" select="concat(33 div 255,' ',202 div 255,' ',177 div 255)"/>
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:fill,$value,'$visual-form-uri','government')"/>
         <xsl:value-of select="$value"/> 
      </xsl:when>
      <xsl:when test="'http://datahub.io/tag/geographic' = $tags"> <!-- 169, 121, 70 -->
         <xsl:variable name="value" select="concat(169 div 255,' ',121 div 255,' ',70 div 255)"/>
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:fill,$value,'$visual-form-uri','government')"/>
         <xsl:value-of select="$value"/> 
      </xsl:when>
      <xsl:otherwise>
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,$vsr:fill,'','$visual-form-uri','xsl:otherwise')"/>
         <xsl:value-of select="''"/> 
      </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="draw-stroke">
      <xsl:choose>
      <xsl:when test="$a-dataset and string-length($void-triples)">    
         <xsl:variable name="value" select="true()"/>
         <xsl:value-of select="$value"/> 
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,'draw-stroke','true','$visual-form-uri','a dcat:Dataset')"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="''"/> 
         <xsl:message select="acv:explainResource($subject,$owl:sameAs,'draw-stroke','','$visual-form-uri','xsl:otherwise')"/>
      </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>


   <!-- Invoke the core template with the visual properties determined by this template. -->
   <!--xsl:apply-templates select="." mode="default">
      <xsl:with-param name="deferrer"                      select="$owl:sameAs"/>
      <xsl:with-param name="label-predicates"              select="$LINKSETS-label-predicates"/>
      <xsl:with-param name="notes-predicates"              select="$LINKSETS-notes-predicates"/>
      <xsl:with-param name="class-strategy"                select="$LINKSETS-class-strategy" tunnel="yes"/>
      <xsl:with-param name="namespaces-to-relax"           select="$LINKSETS-namespaces-to-relax"/>
      <!-xsl:with-param name="namespaces-to-relax-in-ranges" select=""/->
      <!-xsl:with-param name="show-bnode-IDs" select="true()"/-->

   <xsl:apply-templates select="." mode="default">
      <xsl:with-param name="deferrer"                      select="$owl:sameAs"/>

      <xsl:with-param name="blacklisted-subject-classes"   select="$LINKSETS-blacklisted-subject-classes" tunnel="yes"/>
      <!--xsl:with-param name="view-context"                  select="$LINKSETS-view-context" tunnel="yes"/-->
      <xsl:with-param name="namespaces-to-relax"           select="$LINKSETS-namespaces-to-relax"         tunnel="yes"/>
      <!--xsl:with-param name="namespaces-to-relax-in-ranges" select=""/-->

      <xsl:with-param name="class-strategy"                select="$LINKSETS-class-strategy"              tunnel="yes"/>
      <xsl:with-param name="namespace-strategy"            select="$LINKSETS-namespace-strategy"          tunnel="yes"/>

      <xsl:with-param name="anonymous-instance-classes"    select="$LINKSETS-anonymous-instance-classes"  tunnel="yes"/>
      <xsl:with-param name="label-predicates"              select="$LINKSETS-label-predicates"            tunnel="yes"/>
      <xsl:with-param name="in-label-predicates"           select="$LINKSETS-in-label-predicates"         tunnel="yes"/>
      <!--xsl:with-param name="show-bnode-IDs" select="true()"/-->

      <xsl:with-param name="notes-predicates"              select="$LINKSETS-notes-predicates"            tunnel="yes"/>

      <xsl:with-param name="tooltip-predicates"            select="$LINKSETS-tooltip-predicates"          tunnel="yes"/>
      <xsl:with-param name="rooted-classes"                select="$LINKSETS-rooted-classes"              tunnel="yes"/>

      <xsl:with-param name="label"                         select="$label"                                tunnel="yes"/>
      <xsl:with-param name="shape"                         select="$shape"                                tunnel="yes"/>
      <xsl:with-param name="x"                             select="$x"                                    tunnel="yes"/>
      <xsl:with-param name="y"                             select="$y"                                    tunnel="yes"/>
      <xsl:with-param name="height"                        select="$height"                               tunnel="yes"/>
      <xsl:with-param name="width"                         select="$width"                                tunnel="yes"/>
      <xsl:with-param name="fit-text"                      select="$fit-text"                             tunnel="yes"/>
      <xsl:with-param name="draw-stroke"                   select="$draw-stroke"                          tunnel="yes"/>
      <xsl:with-param name="fill-color"                    select="$fill-color"                           tunnel="yes"/>
      <xsl:with-param name="stroke-color2"                 select="$stroke-color"                         tunnel="yes"/>
   </xsl:apply-templates>
</xsl:template>




<!-- Templates can be made for particular RDF predicates -->
<xsl:template match="void:triples">
   <xsl:param name="deferrer"/>

   <!-- The URI for _this_ template, and its type. -->
   <xsl:variable name="owl:sameAs" select="concat($vsr,'LINKSETS_resource_object_visual_form_factory_381')"/>
   <xsl:variable name="rdf:type"   select="$vsr:VisualElementFactory"/>

   <!-- Orient with the triple that we're considering to render, and log it. -->
   <xsl:variable name="subject"   select="vsr:getSubject(.)"/>
   <xsl:variable name="predicate" select="xfm:uri(.)"/>
   <xsl:variable name="object"    select="vsr:getObject(.)"/>
   <xsl:message                   select="acv:arriveTriple($owl:sameAs,$subject,$predicate,$object,$deferrer)"/>

   <!-- Elements for all property/value pairs describing the subject -->
   <xsl:variable name="s"          select="key('descriptions-by-subject',$subject)"/>

   <!-- Gather certain properties about the subject -->
   <xsl:variable name="rdf-types"    select="$s/rdf:type/@rdf:resource"/>
   <xsl:variable name="void-targets" select="$s/void:target/@rdf:resource"/>
   <xsl:variable name="void-triples" select="$s/void:triples[text()][1]"/>

   <xsl:choose>
      <xsl:when test="$void:Linkset = $rdf-types and count($void-targets) = 2">
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,concat('draw edge ',void-targets[1]),'linkset')"/>
         <xsl:message select="concat('void-targets: ',$void-targets[1])"/>
         <xsl:message select="concat('void-targets: ',$void-targets[2])"/>

         <xsl:if test="not(idm:hasIdentified($visual-element-hash,$void-targets[1]))">
            <xsl:for-each-group select="//*[@rdf:about | @rdf:resource | @rdf:nodeID | @rdf:ID = $void-targets[1]]
                                         /(@rdf:about | @rdf:resource | @rdf:nodeID | @rdf:ID)" group-by=".">
               <xsl:apply-templates select="current-group()[1]">
                  <xsl:with-param name="deferrer"     select="$owl:sameAs"/>
                  <!--xsl:with-param name="view-context" select="$object-view-context"/-->
               </xsl:apply-templates>
            </xsl:for-each-group>
         </xsl:if>

         <xsl:if test="not(idm:hasIdentified($visual-element-hash,$void-targets[2]))">
            <xsl:for-each-group select="//*[@rdf:about | @rdf:resource | @rdf:nodeID | @rdf:ID = $void-targets[2]]
                                         /(@rdf:about | @rdf:resource | @rdf:nodeID | @rdf:ID)" group-by=".">
               <xsl:apply-templates select="current-group()[1]">
                  <xsl:with-param name="deferrer"     select="$owl:sameAs"/>
                  <!--xsl:with-param name="view-context" select="$object-view-context"/-->
               </xsl:apply-templates>
            </xsl:for-each-group>
         </xsl:if>

         <xsl:variable name="line-width">
            <xsl:choose>
               <xsl:when test="string-length($void-triples)">
                  <xsl:variable name="value" select="math:max(xs:integer(math:log(xs:double($void-triples))),
                                                            1)"/>
                  <xsl:message select="acv:explainResource($subject,$owl:sameAs,'stroke-width',string($value),'$visual-form-uri','void-triples width')"/>
                  <xsl:value-of select="$value"/> 
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message select="acv:explainResource($subject,$owl:sameAs,'stroke-width','','$visual-form-uri','xsl:otherwise')"/>
                  <xsl:value-of select="1"/> 
               </xsl:otherwise>
            </xsl:choose>
         </xsl:variable>

         <xsl:call-template name="edge">
            <xsl:with-param name="id"           select="concat($subject,$predicate,$object)"/>
            <xsl:with-param name="from"         select="$void-targets[1]"/>
            <xsl:with-param name="to"           select="$void-targets[2]"/>
            <xsl:with-param name="depicts"      select="$subject"/>
            <xsl:with-param name="label"        select="$object"/>
            <xsl:with-param name="notes"        select="$void-triples"/>
            <!--xsl:with-param name="font-color" select=""/>
            <xsl:with-param name="font-color" select=""/-->
            <xsl:with-param name="line-width"   select="$line-width"/>
            <xsl:with-param name="head-style"   select="'0'"/>
            <xsl:with-param name="stroke-color" select="70 div 255"/>
         </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'omit edge','not a linkset')"/>
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>




<!-- This template handles all properties that do not apply to any other template. -->
<xsl:template match="rdf:Description/*" priority="-.25">
   <xsl:param name="deferrer"/>
   <!-- The URI for _this_ template, and its type. -->
   <xsl:variable name="owl:sameAs" select="'LINKSETS_Cleanup_crew_255'"/>
   <xsl:variable name="rdf:type"   select="$vsr:CleanupCrew"/>

   <!-- Orient with the triple that we're considering to render, and log it. -->
   <xsl:variable name="subject"   select="vsr:getSubject(.)"/>
   <xsl:variable name="predicate" select="xfm:uri(.)"/>
   <xsl:variable name="object"    select="vsr:getObject(.)"/>
   <xsl:message                   select="acv:arriveTriple($owl:sameAs,$subject,$predicate,$object,$deferrer)"/>

   <!-- We don't apply any logic in this default template,
        but we pass down the visual strategy parameters to the core RDF templates. -->
   <xsl:apply-templates select="." mode="blacklist_checker">
      <xsl:with-param name="deferrer" select="$owl:sameAs"/>

      <!-- Predicates in these lists are rendered in forms other than visual edges -->
      <xsl:with-param name="anonymous-instance-classes"       select="$LINKSETS-anonymous-instance-classes"     tunnel="yes"/>
      <xsl:with-param name="class-strategy"                   select="$LINKSETS-class-strategy"      tunnel="yes"/>
      <xsl:with-param name="namespace-strategy"               select="$LINKSETS-namespace-strategy"/>
      <xsl:with-param name="label-predicates"                 select="$LINKSETS-label-predicates"    tunnel="yes"/>
      <xsl:with-param name="in-label-predicates"              select="$LINKSETS-in-label-predicates" tunnel="yes"/>
      <xsl:with-param name="notes-predicates"                 select="$LINKSETS-notes-predicates"/>
      <xsl:with-param name="tooltip-predicates"               select="$LINKSETS-tooltip-predicates"  tunnel="yes"/>

      <!-- Alter the characteristics of the visual edges that remain. -->
      <xsl:with-param name="swap-directionality-predicates"   select="$LINKSETS-swap-directionality-predicates"/>

      <!-- Predicates in these lists are rendered in forms other than visual edges, or are simply excluded. -->
      <xsl:with-param name="blacklisted-subjects"             select="$LINKSETS-blacklisted-subjects"/>
      <xsl:with-param name="blacklisted-subject-namespaces"   select="$LINKSETS-blacklisted-subject-namespaces"/>
      <xsl:with-param name="blacklisted-subject-classes"      select="$LINKSETS-blacklisted-subject-classes"/>
      <xsl:with-param name="blacklisted-predicates"           select="$LINKSETS-blacklisted-predicates"/>
      <xsl:with-param name="blacklisted-predicate-namespaces" select="$LINKSETS-blacklisted-subject-namespaces"/>
      <xsl:with-param name="blacklisted-objects"              select="$LINKSETS-blacklisted-objects"/>
      <xsl:with-param name="blacklisted-object-classes"       select="$LINKSETS-blacklisted-object-classes"/>
      <xsl:with-param name="blacklisted-object-namespaces"    select="()"/>
   </xsl:apply-templates>
</xsl:template>

</xsl:transform>
