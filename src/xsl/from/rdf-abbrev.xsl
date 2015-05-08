<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:wgs="http://www.w3.org/2003/01/geo/wgs84_pos#"
   xmlns:time="http://www.w3.org/2006/time#"
   xmlns:ov="http://open.vocab.org/terms/"
   xmlns:rl="http://purl.org/twc/vocab/vsr/"
   xmlns:p="http://purl.org/twc/vocab/vsr/"
   xmlns:prov="http://www.w3.org/ns/prov#"

   xmlns:math="java:java.lang.Math"
   xmlns:jvr="jvr"
   xmlns:nmf="java:edu.rpi.tw.string.NameFactory"
   xmlns:idm="java:edu.rpi.tw.string.IDManager"
   xmlns:log="java:edu.rpi.tw.visualization.log.VisualizationDecisions"

   xmlns:acv="accountable visualization"
   xmlns:pmap="edu.rpi.tw.string.pmm.DefaultPrefixMappings"
   xmlns:pmm="edu.rpi.tw.string.pmm"
   xmlns:xutil="https://github.com/timrdf/vsr/tree/master/src/xsl/util"
   xmlns:xsdabv="https://github.com/timrdf/vsr/tree/master/src/xsl/util/xsd-datatype-abbreviations.xsl"
   xmlns:vsr="http://purl.org/twc/vocab/vsr#"
   xmlns:xfm="transform namespace">

<xsl:import  href="../ns/ov-ns.xsl"/>
<xsl:include href="../util/lists.xsl"/>

<xd:doc type="stylesheet">
   <xd:short>Visual strategy for naive RDF with some useful abbreviations over a verbatim visual mapping.</xd:short>
   <xd:detail><p>This transform works on the 'foundational' rdf/xml syntax and NOT the abbreviated form.
              use `java jena.rdfcopy your.rdf RDF/XML RDF/XML` to get the unabbreviated form.
              'foundational' uses rdf:Description and not the type shorthand.
             </p>
               <dl>
                  <dt>Filters</dt><dd> prevent certain triples from being processed.</dd>
                  <dt>Replacements</dt><dd> take full control for certain triples and do NOT pass control to the default verbatim processing.</dd>
                  <dt>Augmenters</dt><dd> step in before the default verbatim processing.</dd>
               </dl>
   </xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>
   </xd:detail>
</xd:doc>
<xsl:variable name="rdfabbr-blacklisted-subject-namespaces"   select="()"/>
<xd:doc>
   <xd:short></xd:short>
   <xd:detail>
   </xd:detail>
</xd:doc>
<xsl:variable name="rdfabbr-blacklisted-predicate-namespaces" select="()"/>
<xd:doc>
   <xd:short></xd:short>
   <xd:detail>
   </xd:detail>
</xd:doc>
<xsl:variable name="rdfabbr-blacklisted-object-namespaces"    select="()"/>

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>
   </xd:detail>
</xd:doc>
<xsl:variable name="rdfabbr-blacklisted-subjects"             select="()"/>
<xd:doc>
   <xd:short></xd:short>
   <xd:detail>
   </xd:detail>
</xd:doc>
<xsl:variable name="rdfabbr-blacklisted-predicates"           select="(
   $rdfs:label,
   $rdf:predicate,
   $rdf:object,
   $wgs_lat, $wgs_long,
   $time:inXSDDateTime,
   concat($pns,'p'), concat($pns,'o')
)"/> <!-- include
$rdf:type
 if instance data -->

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>
   </xd:detail>
</xd:doc>
<xsl:variable name="rdfabbr-blacklisted-objects"              select="($rdf:nil)"/>

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>
   </xd:detail>
</xd:doc>
<xsl:variable name="rdfabbr-label-predicates" select="(
   $rdfs:label
)"/>

<xsl:variable name="rdf-abbrev-namespaces-to-relax"           select="()"/>

<xsl:variable name="rdf-abbrev-namespaces-to-relax-in-ranges" select="$xs"/>

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>
   </xd:detail>
</xd:doc>
<xsl:variable name="only-show-language"                       select="('en')"/>

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>
   </xd:detail>
</xd:doc>
<xsl:variable name="rdfabbr-swap-directionality-predicates" select="(
   $rdf:type,
   $rdfs:domain,
   $rdfs:subClassOf,
   $rdf:subject,
   $owl:complementOf,
   $time:hasBeginning,
   $ov:subjectDiscriminator
)"/>

<xd:doc>TODO: get rid of this.</xd:doc>
<xsl:variable name="visuallyAbbreviate"                   select="not($draw-literal-rdf)"/>

<xd:doc>conferred in rdf:rest</xd:doc>
<xsl:variable name="draw-involves-edges-from-list"        select="false()"/>
<xd:doc>conferred in rdf:rest, owl:someValuesFrom | owl:allValuesFrom</xd:doc>
<xsl:variable name="draw-involves-edges-from-list-head"   select="false()"/>

<xd:doc>conferred in rdf:rest</xd:doc>
<xsl:variable name="annotate-list-head-with-qnames-label" select="false()"/>

<xsl:variable name="clean-visual-element-minting" select="false()"/>

<xsl:variable name="rdf-abbrev-plan" select="'http://github.com/timrdf/vsr/blob/master/src/xsl/from/rdf-abbrev.xsl'"/>

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>A mapping ??
   </xd:detail>
</xd:doc>
<xsl:key name="predicate-stroke-color" match="visual-form" use="predicate"/>

<xd:doc>
   <xd:short>Catch-all for an RDF Node.</xd:short>
   <xd:detail>
   </xd:detail>
</xd:doc>
<xsl:template match="rdf:Description[@rdf:about | @rdf:nodeID]" mode="visual-element" priority="-.5">
   <xsl:param name="deferrer"      select="''"/>
   <xsl:variable name="owl:sameAs" select="concat($rdf-abbrev-plan,'#rdf-abbrev_subject_visual_form_factory_138')"/><!-- GRRR! imported does not trigger, had to put this in-->
   <!-- Orient with domain form -->
   <xsl:variable name="subject"          select="@rdf:about | @rdf:nodeID"/><!--current-grouping-key()"/-->
   <xsl:message select="acv:arriveResource($owl:sameAs,$subject,$deferrer)"/>

   <xsl:apply-templates select="." mode="default">
   </xsl:apply-templates>
</xsl:template>


<xd:doc>
   <xd:short>Catch-all for an RDF Node.</xd:short>
   <xd:detail>
   </xd:detail>
</xd:doc>
<xsl:template match="rdf:type">
   <!-- priority="-.5"-->
   <xsl:param name="deferrer"      select="''"/>
   <xsl:variable name="owl:sameAs" select="concat($rdf-abbrev-plan,'#RDFABBR_Blacklisted_Type_Filter_155')"/>
   <xsl:variable name="rdf:type"   select="$rlFilter"/>

   <!-- Orient with domain form -->
   <xsl:variable name="subject"   select="../@rdf:about | ../@rdf:nodeID"/>
   <xsl:variable name="predicate" select="xfm:uri(.)"/>
   <xsl:variable name="type"      select="vsr:getObject(.)"/>
   <xsl:message                   select="acv:arriveTriple($owl:sameAs,$subject,$predicate,$type,$deferrer)"/>

   <!-- Classify domain form -->
   <xsl:variable name="is-bnode"  select="../@rdf:nodeID"/>

   <!-- Determine visual properties based on classifications -->
   <xsl:choose>
      <xsl:when test="$is-bnode"> <!-- Prevent type connections from bnodes, since the type is expressed as a label. -->
         <xsl:variable name="action"        select="$rlPrevent_default_processing"/>
         <xsl:variable name="justification" select="concat('resource ',pmm:bestQName($type),' subject is bnode.')"/>
         <xsl:message  select="acv:explainTriple($subject,$predicate,$type,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
      </xsl:when>
      <xsl:when test="$type = $rdfabbr-blacklisted-objects"> <!-- Ignore all triples with a certain type -->
         <xsl:variable name="action"        select="$rlPrevent_default_processing"/>
         <xsl:variable name="justification" select="concat('resource ',pmm:bestQName($type),' is blacklisted as an object')"/>
         <xsl:message  select="acv:explainTriple($subject,$predicate,$type,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
      </xsl:when>
      <xsl:when test="$type = ($rdfs:Resource, $rdfs:Class)"> <!-- RDFS-derivable -->
         <xsl:variable name="action"        select="$rlPrevent_default_processing"/>
         <xsl:variable name="justification" select="$rlDerivableFromVisualWithOWL_Semantics"/>
         <xsl:message  select="acv:explainTriple($subject,$predicate,$type,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
      </xsl:when>
      <xsl:when test="$type = ($owl:Restriction, $owl:Class)"> <!-- OWL-derivable -->
         <xsl:variable name="action"        select="$rlPrevent_default_processing"/>
         <xsl:variable name="justification" select="$rlDerivableFromVisualWithOWL_Semantics"/>
         <xsl:message  select="acv:explainTriple($subject,$predicate,$type,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
      </xsl:when>
      <xsl:when test="$type = ($rdf:Property, $owl:ObjectProperty, $owl:DatatypeProperty, $owl:AnnotationProperty)">
         <xsl:variable name="action"        select="$rlNot_draw_edge"/>
         <xsl:variable name="justification" select="$rlEncodedWithVisualProperties"/>
         <xsl:message  select="acv:explainTriple($subject,$predicate,$type,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
      </xsl:when>
      <xsl:when test="$type = ()"> <!-- Draw for debugging -->
         <xsl:variable name="action"        select="concat($rl,'Temporarily_Defer_to_default_processing')"/>
         <xsl:variable name="justification" select="$rlDebugging"/>
         <xsl:message  select="acv:explainTriple($subject,$predicate,$type,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
         <xsl:apply-templates select="." mode="default"/> <!-- DEFER -->
      </xsl:when>
      <xsl:when test="$rdf:type = $rdfabbr-blacklisted-predicates"><!-- was: $blacklist-all-type-triples"--> <!-- Good for instance data -->
         <xsl:variable name="action"        select="$rlPrevent_default_processing"/> <!-- TODO: count num type triples and use as threshold -->
         <xsl:variable name="justification" select="concat($rl,'Type_triples_are_bad_for_instance_data')"/>
         <xsl:message  select="acv:explainTriple($subject,$predicate,$type,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
      </xsl:when>
      <xsl:otherwise> <!-- If there isn't a reason to block, defer -->
         <xsl:variable name="action"        select="$rlDefer_to_default_processing"/>
         <xsl:variable name="justification" select="$rlTypeWasNotFoundUnacceptable"/>
         <xsl:apply-templates select="." mode="blacklist_checker"> <!-- DEFER -->
            <xsl:with-param name="deferrer" select="$owl:sameAs"/>
         </xsl:apply-templates>
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>
   </xd:detail>
</xd:doc>
<xsl:template match="rdfs:range">
   <xsl:param    name="deferrer"   select="''"/>
   <xsl:variable name="owl:sameAs" select="concat($rdf-abbrev-plan,'#RDFS_range_to_XSD_Filter_219')"/>
   <xsl:variable name="rdf:type"   select="$rlFilter"/>

   <xsl:variable name="subject"   select="../@rdf:about | ../@rdf:nodeID"/>
   <xsl:variable name="predicate" select="xfm:uri(.)"/>
   <xsl:variable name="object"    select="vsr:getObject(.)"/>
   <xsl:message                   select="acv:arriveTriple($owl:sameAs,$subject,$predicate,$object,$deferrer)"/>

   <xsl:variable name="should-relax-range" select="count($object) = 1
                                                    and pmap:canAbbreviate($pmap,$object)
                                                    and ( pmap:bestNamespaceFor($pmap,$object) = $rdf-abbrev-namespaces-to-relax-in-ranges
                                                          or $object = ($rdfs:Resource, $rdfs:Literal)
                                                    )"/>

   <xsl:variable name="rdfs-range"                select="key('descriptions-by-subject',$subject)/rdfs:range/@rdf:resource"/>
   <xsl:variable name="rdfs-domain"               select="key('descriptions-by-subject',$subject)/rdfs:domain/@rdf:resource"/>
   <xsl:variable name="has-same-domain-and-range" select="count($rdfs-range) = 1 and count($rdfs-domain) = 1 and $rdfs-domain = $rdfs-range"/>

   <xsl:choose>
      <xsl:when test="$should-relax-range"> <!--  -->
         <xsl:variable name="action"        select="$rlPrevent_default_processing"/>
         <xsl:variable name="justification" select="concat('range ',pmm:bestQName($object),' is in label of property.')"/>
         <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
      </xsl:when>
      <xsl:when test="$has-same-domain-and-range"> <!--  -->
         <xsl:variable name="action"        select="$rlPrevent_default_processing"/>
         <xsl:variable name="justification" select="concat('domain is same as range ',pmm:bestQName($object))"/>
         <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
      </xsl:when>
      <xsl:otherwise> <!-- If there isn't a reason to block, defer -->
         <xsl:variable name="action"        select="$rlDefer_to_default_processing"/>
         <xsl:variable name="justification" select="concat('range','not-in-XSD')"/>
         <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
         <xsl:apply-templates select="." mode="default"/> <!-- DEFER -->
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>
   TODO: consider distinction between template filter and adding $rdf:first to blacklisted predicates.
   </xd:detail>
</xd:doc>
<xsl:template match="rdf:first"><!-- | pmlds:first"-->
   <xsl:variable name="owl:sameAs" select="concat($rdf-abbrev-plan,'#RDF_first_filter_264')"/>
   <xsl:variable name="rdf:type"   select="$rlFilter"/>

   <xsl:variable name="subject"   select="../@rdf:about | ../@rdf:nodeID"/>
   <xsl:variable name="predicate" select="xfm:uri(.)"/>
   <xsl:variable name="element"   select="@rdf:resource | @rdf:nodeID"/>

   <xsl:variable name="action"        select="$rlPrevent_default_processing"/>
   <xsl:variable name="justification" select="'lists have labels enumerating elements and it is messy to point to elements.'"/>
   <xsl:message  select="acv:explainTriple($subject,$predicate,$element,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
   <!-- It is not usually helpful to connect a list to its elements -->

   <!--xsl:choose>
      <xsl:when test="$visuallyAbbreviate">
      </xsl:when>
      <xsl:otherwise>
         <xsl:variable name="action"        select="$rlDefer_to_default_processing"/>
         <xsl:variable name="justification" select="'visuallyAbbreviate=false'"/>
         <xsl:message  select="acv:explainTriple($subject,$predicate,$element,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
         <xsl:apply-templates select="." mode="default"/> <!- DEFER ->
      </xsl:otherwise>
   </xsl:choose-->
</xsl:template>

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>
   </xd:detail>
</xd:doc>
<xsl:template match="rdf:rest"><!-- | pmlds:rest"-->
   <!-- Add a label enumerating all elements of a list ONLY to the first element -->
   <xsl:variable name="owl:sameAs" select="concat($rdf-abbrev-plan,'#RDF_rest_Filter_295')"/>
   <xsl:variable name="rdf:type"   select="concat($rdf-abbrev-plan,'#Annotating_Filter')"/>

   <xsl:variable name="subject"   select="../@rdf:about | ../@rdf:nodeID"/>
   <xsl:variable name="predicate" select="xfm:uri(.)"/>
   <xsl:variable name="object"    select="vsr:getObject(.)"/>

   <!-- If something is pointing to $subject with a rdf:rest, then $subject is not the first list of the list -->
   <!-- If nothing   is pointing to $subject with a rdf:rest, then $subject is     the first list of the list -->
   <xsl:variable name="is-list-head"   select="not(key('descriptions-by-object',$subject)/rdf:rest)"/>

   <xsl:if test="$annotate-list-head-with-qnames-label">
      <!-- Annotate the head of a list with a label enumerating the elements in the list -->
      <xsl:variable name="action"        select="'drawing label for first element in list'"/>
      <xsl:variable name="justification" select="'it is useful to see all of the elements at once instead of walking through the graph.'"/>

      <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
      <xsl:call-template name="label-with-manchax-list">
         <xsl:with-param name="subject"     select="$subject"/>
         <xsl:with-param name="connective"  select="', '"/>
         <xsl:with-param name="list-URIRef" select="$subject"/>
      </xsl:call-template>
   </xsl:if>

   <xsl:choose>
      <xsl:when test="$is-list-head and $draw-involves-edges-from-list-head"> <!-- Connect the head of the list to all elements in the list -->
         <xsl:variable name="action"        select="$rlConnect_to_elements"/>
         <xsl:variable name="justification" select="concat($subject,' is a the first list of lists and draw-involves-edges-from-list-head=true')"/>

         <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
         <xsl:call-template name="connect-to-elements">
            <xsl:with-param name="subject"     select="$subject"/>
            <xsl:with-param name="list-URIRef" select="$subject"/>
         </xsl:call-template>
      </xsl:when>
      <xsl:when test="$draw-involves-edges-from-list"> <!-- Connect the list to all elements in the list (the whole way down...) -->
         <xsl:variable name="action"        select="$rlConnect_to_elements"/>
         <xsl:variable name="justification" select="$rlDebugging"/>

         <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
         <xsl:call-template name="connect-to-elements">
            <xsl:with-param name="subject"     select="$subject"/>
            <xsl:with-param name="list-URIRef" select="$subject"/>
         </xsl:call-template>
      </xsl:when>
      <xsl:when test="$visuallyAbbreviate and not($draw-literal-rdf)"> <!-- Visually manifest this rdf:rest triple with a connection --> <!-- TODO: rm draw-literal -->
         <xsl:variable name="action"        select="$rlPrevent_default_processing"/>
         <xsl:variable name="justification" select="'The head list has a label enumerating the elements QNames'"/>

         <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
      </xsl:when>
       <xsl:otherwise> <!-- Prevent a visual connection  -->
         <xsl:variable name="action"        select="$rlDefer_to_default_processing"/>
         <xsl:variable name="justification" select="'draw-literal-rdf=true'"/> <!-- TODO: rm draw-literal -->

         <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
          <xsl:apply-templates select="." mode="default"/> <!-- DEFER -->
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>
   </xd:detail>
</xd:doc>
<xsl:template match="rdf:predicate | rdf:object | p:p | p:o" priority="2">
   <xsl:variable name="owl:sameAs" select="concat($rdf-abbrev-plan,'#RDF_reification_filter_362')"/>
   <xsl:variable name="rdf:type"   select="$rlFilter"/>

   <xsl:variable name="subject"   select="../@rdf:about | ../@rdf:nodeID"/>
   <xsl:variable name="predicate" select="xfm:uri(.)"/>
   <xsl:variable name="object"    select="vsr:getObject(.)"/>

   <xsl:variable name="includeObjectLink" select="true()"/>

   <xsl:choose>
      <xsl:when test="$includeObjectLink and $predicate = $rdf:object">
         <xsl:variable name="action"        select="$rlDefer_to_default_processing"/>
         <xsl:variable name="justification" select="'includeObjectLink=true'"/>

         <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
         <xsl:apply-templates select="." mode="default"/> <!-- DEFER -->
      </xsl:when>
      <xsl:otherwise>
         <xsl:variable name="action"        select="$rlPrevent_default_processing"/>
         <xsl:variable name="justification" select="concat($rl,'Avoiding_connection_clutter')"/>

         <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
       </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>
   </xd:detail>
</xd:doc>
<xsl:template match="rdfs:isDefinedBy">
   <xsl:variable name="owl:sameAs" select="concat($rdf-abbrev-plan,'#IsDefinedByEdgeFilter_394')"/>
   <xsl:variable name="rdf:type"   select="$rlFilter"/>

   <xsl:variable name="subject"   select="../@rdf:about | ../@rdf:nodeID"/>
   <xsl:variable name="predicate" select="xfm:uri(.)"/>
   <xsl:variable name="object"    select="vsr:getObject(.)"/>

   <xsl:variable name="action"        select="$rlNot_draw_edge"/>
   <xsl:variable name="justification" select="'rdfs:isDefinedBy is not very informative if the full URI is available'"/>
   <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
</xsl:template>

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>
   </xd:detail>
</xd:doc>
<xsl:template match="rdfs:subClassOf" priority="-.5">
   <xsl:variable name="owl:sameAs" select="concat($rdf-abbrev-plan,'#Blacklisted_Superclass_Filter_412')"/>
   <xsl:variable name="rdf:type"   select="$rlFilter"/>

   <xsl:variable name="subclass"   select="../@rdf:about | ../@rdf:nodeID"/>
   <xsl:variable name="predicate"  select="xfm:uri(.)"/>
   <xsl:variable name="superclass" select="if (@rdf:resource | @rdf:nodeID) then @rdf:resource | @rdf:nodeID else text()"/>

   <xsl:choose>
      <xsl:when test="$superclass = ()"> <!-- Ignore all triples with a certain superclass -->
         <xsl:variable name="action"        select="$rlPrevent_default_processing"/>
         <xsl:variable name="justification" select="concat('resource ',pmm:bestQName($superclass),' is blacklisted as an object')"/>
         <xsl:message  select="acv:explainTriple($subclass,$predicate,$superclass,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
      </xsl:when>
       <xsl:when test="$superclass = ($rdfs:Resource)"> <!-- RDFS-derivable -->
         <xsl:variable name="action"        select="$rlPrevent_default_processing"/>
         <xsl:variable name="justification" select="$rlDerivableFromVisualWithOWL_Semantics"/>
         <xsl:message  select="acv:explainTriple($subclass,$predicate,$superclass,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
      </xsl:when>
      <xsl:when test="$superclass = ($owl:Thing, $owl:Class, $owl:Restriction)"> <!-- OWL-derivable -->
         <xsl:variable name="action"        select="$rlPrevent_default_processing"/>
         <xsl:variable name="justification" select="$rlDerivableFromVisualWithOWL_Semantics"/>
         <xsl:message  select="acv:explainTriple($subclass,$predicate,$superclass,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
      </xsl:when>
      <xsl:when test="$superclass = ()"> <!-- Encoded with visual properties -->
         <xsl:variable name="action"        select="$rlNot_draw_edge"/>
         <xsl:variable name="justification" select="$rlEncodedWithVisualProperties"/>
         <xsl:message  select="acv:explainTriple($subclass,$predicate,$superclass,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
      </xsl:when>
      <xsl:when test="$superclass = ()"> <!-- Draw for debugging -->
         <xsl:variable name="action"        select="concat($rl,'Temporarily_Defer_to_default_processing')"/>
         <xsl:variable name="justification" select="$rlDebugging"/>
         <xsl:message  select="acv:explainTriple($subclass,$predicate,$superclass,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
         <xsl:apply-templates select="." mode="default"/> <!-- DEFER -->
      </xsl:when>
       <xsl:otherwise>             <!-- If there isn't a reason to block, defer -->
         <!--xsl:variable name="action"        select="$rlDefer_to_default_processing"/>
         <xsl:variable name="justification" select="$rlTypeWasNotFoundUnacceptable"/>
         <xsl:message  select="acv:explainTriple($subclass,$predicate,$superclass,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/-->
         <xsl:apply-templates select="." mode="default"/> <!-- DEFER -->
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>
   </xd:detail>
</xd:doc>
<xsl:template match="wgs:lat | wgs:long | wgs:alt">
   <xsl:variable name="owl:sameAs" select="concat($rdf-abbrev-plan,'#WGS_Filter_461')"/>
   <xsl:variable name="rdf:type"   select="concat($rdf-abbrev-plan,'#Filter')"/>

   <xsl:variable name="subject"   select="../@rdf:about | ../@rdf:nodeID"/> <!-- rdf:about a uri, rdf:nodeID a bnode -->
   <xsl:variable name="predicate" select="xfm:uri(.)"/>
   <xsl:variable name="object"    select="vsr:getObject(.)"/>

   <xsl:variable name="action"        select="$rlPrevent_default_processing"/>
   <xsl:variable name="justification" select="'lat/long is in label'"/>
   <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
</xsl:template>

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>
   </xd:detail>
</xd:doc>
<xsl:template match="p:cardinality">
   <xsl:variable name="owl:sameAs" select="concat($rdf-abbrev-plan,'#ReificationWithCardinalityEdges_479')"/>
   <xsl:variable name="rdf:type"   select="concat($rdf-abbrev-plan,'#Handler')"/>

   <xsl:variable name="subject"   select="../@rdf:about | ../@rdf:nodeID"/>
   <xsl:variable name="predicate" select="xfm:uri(.)"/>
   <xsl:variable name="element"   select="@rdf:resource | @rdf:nodeID"/>

   <xsl:variable name="p"             select="key('descriptions-by-subject',$subject)"/>
   <xsl:variable name="isReification" select="$p/(rdf:subject or $rdf:object)"/>

   <xsl:choose>
      <xsl:when test="$isReification and false()">
         <xsl:variable name="action"        select="$rlPrevent_default_processing"/>
         <xsl:variable name="justification" select="'lists have labels enumerating elements and it is messy to point to elements.'"/>
         <xsl:message  select="acv:explainTriple($subject,$predicate,$element,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:variable name="action"        select="$rlDefer_to_default_processing"/>
         <xsl:variable name="justification" select="'visuallyAbbreviate=false'"/>
         <xsl:message  select="acv:explainTriple($subject,$predicate,$element,$owl:sameAs,'vis-art-uri',$action,'',$justification)"/>
         <xsl:apply-templates select="." mode="default"/> <!-- DEFER -->
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>


<xd:doc>
   <xd:short></xd:short>
   <xd:detail>This is the entry point to the default processing for predicates that do not match a Filter or Augmentor template.
   </xd:detail>
</xd:doc>
<xsl:template match="rdf:Description/*" priority="-.5">

   <xsl:param    name="deferrer"   select="''"/>
   <xsl:variable name="owl:sameAs" select="concat($rdf-abbrev-plan,'#RDF-ABBREV_Cleanup_crew_512')"/>
   <xsl:variable name="rdf:type"   select="concat($rl,'Relaxer')"/>

   <xsl:variable name="subject"   select="../@rdf:about | ../@rdf:nodeID"/>
   <xsl:variable name="predicate" select="xfm:uri(.)"/>
   <xsl:variable name="object"    select="vsr:getObject(.)"/>
   <xsl:message                   select="acv:arriveTriple($owl:sameAs,$subject,$predicate,$object,$deferrer)"/>

   <!--xsl:call-template name="blacklist_checker"-->
   <xsl:apply-templates select="." mode="blacklist_checker">
      <xsl:with-param name="blacklisted-subjects"             select="$rdfabbr-blacklisted-subjects"/>
      <xsl:with-param name="blacklisted-subject-namespaces"   select="$rdfabbr-blacklisted-subject-namespaces"/>
      <xsl:with-param name="blacklisted-predicates"           select="$rdfabbr-blacklisted-predicates"/>
      <xsl:with-param name="blacklisted-predicate-namespaces" select="$rdfabbr-blacklisted-predicate-namespaces"/>
      <xsl:with-param name="blacklisted-objects"              select="$rdfabbr-blacklisted-objects"/>
      <xsl:with-param name="blacklisted-object-namespaces"    select="$rdfabbr-blacklisted-object-namespaces"/>
      <xsl:with-param name="swap-directionality-predicates"   select="$rdfabbr-swap-directionality-predicates"/>
   </xsl:apply-templates>
   <!-- blacklist_checker calls match="rdf:Description/*" mode="default" if nothing was blacklisted -->
</xsl:template>


<xd:doc>
   <xd:short></xd:short>
   <xd:detail>This is the entry point to the default processing from Augmentor templates that defer.
   </xd:detail>
   <xd:param name="qualifying-predicates">
      e.g. sio:has-attribute, prov:qualifiedUsage
   </xd:param>
   <xd:param name="qualification-classes">
      e.g. sio:Attribute, prov:Usage
   </xd:param>
   <xd:param name="qualified-object-predicates">
      e.g. sio:refers-to, prov:entity
   </xd:param>
   <xd:param name="qualification-pairs">
      e.g. prov:Usage,prov:used
   </xd:param>
   <xd:param name="relaxed-object-classes">
      Instances of the following classes render a distinct visual element
      for each of its occurrences as an object of a data triple.
   </xd:param>
</xd:doc>
<xsl:template match="rdf:Description/*" mode="default">
   <xsl:param name="deferrer"                       select="''"/>
   <xsl:param name="qualifying-predicates"          select="()"                                      tunnel="yes"/>
   <xsl:param name="qualification-classes"          select="()"                                      tunnel="yes"/>
   <xsl:param name="qualified-object-predicates"    select="()"                                      tunnel="yes"/>
   <xsl:param name="qualification-pairs"            select="()"                                      tunnel="yes"/>
   <xsl:param name="swap-directionality-predicates" select="$rdfabbr-swap-directionality-predicates" tunnel="yes"/>
   <!-- TODO: parameterize distinction between 'swap-visual-directionality-predicates' and 'swap-force-directionality-predicates'-->
   <xsl:param name="predicate-color-strategy"       select="()"                                      tunnel="yes"/>
   <xsl:param name="edge-thickness-predicates"      select="()"                                      tunnel="yes"/>
   <xsl:param name="label"                                                                           tunnel="yes"/>
   <xsl:param name="namespaces-to-relax"            select="()"                                      tunnel="yes"/>
   <xsl:param name="relax-identical-literals"       select="true()"                                  tunnel="yes"/>
   <xsl:param name="relaxed-object-classes"         select="()"                                      tunnel="yes"/>
   <xsl:param name="subject-view-context"           select="''"                                      tunnel="yes"/>
   <xsl:param name="object-view-context"            select="''"                                      tunnel="yes"/>

   <!-- The URI for _this_ template, and its type. -->
   <xsl:variable name="owl:sameAs" select="concat($rdf-abbrev-plan,'#RDF-ABBREV_Default_statement_handler_579')"/>
   <xsl:variable name="rdf:type"   select="$vsr:Relaxer"/>

   <!-- Orient with domain form -->
   <xsl:variable name="subject"   select="../@rdf:about | ../@rdf:nodeID"/>
   <xsl:variable name="predicate" select="xfm:uri(.)"/>
   <xsl:variable name="object"    select="vsr:getObject(.)"/>
   <xsl:message                   select="acv:arriveTriple($owl:sameAs,$subject,$predicate,$object,$deferrer)"/>
   <!--xsl:message                   select="concat('relax identical literals: ',$relax-identical-literals)"/-->

   <!-- Gather certain properties -->
   <xsl:variable name="rdf-rest"                          select="key('descriptions-by-subject',$subject)/rdf:rest"/>
   <xsl:variable name="object-is-subject"                 select="key('descriptions-by-subject',$object)/*"/>
   <xsl:variable name="is-reification"                    select="key('descriptions-by-subject',$subject)/rdf:subject"/>
   <xsl:variable name="subject-has-same-domain-and-range" select="$predicate = $rdfs:domain and key('descriptions-by-subject',$subject)/rdfs:range[@rdf:resource = $object]"/>
   <xsl:variable name="subject-has-same-range-and-domain" select="$predicate = $rdfs:range and key('descriptions-by-subject',$subject)/rdfs:domain[@rdf:resource = $object]"/>
   <xsl:variable name="part-of-a-reification-quad"        select="$predicate = ($rdf:subject, $rdf:predicate, $rdf:object, $ps, $pp, $po)"/> <!-- TODO: rm this, is-reification does it-->

   <!-- Classify subject -->
   <xsl:variable name="subject-is-bnode"     select="../@rdf:nodeID"/>
   <xsl:variable name="object-is-resource"   select="@rdf:resource or @rdf:nodeID"/>
   <xsl:variable name="object-is-literal"    select="@rdf:datatype or @xml:lang or text()"/>
   <xsl:variable name="object-is-bnode"      select="@rdf:nodeID"/>
   <xsl:variable name="literal-has-datatype" select="@rdf:datatype"/>
   <xsl:variable name="literal-has-lang"     select="@xml:lang"/> <!-- triple's object is a literal with language encoding -->

   <xsl:variable name="p"                             select="key('descriptions-by-subject',$subject)"/> <!-- TODO: rename p to s -->
   <xsl:variable name="o"                             select="key('descriptions-by-subject',$object)"/>

   <!--                                                e.g. sio:refers-to, prov:entity -->
   <xsl:variable name="q-object" select="$o/*[xfm:uri(.) = $qualified-object-predicates]/(@rdf:resource | */rdf:about)[1]"/>
   <xsl:variable name="q-o"      select="key('descriptions-by-subject',$q-object)"/>

   <xsl:variable name="true-object" select="if ($q-object) then $q-object else $object"/>

   <xsl:variable name="object-is-set-operation"       select="key('descriptions-by-subject',$object)/(owl:unionOf | owl:intersectionOf | owl:complementOf)"/>
   <xsl:variable name="set-operand"                   select="$object-is-set-operation/(@rdf:resource | @rdf:nodeID)"/>
   <xsl:variable name="set-operand-a-list"            select="key('descriptions-by-subject',$set-operand)/rdf:first"/>
   <xsl:variable name="object-is-qualification-and-should-be-swapped" select="$o/rdf:type[@rdf:resource = $qualification-classes and 
                                                                                          @rdf:resource = $swap-directionality-predicates]"/>

   <!--xsl:message select="concat('BLAH: ',$object,' ',$object-is-bnode,' ',count($object-is-set-operation),' ',$set-operand,' ',$set-operand-a-list)"/-->

   <!--xsl:message select="concat('size of q-object ',$q-object,' = ',count($q-o))"/>
   <xsl:message select="concat('true-object ',$true-object)"/>

    debugging print-lines...
   <xsl:for-each-group select="$o/rdf:type/(@rdf:resource | */@rdf:about)" group-by="."> 
      <xsl:message select="concat('o type:            ',.)"/>
   </xsl:for-each-group>
   <xsl:for-each-group select="$q-o/rdf:type/(@rdf:resource | */@rdf:about)" group-by=".">
      <xsl:message select="concat('q-o type:          ',.)"/>
   </xsl:for-each-group>
   <xsl:for-each-group select="$relaxed-object-classes" group-by=".">
      <xsl:message select="concat(count($relaxed-object-classes),' relaxed classes: ',.)"/>
   </xsl:for-each-group-->

   <!-- If the predicate of this triple is an unqualified form of a qualification that is also asserted,       e.g. /- - - prov:used - - \  prov:qualifiedUsage -->
   <xsl:variable name="qualifying-predicate" select="$qualification-pairs/qualifying-predicate[prov:unqualifiedForm[@resource = $predicate]]/@about"/>
   <xsl:variable name="qualification"  select="$p/*[xfm:uri(.) = $qualifying-predicate]/(@rdf:resource | @rdf:nodeID)"/>
   <!--xsl:message select="concat($qualifying-predicate,' ',count($qualification),' qualifications')"/-->
   <xsl:variable name="qualification-ps" select="key('descriptions-by-subject',$qualification)"/>
   <xsl:variable name="predicate-is-unqualified-form-of-qualified-form-that-exists" select="$qualification-ps/*[xfm:uri(.) = $qualified-object-predicates and (@rdf:resource | @rdf:nodeID) = $true-object]"/>

   <xsl:variable name="qualified-thickness" select="$o/*[xfm:uri(.) = $edge-thickness-predicates][1]/text()"/>
   <!--xsl:message select="concat('qualified thickness: ',$qualified-thickness)"/-->

   <xsl:variable name="gedge-id" select="nmf:getUUIDName('gedge')"/> <!-- TODO: Just concat spo -->
   <!--xsl:variable name="gedge-id" select="concat($subject,' ',$predicate,' ',$object)"/-->
   <xsl:variable name="visualFormURI" select="concat($visual-artifact-uri,'/graphic/edge/',vsr:view-id($gedge-id))"/>

   <!-- 
     subject-vnode and object-vnode are optionally contextualized by some scope, defined by a URI. 
     If they are not contextualized, the have a global context.
     The contextualized view and the subject/object are phrased using the DOMAIN terminology.

     For example, if :Tim is drawn using two visual nodes, the view context could be from the perspective of two people that know Tim.
     In that case, the view context is the person knowing :Tim.

     Or, in OWL if a owl:Class is depicted using two visual nodes, 
     the view context could be from the perspective of the class that is referring to it as part of its restriction.
     Or, use a global context so that all classes point to the same class every time it is mentioned. This draws identity, but gets cluttered.

     It's all a tradeoff and an important part of the visual strategy to determine how it should be done.
   -->
   <xsl:variable name="subject-vnode">
      <!-- We are given the subject-view-context by our deferrer, as opposed to the object-view-context which we determine ourselves (below) for this particular triple. -->
      <xsl:choose>
         <xsl:when test="string-length($subject-view-context)">
            <xsl:variable name="value" select="concat($subject-view-context,' ',$subject)"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','subject-vnode',$value,'subject view is contextualized')"/>
            <xsl:value-of select="$value"/>
            <!-- TODO assert prov:specializationOf from this contextualized view to the global view -->
         </xsl:when>
         <xsl:otherwise>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','subject-vnode',$subject,'subject view context is global')"/>
            <xsl:value-of select="$subject"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="object-view-context">
      <!-- We determine the object-view-context ourselves for this particular triple.
           This view context is used to determine the 'object-vnode' below, 
           just like we did for 'subject-vnode' above using the subject view context provided by our deferrer. -->
      <xsl:choose>
         <xsl:when test="string-length($object-view-context)">
            <xsl:variable name="value" select="$object-view-context"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri',$vsr:from_context,$value,'object view is contextualized')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$q-o/rdf:type/(@rdf:resource | */@rdf:about) = $relaxed-object-classes">
            <xsl:variable name="value" select="concat($subject,' ',$predicate,' ',$object)"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri',$vsr:from_context,$value,'qualified object is of a relaxed class')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$o/rdf:type/(@rdf:resource | */@rdf:about) = $relaxed-object-classes">
            <xsl:variable name="value" select="concat($subject,' ',$predicate)"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri',$vsr:from_context,$value,'object is of a relaxed class')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="''"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri',$vsr:from_context,'','object view context is global')"/> <!-- 8 -->
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <!-- Determine if a new vnode should be created to depict the object of this triple. -->
   <xsl:variable name="object-vnode">
      <xsl:variable name="unique-literal-vnode" select="concat($subject,'_',$predicate,'_',$object,'_',@rdf:datatype,@xml:lang,'_value')"/>
      <xsl:choose>
         <xsl:when test="string-length($object-view-context) and $q-object">
            <xsl:variable name="value" select="concat($object-view-context,' ',$q-object)"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-vnode',$value,'qualified object was given a view-context')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="string-length($object-view-context)">
            <xsl:variable name="value" select="concat($object-view-context,' ',$object)"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-vnode',$value,'object has view context')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = $qualifying-predicates"> <!-- Skip through Qualification to the qualified object. -->
            <xsl:variable name="value" select="$o/*[xfm:uri(.) = $qualified-object-predicates]/(@rdf:resource | @rdf:nodeID)"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-vnode',$value,'property is a qualification')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="pmm:bestNamespace($object) = $namespaces-to-relax">
            <xsl:variable name="value" select="$unique-literal-vnode"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-vnode',$value,'object is in relaxed namespace')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <!--xsl:when test="matches($object,'^http://inference-web.org/registry/*')">  TODO: make sure this is handled by TEMPLATE-namespaces-to-relax or similar.
            <- All resources within this namespace should be relaxed ->
            <xsl:value-of select="$unique-literal-vnode"/>
            <xsl:message select="concat('explain object vnode: ',pmm:bestQName($object),'relaxed b/c in relaxed namespace')"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-vnode',$unique-literal-vnode,'relaxed namespace')"/>
         </xsl:when-->
         <xsl:when test="$object-is-bnode and $object-is-set-operation and $set-operand-a-list">
            <!-- merge multiple bnodes into a single vnode (TODO: sort list)-->
            <xsl:variable name="set-operand-list-string">
               <xsl:call-template name="list-string">
                  <xsl:with-param name="first"      select="$set-operand"/>
                  <!--xsl:with-param name="connective" select="','"/-->
                  <xsl:with-param name="connective" select="xfm:connective(xfm:uri($object-is-set-operation))"/>
               </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="$set-operand-list-string"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-vnode',
                                                    $set-operand-list-string,
                                                   '$subject-is-bnode and $object-is-set-operation and $set-operand-a-list')"/>
         </xsl:when>
         <xsl:when test="$object-is-resource">
            <xsl:value-of select="$object"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-vnode',$object,'$object-is-resource')"/>
         </xsl:when>
         <xsl:when test="$draw-literal-rdf">
            <xsl:value-of select="$unique-literal-vnode"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-vnode',$unique-literal-vnode,'$draw-literal-rdf')"/>
         </xsl:when>
         <xsl:when test="$object-is-literal and $relax-identical-literals">
            <xsl:value-of select="$unique-literal-vnode"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-vnode',$unique-literal-vnode,'$object-is-literal and $relax-identical-literals')"/>
         </xsl:when>
         <xsl:when test="$object-is-literal">
            <!-- all identical literals will have the same vnode -->
            <xsl:value-of select="concat($object,'_',@rdf:datatype,@xml:lang)"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-vnode',concat($object,'_',@rdf:datatype,@xml:lang),'$object-is-literal')"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$unique-literal-vnode"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-vnode',$unique-literal-vnode,'object vnode otherwise')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <!-- Visual properties of the visual connection -->

   <!--xd:doc>
      <xd:short></xd:short>
      <xd:detail>The identifier for the visual element <b>from which</b> this force-based edge points to another visual element.
      </xd:detail>
   </xd:doc-->

   <xsl:variable name="from">
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:variable name="value" select="$subject"/>
            <!-- logging is done in "to" -->
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = $swap-directionality-predicates">
            <xsl:variable name="value" select="$object-vnode"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from,       vsr:view-id($value),'$swap-directionality-predicates')"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from_domain,            $value, '$swap-directionality-predicates')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$object-is-qualification-and-should-be-swapped">
            <xsl:variable name="value" select="$q-object"/>
            <xsl:variable name="justification" select="'qualification class is a $swap-directionality-predicates'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from,       vsr:view-id($value),$justification)"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from_domain,            $value, $justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = $rdfs:subClassOf and $object-is-bnode">
            <!-- TODO: this should be pushed up to owl and it should call down with 'swap-directionality-predicates' -->
            <xsl:variable name="value" select="$subject-vnode"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from,       vsr:view-id($value),'subclassof of object is bnode')"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from_domain,            $value, 'subclassof of object is bnode')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="$subject-vnode"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from,       vsr:view-id($value),'no need to force edge to opposite direction of underlying data')"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from_domain,            $value, 'no need to force edge to opposite direction of underlying data')"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="depicts">
      <xsl:choose>
         <xsl:when test="$predicate = $qualifying-predicates">
            <xsl:variable name="value" select="$object"/>
            <xsl:variable name="justification" select="'property is a qualification'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:depicts,$value,$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="concat(' ',$predicate)"/>
            <xsl:variable name="justification" select="'property is not a qualification'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:depicts,$value,$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="stroke-color">
      <xsl:variable name="strategic-color" select="$predicate-color-strategy/visual-form[predicate[.=$predicate]]"/>
      <xsl:choose>
         <xsl:when test="$strategic-color">
            <xsl:variable name="value" select="$strategic-color/@stroke-color"/>
            <xsl:variable name="justification" select="'$strategic-color'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$vsr:stroke,$vsr:stroke,string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$draw-literal-rdf">
            <xsl:variable name="value" select="'0.701961'"/>
            <xsl:variable name="justification" select="'draw-literal-rdf'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$vsr:stroke,$vsr:stroke,string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = ($owl:disjointWith, $owl:complementOf)">
            <xsl:variable name="value" select="'0'"/> <!-- black -->
            <xsl:variable name="justification" select="'$predicate = ($owl:disjointWith, $owl:complementOf)'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:stroke,string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = $swap-directionality-predicates">
            <xsl:variable name="value" select="'0.68'"/> <!-- gray, slightly darker -->
            <xsl:variable name="justification" select="'$predicate = $swap-directionality-predicates'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:stroke,string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>                              <!-- gray, slightly darker -->
         <xsl:when test="$predicate = $rdf:type">
            <xsl:variable name="value" select="'0.66'"/> <!-- gray, slightly darker -->
            <xsl:variable name="justification" select="'$predicate = $rdf:type'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:stroke,string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$is-reification or $part-of-a-reification-quad">
            <xsl:variable name="value" select="'0.64'"/> <!-- gray, slightly darker -->
            <xsl:variable name="justification" select="'$is-reification or $part-of-a-reification-quad'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:stroke,string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="not($object-is-subject) and $object-is-resource">
            <xsl:variable name="value" select="'0.81'"/> <!-- very light gray -->
            <xsl:variable name="justification" select="'not($object-is-subject) and $object-is-resource'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:stroke,string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="'0.701961'"/> <!-- gray -->
            <xsl:variable name="justification" select="'stroke color otherwise'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:stroke,string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="tail-style">
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:variable name="value" select="'0'"/>
            <xsl:variable name="justification" select="'draw literal rdf'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'tail-style',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = ($owl:disjointWith, $owl:complementOf)">
            <xsl:variable name="value" select="'NonNavigable'"/>
            <xsl:variable name="justification" select="'$predicate = ($owl:disjointWith, $owl:complementOf)'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'tail-style',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when> <!-- X on end -->
         <xsl:when test="$predicate = $rdf:subject">
            <xsl:variable name="value" select="''"/> <!-- do not draw head -->
            <xsl:variable name="justification" select="'$predicate = $rdf:subject'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'tail-style',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = $swap-directionality-predicates">
            <xsl:variable name="value" select="'FilledArrow'"/> <!-- classic arrow head (pretend to be the head) -->
            <xsl:variable name="justification" select="'$predicate = $swap-directionality-predicates'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'tail-style',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$object-is-qualification-and-should-be-swapped">
            <xsl:variable name="value" select="'FilledArrow'"/> <!-- classic arrow head (pretend to be the head) -->
            <xsl:variable name="justification" select="'$object-is-qualification-and-should-be-swapped'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'tail-style',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="''"/>
            <xsl:variable name="justification" select="'tail style otherwise'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'tail-style',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="line-style">
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:value-of select="'0'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'line-style','0','$draw-literal-rdf')"/>
         </xsl:when>      <!-- solid -->
         <xsl:when test="$object-is-subject">
            <xsl:value-of select="'0'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'line-style','0','$object-is-subject')"/>
         </xsl:when>      <!-- solid -->
         <xsl:when test="not($object-is-subject) and $object-is-resource">
            <xsl:value-of select="'1'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'line-style','1','not($object-is-subject) and $object-is-resource')"/>
         </xsl:when>
         <xsl:otherwise> <!-- - - - - - - -->
            <xsl:value-of select="'2'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'line-style','2','line style otherwise')"/>
         </xsl:otherwise> <!-- dotted -->
      </xsl:choose>
   </xsl:variable>
      <xsl:variable name="line-width">
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:value-of select="''"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'line-width','','$draw-literal-rdf')"/>
         </xsl:when>
         <xsl:when test="$predicate = ($owl:disjointWith,$owl:complementOf)">
            <xsl:value-of select="'2'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'line-width','2','$predicate = ($owl:disjointWith,$owl:complementOf)')"/>
         </xsl:when>
         <xsl:when test="not($object-is-subject) and $object-is-resource">
            <xsl:value-of select="'2'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'line-width','2','not($object-is-subject) and $object-is-resource')"/>
         </xsl:when> <!-- was 3, but it's over the top -->
         <xsl:when test="$predicate = $qualifying-predicates and string-length($qualified-thickness)">
            <!--xsl:message select="concat('YES edge thickness is ',$qualified-thickness,' - ',math:log(xs:double($qualified-thickness)))"/-->
            <!--xsl:variable name ="value" select="math:max(xs:integer(math:log(xs:double($qualified-thickness))),
                                                         1)"/-->
            <xsl:variable name ="value" select="$qualified-thickness"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'line-width','20','i say so')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="''"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'line-width','','line width otherwise')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
      <xsl:variable name="draw-shadow">
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:value-of select="'NO'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'draw-shadow','NO','draw-literal-rdf')"/>
         </xsl:when>
         <xsl:when test="not($object-is-subject) and $object-is-resource">
            <xsl:variable name="value" select="'NO'"/> <!-- SWITCHED was YES, but too slow -->
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'draw-shadow',$value,'not($object-is-subject) and $object-is-resource')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="'NO'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'draw-shadow','NO','draw shadow otherwise')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="label">
      <xsl:choose>
         <xsl:when test="string-length($label)">
            <xsl:variable name="value" select="$label"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$rdfs:label,$value,'provided by deferrer')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = $qualifying-predicates">
            <!--xsl:variable name="value" select="$o/*[xfm:uri(.) = $qualified-object-predicates]/(@rdf:resource | @rdf:nodeID)"/-->
            <xsl:variable name="value">
               <xsl:for-each-group select="$o/rdf:type" group-by="@rdf:resource">
                  <xsl:if test="@rdf:resource = $qualification-classes">
                     <xsl:value-of select="concat(replace(pmm:bestLabelFor(vsr:getObject(.)),'^.*\.',''),' ')"/>
                  </xsl:if>
               </xsl:for-each-group>
            </xsl:variable>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$rdfs:label,$value,'$predicate = $qualifying-predicates')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$draw-literal-rdf">
            <xsl:variable name="value" select="pmm:bestQName($predicate)"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$rdfs:label,$value,'$draw-literal-rdf')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = $owl:onProperty">
            <xsl:variable name="value" select="''"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$rdfs:label,$value,'$predicate = $owl:onProperty')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$subject-has-same-domain-and-range">
            <xsl:variable name="value" select="'rdfs:domain and rdfs:range'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$rdfs:label,$value,'$subject-has-same-domain-and-range')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$subject-has-same-range-and-domain">
            <xsl:variable name="value" select="'rdfs:range and rdfs:domain'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$rdfs:label,$value,'$subject-has-same-range-and-domain')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="pmm:tryQName($predicate)"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$rdfs:label,$value,'label o/w')"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="edge-notes">
      <xsl:choose>
         <xsl:when test="$predicate = $qualifying-predicates">
            <!--xsl:variable name="value" select="$o/*[xfm:uri(.) = $qualified-object-predicates]/(@rdf:resource | @rdf:nodeID)"/-->
            <xsl:variable name="value">
               <xsl:for-each-group select="$o/rdf:type" group-by="@rdf:resource">
                  <xsl:if test="@rdf:resource = $qualification-classes">
                     <xsl:value-of select="replace(pmm:bestLabelFor(vsr:getObject(.)),'^.*\.','')"/>
                  </xsl:if>
               </xsl:for-each-group>
            </xsl:variable>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'edge-notes',$value,'$predicate = $qualifying-predicates')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="pmm:tryQName($predicate)"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'edge-notes',pmm:tryQName($predicate),'edge notes otherwise')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="font-color">
      <xsl:choose>
         <xsl:when test="true()"> <!-- Devalue edge label -->
            <xsl:variable name="value" select="'.4 .4 .4'"/>
            <xsl:variable name="justification" select="'devalue to layer edges and nodes.'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'font-color',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$draw-literal-rdf">
            <xsl:variable name="value" select="'0 0 0'"/>
            <xsl:variable name="justification" select="'literal rdf'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'font-color',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="'0.701961'"/>
            <xsl:variable name="justification" select="'font color otherwise'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'font-color',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="head-style">
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:value-of select="'FilledArrow'"/>
            <xsl:variable name="value" select="'FilledArrow'"/>
            <xsl:variable name="justification" select="'draw-literal-rdf'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'head-style',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = $owl:disjointWith">
            <xsl:variable name="value" select="'NonNavigable'"/> <!-- X on end -->
            <xsl:variable name="justification" select="'$predicate = $owl:disjointWith'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'head-style',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = $owl:complementOf">
            <xsl:variable name="value" select="'UML2Socket'"/> <!-- ) on end -->
            <xsl:variable name="justification" select="'$predicate = $owl:complementOf'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'head-style',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = $swap-directionality-predicates">
            <xsl:variable name="value" select="'0'"/> <!-- no head (pretend to be the tail) -->
            <xsl:variable name="justification" select="'$predicate = $swap-directionality-predicates'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'head-style',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$object-is-qualification-and-should-be-swapped">
            <xsl:variable name="value" select="'0'"/> <!-- no head (pretend to be the tail) -->
            <xsl:variable name="justification" select="'$object-is-qualification-and-should-be-swapped'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'head-style',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="'FilledArrow'"/> <!-- classic arrow head -->
            <xsl:variable name="justification" select="'head style otherwise'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'head-style',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <!--xd:doc>
      <xd:short></xd:short>
      <xd:detail>The identifier for the visual element <b>to which</b> this force-based edge points from another visual element.
      </xd:detail>
   </xd:doc-->
   <xsl:variable name="to">
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:variable name="value" select="$object-vnode"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from,$value,vsr:view-id($from),vsr:view-id($value),'$draw-literal-rdf')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = $rdfs:subClassOf and $object-is-bnode">
            <xsl:variable name="value" select="$object-vnode"/>
            <xsl:variable name="justification" select="'$predicate = $rdfs:subClassOf and $object-is-bnode'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from,$value,vsr:view-id($from),vsr:view-id($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = $swap-directionality-predicates">
            <xsl:variable name="value" select="$subject-vnode"/>
            <xsl:variable name="justification" select="'$predicate = $swap-directionality-predicates'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from,$value,vsr:view-id($from),vsr:view-id($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$object-is-qualification-and-should-be-swapped">
            <xsl:variable name="value" select="$subject-vnode"/>
            <xsl:variable name="justification" select="'qualification class is a $swap-directionality-predicates'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from,$value,vsr:view-id($from),vsr:view-id($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="$object-vnode"/>
            <xsl:variable name="justification" select="'to otherwise'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from,$value,vsr:view-id($from),vsr:view-id($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <!-- Visual properties of the object-vnode -->

   <xsl:variable name="object-label">
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:variable name="value" select="$object"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-label',$value,'$draw-literal-rdf')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="pmm:tryQName($object)"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-label',$value,'$draw-literal-rdf')"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="object-font-color">
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:variable name="value" select="'0 0 0'"/>
            <xsl:variable name="justification" select="'draw-literal-rdf'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-font-color',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <!-- TODO: make dc literals 0 0 166 -->
         <xsl:when test="$predicate = $rdfs:label">
            <xsl:variable name="value" select="'1 0 .501961'"/> <!--        pink label -->
            <xsl:variable name="justification" select="'$predicate = $rdfs:label'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-font-color',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = $rdfs:comment">
            <xsl:variable name="value" select="'0 0 1'"/> <!--        blue label -->
            <xsl:variable name="justification" select="'$predicate = $rdfs:comment'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-font-color',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$object-is-literal">
            <xsl:variable name="value" select="'0 0 .65'"/> <!-- darker blue label -->
            <xsl:variable name="justification" select="'object is literal'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-font-color',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="'0 0 0'"/> <!--       black label -->
            <xsl:variable name="justification" select="'object is literal'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-font-color',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="object-width">
      <xsl:choose>
         <xsl:when test="string-length($object-label) gt 45">360</xsl:when> <!-- Avoid wide comments -->
         <xsl:otherwise></xsl:otherwise>                                    <!-- wrap to shape - could be wide -->
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="object-wrap-text">
      <xsl:choose>
         <xsl:when test="string-length($object-label) gt 45">true</xsl:when> <!-- Avoid wide comments -->
         <xsl:otherwise>false</xsl:otherwise>                                <!-- wrap to shape - could be wide -->
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="h-text-pad">
      <xsl:choose>
         <xsl:when test="$subject-is-bnode">
            <xsl:value-of select="'5'"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','h-text-pad','5','$subject-is-bnode')"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="'5'"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','h-text-pad','5','h-text-pad otherwise')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="object-draw-fill">
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:value-of select="'YES'"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-draw-fill','YES','draw-literal-rdf')"/>
         </xsl:when>
         <xsl:when test="$predicate = ($rdfs:label, $rdfs:comment)">
            <xsl:value-of select="'NO'"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-draw-fill','NO','$predicate = ($rdfs:label, $rdfs:comment)')"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="'YES'"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-draw-fill','YES','object draw fill otherwise')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="action">
      <xsl:choose>
         <xsl:when test="$object-is-resource"> <xsl:value-of select="concat($rl,'Draw_resource_statement_literally')"/> </xsl:when>
         <xsl:when test="$object-is-literal">  <xsl:value-of select="concat($rl,'Draw_literal_statement_literally')"/> </xsl:when>
         <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="justification" select="'default processing permitted.'"/>

   <xsl:variable name="at-or-carat">
      <xsl:choose> <!-- a typed literal -->
         <xsl:when test="$draw-literal-rdf"></xsl:when>
         <xsl:when test="@rdf:datatype">^^</xsl:when>
         <xsl:when test="@xml:lang">@</xsl:when>
         <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="should-depict"> <!-- a triple -->
      <xsl:choose>
         <xsl:when test="string-length($from) = 0 or string-length($to) = 0">
            <xsl:variable name="value" select="'false'"/>
            <xsl:variable name="justification" select="'from or to empty'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','should-depict',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="@xml:lang and not(@xml:lang = $only-show-language)">
            <xsl:variable name="value" select="'false'"/>
            <xsl:variable name="justification" select="'filtering literal language'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','should-depict',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="idm:hasIdentified($visual-element-hash,$gedge-id)">
            <xsl:variable name="value" select="'false'"/>
            <xsl:variable name="justification" select="'triple already rendered'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','should-depict',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$subject-is-bnode and $p/rdf:type">
            <xsl:variable name="value" select="'false'"/>
            <xsl:variable name="justification" select="'type of bnode subject is given in label'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','should-depict',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate-is-unqualified-form-of-qualified-form-that-exists">
            <xsl:variable name="value" select="'false'"/>
            <xsl:variable name="justification" select="'qualified form of unqualified triple is present'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','should-depict',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = $qualified-object-predicates">
            <xsl:variable name="value" select="'false'"/>
            <xsl:variable name="justification" select="'predicate is redundant part of a qualified form'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','should-depict',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="@rdf:resource | @rdf:nodeID | @rdf:datatype | @xml:lang | text()">
            <xsl:variable name="value" select="'true'"/>
            <xsl:variable name="justification" select="'known structure'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','should-depict',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:message select="concat($in,'WARNING: hit unhandled description: ',name(),' (could be empty text())',' attributes:')"/>
            <xsl:for-each select="@*">
               <xsl:message select="concat($in,name())"/>
            </xsl:for-each>

            <xsl:variable name="value" select="'false'"/>
            <xsl:variable name="justification" select="'should depict otherwise'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','should-depict',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <!--xsl:message select="acv:explainTriple($subject,$predicate,concat($object,$at-or-carat,@rdf:datatype,@xml:lang),$owl:sameAs,'vis-art-uri',$action,'',$justification)"/-->

   <xsl:if test="$should-depict = 'true'">

      <xsl:if test="not(idm:hasIdentified($visual-element-hash,$subject-vnode))">
         <xsl:message select="concat('          ® ® ®','')"/>
         <xsl:message select="concat('          ® ® ® drawing subject ',$subject)"/>
         <xsl:message select="concat('          ® ® ®','')"/>
         <!-- A bit of a hack to provide a context node for the template's key -->
         <!--xsl:for-each-group select="key('descriptions-by-subject',$subject)
                                      /(@rdf:about | @rdf:resource | @rdf:nodeID | @rdf:ID)" group-by="."-->
         <xsl:apply-templates select="$subject" mode="default">
            <!-- Will typically defer to RDF-ABBREV_resource_visual_form_factory_1387 below -->
            <xsl:with-param name="deferrer"     select="$owl:sameAs"/>
            <xsl:with-param name="view-context" select="$subject-view-context"/>
         </xsl:apply-templates>
         <!--/xsl:for-each-group-->
      </xsl:if>

      <!--xsl:if test="$object-is-literal and not(idm:hasIdentified($visual-element-hash,$object-vnode))"-->
      <xsl:if test="not(idm:hasIdentified($visual-element-hash,$object-vnode))">
         <xsl:choose>
            <xsl:when test="$object-is-resource">
               <xsl:message select="concat('          ®   o','')"/>
               <xsl:message select="concat('          ®   o drawing true object ',$true-object,' ',
                                                                   'orig object ',$object,' ',
                                                           'true object described ',count(key('descriptions-by-subject',$true-object)),' times; ',
                                                           'references: ',count(//*[@rdf:resource | @rdf:nodeID | @rdf:ID = $object]/@rdf:resource),' ',
                                                           'in context ',$object-view-context)"/>
               <xsl:message select="concat('          ®   o','')"/>
               <!-- A bit of a hack to provide a context node for the template's key -->
               <xsl:for-each-group select="if (count(key('descriptions-by-subject', $true-object)/(@rdf:about | @rdf:resource | @rdf:nodeID | @rdf:ID)))
                                              then   key('descriptions-by-subject', $true-object)/(@rdf:about | @rdf:resource | @rdf:nodeID | @rdf:ID)
                                           else //*[@rdf:resource | @rdf:nodeID | @rdf:ID = $true-object]/(@rdf:resource | @rdf:nodeID | @rdf:ID)" group-by="."> <!-- second condition for 'sinks' -->
                  <xsl:apply-templates select="current-group()[1]" mode="default">
                     <!-- Typically defers to RDF-ABBREV_resource_visual_form_factory_1387 -->
                     <xsl:with-param name="deferrer"     select="$owl:sameAs"/>
                     <xsl:with-param name="view-context" select="$object-view-context"/>
                  </xsl:apply-templates>
               </xsl:for-each-group>
            </xsl:when>
            <xsl:otherwise>
               <xsl:message select="'          ( = = Drawing object with old, BAD WAY = = = = = = = = = = = = = = = = = = = = = )'"/>
               <!-- Mint the object-vnode for the literal -->
               <!-- This should be done by calling the original visual-element template, 
                    given a new context (as is done above). -->
               <xsl:call-template name="node">  
                  <xsl:with-param name="id"                  select="$object-vnode"/> <!-- id = (depicts, context, visual-artifact-uri, *)         -->
                                                                                      <!--       ^        ^        ^                    ^          -->
                                                                                      <!--       data     ""       vis,                 a bit more -->
                  <xsl:with-param name="depicts"             select="$object"/>
                  <xsl:with-param name="context"             select="$visual-artifact-uri"/>
                  <xsl:with-param name="visual-artifact-uri" select="$visual-artifact-uri"/>

                  <xsl:with-param name="label"               select="concat(' ',$object-label)"/>
                  <xsl:with-param name="x"                   select="5 * $separation[1]"/>
                  <xsl:with-param name="y"                   select="5 * $separation[2]"/>
                  <xsl:with-param name="font-color"          select="$object-font-color"/>
                  <xsl:with-param name="width"               select="$object-width"/>
                  <xsl:with-param name="h-text-pad"          select="$h-text-pad"/>
                  <xsl:with-param name="draw-fill"           select="$object-draw-fill"/>
                  <xsl:with-param name="wrap-text"           select="$object-wrap-text"/>
                  <xsl:with-param name="ignore"              select="idm:getIdentifier($visual-element-hash, $object-vnode)"/>
               </xsl:call-template>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:if>
      <xsl:if test="$literal-has-datatype or $literal-has-lang">
         <!-- TODO: make the node for the datatype, link from the triple's object to the datatype node -->
      </xsl:if>

      <!-- Make the edge from the resource to the object-vnode -->
      <xsl:message select="'          ® ~ o'"/>
      <xsl:message select="'          ® ~ o drawing edge'"/>
      <xsl:message select="'          ® ~ o'"/>
      <xsl:call-template name="edge">
         <xsl:with-param name="id"           select="$gedge-id"/>

         <xsl:with-param name="from"         select="$from"/> <!-- Encodes *force* directionality; not necessarily _visual_ directionality. -->
         <xsl:with-param name="to"           select="$to"/>   <!-- Encodes *force* directionality; not necessarily _visual_ directionality. -->

         <xsl:with-param name="depicts"      select="$depicts"/>

         <xsl:with-param name="line-style"   select="$line-style"/>
         <xsl:with-param name="line-width"   select="$line-width"/>
         <xsl:with-param name="stroke-color" select="$stroke-color"/>
         <xsl:with-param name="draw-shadow"  select="$draw-shadow"/>
         <xsl:with-param name="head-style"   select="$head-style"/>
         <xsl:with-param name="tail-style"   select="$tail-style"/>
         <xsl:with-param name="label"        select="$label"/>
         <xsl:with-param name="font-color"   select="$font-color"/>
         <xsl:with-param name="notes"        select="$edge-notes"/>
         <xsl:with-param name="url"          select="$predicate"/>
      </xsl:call-template>

   </xsl:if>
</xsl:template>

<xd:doc>
   <xd:short>Clean context-free visual element rendering.</xd:short>
   <xd:detail>
   </xd:detail>
   <xd:param name="deferrer">The URI of the template that called this one.</xd:param>

   <xd:param name="blacklisted-subject-classes">The classes whose instances should not render a visual element.</xd:param>
   <xd:param name="anonymous-instance-classes">Do not render the URI of instances in these classes in their labels (but include their type).</xd:param>
   <xd:param name="label-predicates">?? something about priorities.</xd:param>
   <xd:param name="in-label-predicates">Properties whose values should be rendered in the label of the visual element (as "attribute-value" pairs).</xd:param>
   <xd:param name="notes-predicates">Predicates whose values should appear in the V(subject)'s notes
                                     (and not appear as a visual edge/visual node).
   </xd:param>
   <xd:param name="class-strategy">Fill colors for a given set of classes.</xd:param>
   <xd:param name="namespace-strategy">Fill colors for instances of a given set of namespaces.</xd:param>
   <xd:param name="notes-predicates"></xd:param>
   <xd:param name="tooltip-predicates"></xd:param>
   <xd:param name="rooted-classes"></xd:param>
   <xd:param name="namespaces-to-relax">Mint new visual nodes for the occurrence of every URI in these namespaces.</xd:param>
   <xd:param name="namespaces-to-relax-in-ranges">Mint new visual nodes for the occurrence of every URI in these namespaces, IF they occur as objects of rdfs:range.</xd:param>
   <xd:param name="show-bnode-IDs">Include the serailized identifier for a bnode in its visual node's label.</xd:param>

   <xd:param name="shape"></xd:param>
   <xd:param name="label">The label to give the V(subject)</xd:param>
   <xd:param name="fill-color">Fill color of the V(subject) -- OVERRIDES the <tt>class-strategy</tt> and <tt>namespace-strategy</tt>.</xd:param>
   <xd:param name="stroke-color2">The color of the V(subject)'s border.</xd:param>
   <xd:param name="height">The height of the V(subject)'s node.</xd:param>
   <xd:param name="fit-text"></xd:param>
   <xd:param name="draw-stroke"></xd:param>
</xd:doc>
<xsl:template match="@rdf:about | @rdf:resource | @rdf:nodeID | @rdf:ID" mode="default" priority="-.25">
   <xsl:param name="deferrer"                                                   />

   <xsl:param name="blacklisted-subject-classes"                    tunnel="yes"/>

   <xsl:param name="view-context"                  select="''"                  />
   <xsl:param name="namespaces-to-relax"           select="()"      tunnel="yes"/>
   <xsl:param name="namespaces-to-relax-in-ranges" select="($xs)"               />

   <xsl:param name="class-strategy"                select="()"      tunnel="yes"/>
   <xsl:param name="namespace-strategy"            select="()"      tunnel="yes"/>

   <xsl:param name="anonymous-instance-classes"    select="()"      tunnel="yes"/>
   <xsl:param name="label-predicates"                               tunnel="yes"/>
   <xsl:param name="in-label-predicates"                            tunnel="yes"/>
   <xsl:param name="show-bnode-IDs"                select="false()"             />

   <xsl:param name="notes-predicates"              select="()"      tunnel="yes"/>
   <xsl:param name="tooltip-predicates"            select="()"      tunnel="yes"/>

   <xsl:param name="rooted-classes"                select="()"      tunnel="yes"/>

   <xsl:param name="a-root"                        select="false()" tunnel="yes"/>
   <xsl:param name="label"                         select="()"      tunnel="yes"/>
   <xsl:param name="fill-color"                                     tunnel="yes"/>
   <xsl:param name="stroke-color2"                                  tunnel="yes"/>
   <xsl:param name="shape"                                          tunnel="yes"/>
   <xsl:param name="x"                                              tunnel="yes"/>
   <xsl:param name="y"                                              tunnel="yes"/>
   <xsl:param name="height"                                         tunnel="yes"/>
   <xsl:param name="width"                                          tunnel="yes"/>
   <xsl:param name="fit-text"                                       tunnel="yes"/>
   <xsl:param name="draw-stroke"                                    tunnel="yes"/>

   <xsl:variable name="owl:sameAs" select="concat($rdf2-plan,'#RDF-ABBREV_resource_visual_form_factory_1387')"/>
   <xsl:variable name="rdf:type"   select="$vsr:VisualElementFactory"/>

   <xsl:variable name="defin" select="if (matches($deferrer,'RDF-ABBREV_Default_statement_handler')) then '          ' else ''"/>

   <!-- Orient with domain form -->
   <xsl:variable name="resource"           select="."/>
   <xsl:message select="acv:arriveResource($owl:sameAs,$resource,$deferrer,$defin)"/>

   <!-- Gather certain properties -->
   <xsl:variable name="sink"               select="not(key('descriptions-by-subject',$resource))"/>
   <xsl:variable name="already-created"    select="idm:hasIdentified($visual-element-hash,$resource)"/>
   <xsl:variable name="should-relax-by-ns" select="pmm:bestNamespace($resource) = $namespaces-to-relax"/>
   <xsl:variable name="position"           select="position()"/>


   <!--xsl:choose>
      <!-deprecated: incorporated into conditionals below:
         xsl:when test="$already-created">
         <xsl:message select="acv:explainResource($resource,$owl:sameAs,'vsr:NotRenderVisualElement','$visual-form-uri','$already-created')"/>
      </xsl:when->

      <!-TODO: rescue this: xsl:when test="$should-relax-by-ns">
         <xsl:message select="acv:explainResource($resource,$owl:sameAs,'vsr:NotRenderVisualElement',$visual-form-uri,'$should-relax-by-ns')"/>
      </xsl:when->

      <!- deprecated: incorporated with conditionals below
         xsl:when test="$sink">
         <xsl:message select="acv:explainResource($resource,$owl:sameAs,'vsr:RenderVisualElement','$visual-form-uri','sink')"/>
         <!-xsl:message select="concat('FOUND',$resource,$NL,$in,'(non-subject resource ',position(),') ',
                              idm:hasIdentified($visual-element-hash,$resource),' ',
                              idm:getIdentifier($visual-element-hash,$resource),$NL)"/->
         <xsl:call-template name="node">
            <xsl:with-param name="depicts"             select="$resource"/>
            <xsl:with-param name="context"             select="$visual-artifact-uri"/> <!- the "global" context ->
            <xsl:with-param name="visual-artifact-uri" select="$visual-artifact-uri"/>
            <xsl:with-param name="id"                  select="$resource"/> <!- DEPRECATE ->
            <xsl:with-param name="label"               select="pmm:tryQName($resource)"/>
            <xsl:with-param name="url"                 select="$resource"/>
            <xsl:with-param name="x"                   select="$separation[1]"/>
            <xsl:with-param name="y"                   select="$separation[2] * (1 + position())"/>
            <xsl:with-param name="draw-shadow"         select="'NO'"/>
            <xsl:with-param name="ignore"              select="idm:getIdentifier($visual-element-hash,$resource)"/>
         </xsl:call-template>
      </xsl:when->
      <xsl:otherwise-->

      <!--xsl:message select="('relaxed namespaces: ',count(namespaces-to-relax))"/-->

      <!-- Elements for all property/value pairs describing this subject -->
      <xsl:variable name="s"                select="key('descriptions-by-subject',$resource)"/> <!-- Elements for all property/value pairs describing this subject -->

      <!-- Gather certain properties -->
      <xsl:variable name="already-created"  select="idm:hasIdentified($visual-element-hash,$resource)"/>
      <xsl:variable name="rdf-types"        select="$s/rdf:type/@rdf:resource"/>
      <xsl:variable name="rdfs-labels"      select="$s/rdfs:label"/>
      <xsl:variable name="rdfs-comments"    select="$s/rdfs:comment"/>
      <xsl:variable name="rdfs-isDefinedBy" select="$s/rdfs:isDefinedBy"/>
      <xsl:variable name="rdfs-range"       select="$s/rdfs:range/@rdf:resource"/>
      <xsl:variable name="rdfs-domain"      select="$s/rdfs:domain/@rdf:resource"/>
      <xsl:variable name="priority-label-descriptions">
         <!-- TODO: this functionality was copied to owl2.xsl; consolidate. -->
         <xsl:for-each select="$label-predicates"> <!-- O( subjects X label-predicates X |p(s)| ) -->
            <xsl:variable name="label-pred" select="."/>
            <xsl:for-each select="$s/*">
               <xsl:variable name="predicate" select="xfm:uri(.)"/>
               <!--xsl:message select="concat($label-pred,'(',string-length(text()),') vs ',$predicate)"/-->
               <xsl:if test="xfm:uri(.) = $label-pred and string-length(text())">
                  <!--xsl:message select="'HIT'"/-->
                  <xsl:copy-of select="."/>
               </xsl:if>
            </xsl:for-each>
         </xsl:for-each>
      </xsl:variable>
      <!--xsl:message select="concat('numP: ',count($priority-label-descriptions/*),' of ',count($s/*),' are ',
                                     count($label-predicates),' label predicates.')"/-->

      <!--xsl:message select="('anonymous class check ',count($anonymous-instance-classes),$anonymous-instance-classes = $rdf-types)"/>
      <xsl:for-each select="$anonymous-instance-classes">
         <xsl:message select="('anonymous class check ',.,' ',. = $rdf-types)"/>
      </xsl:for-each-->

      <!-- Classify domain form -->
      <xsl:variable name="is-resource"                   select="xfm:uri(.) = ($rdf:about, $rdf:resource)"/> <!-- TODO: misnomer; means URI -->
      <xsl:variable name="is-bnode"                      select="xfm:uri(.) = $rdf:nodeID"/>
      <xsl:variable name="is-list"                       select="$s/rdf:rest"/>
      <xsl:variable name="is-reification"                select="$s/rdf:subject"/> <!-- TODO: make stroke gray -->
      <xsl:variable name="is-class"                      select="$rdf-types[.=$class-uris]"/>
      <xsl:variable name="is-property"                   select="$rdf-types[.=$property-uris]"/>
      <xsl:variable name="has-same-domain-and-range"     select="count($rdfs-range) = 1 and count($rdfs-domain) = 1 and $rdfs-domain = $rdfs-range"/>
      <xsl:variable name="is-restriction"                select="$s/owl:onProperty"/>
      <xsl:variable name="is-cardinality-restriction"    select="$is-restriction and ($s/owl:minCardinality or $s/owl:maxCardinality or $s/owl:cardinality)"/>
      <xsl:variable name="is-value-restriction"          select="$is-restriction and ($s/owl:allValuesFrom  or $s/owl:someValuesFrom or $s/owl:hasValue)"/>
      <xsl:variable name="is-set-operation"              select="$s/owl:unionOf | $s/owl:intersectionOf | $s/owl:complementOf"/>

      <!-- Variables for when this is a restriction node -->
      <xsl:variable name="cardinality-restriction-types" select="$s/owl:minCardinality | $s/owl:maxCardinality | $s/owl:cardinality"/>
      <xsl:variable name="value-restriction-type"        select="$s/owl:someValuesFrom | $s/owl:allValuesFrom  | $s/owl:hasValue"/>
      <xsl:variable name="restrictionType"               select="$s/owl:minCardinality | $s/owl:maxCardinality | $s/owl:cardinality |
                                                                 $s/owl:someValuesFrom | $s/owl:allValuesFrom  | $s/owl:hasValue"/> <!-- TODO: just | prev two -->
      <xsl:variable name="restrictionTypePs"             select="key('descriptions-by-subject',$restrictionType/@rdf:resource |
                                                                                               $restrictionType/@rdf:nodeID  )"/>
      <xsl:variable name="vRp"                           select="$restrictionTypePs/owl:unionOf | $restrictionTypePs/owl:intersectionOf |
                                                                 $restrictionTypePs/owl:complementOf"/>

      <!-- variables for when this is a node with owl:unionOf, owl:intersectionOf, or owl:complementOf -->
      <xsl:variable name="cardinality-string" select="concat(if ($s/owl:minCardinality) then concat('minHHHHH ',      $s/owl:minCardinality) else '',
                                                            if ($s/owl:cardinality)    then concat(', exactlyHHHHH ',$s/owl:cardinality)    else '',
                                                            if ($s/owl:maxCardinality) then concat(', maxHHHHH ',    $s/owl:maxCardinality) else '')"/>

      <xsl:variable name="should-relax-rdfs-domain"  select="count($rdfs-range) = 1 and pmap:canAbbreviate($pmap,$rdfs-range)
                                                             and pmm:bestNamespace($rdfs-range) = $namespaces-to-relax-in-ranges"/> <!--  -->

      <xsl:variable name="instance-should-assume-label-of-class" select="count($rdfs-range) = 1 and pmap:canAbbreviate($pmap,$rdfs-range)
                                                             and pmm:bestNamespace($rdfs-range) = $namespaces-to-relax-in-ranges"/> <!--  -->

      <xsl:variable name="rdf-types-as-string"> <!-- string of QNames for this subject's types -->
         <xsl:for-each select="$rdf-types">
            <!--xsl:message select="concat('TYPES: ',.,' ',pmm:tryQName(.))"/-->
            <xsl:value-of select="concat(pmm:tryQName(.),if (position() != last()) then ', ' else '')"/>
         </xsl:for-each>
      </xsl:variable>
                                                         <!--xsl:for-each select="$class-strategy/visual-form/class">
                                                            <xsl:if test="text() = $rdf-types">
                                                               <xsl:message select="concat(../@fill-color,' ',text())"/>
                                                            </xsl:if>
                                                         </xsl:for-each-->
                                                         <!--xsl:for-each select="$class-fill">
                                                            <xsl:message select="concat('class-fill: ',.)"/>
                                                         </xsl:for-each-->
      <!--xsl:message select="concat('CC: ',$rdf-types-as-string,' ',$class-fill)"/-->
      <!--xsl:message select="concat('HERE: ',pmm:tryQName($resource))"/-->



      <!--
          Determine the visual properties based on descriptions gathered.
      -->

      <!-- identity -->

      <xsl:variable name="id">
         <xsl:choose>
            <xsl:when test="string-length($view-context) and string-length($resource)">
               <xsl:variable name="value" select="concat($view-context,' ',$resource)"/>
               <!--xsl:message select="acv:explainResource($resource,$owl:sameAs,
                                                        'vnode id',string($value),
                                                        concat($visual-artifact-uri,'/graphic/',vsr:view-id($value)),
                                                        'view-context given',$defin)"/--> <!-- 5th arg visual-form-uri changed from $value to $visualFormURI May 2015 -->
      <!-- Can't ask for the id or else it'll think it already drew it -->
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:variable name="value" select="$resource"/>
               <!--xsl:message select="acv:explainResource($resource,$owl:sameAs,
                                                        'vnode id',$resource,
                                                        concat($visual-artifact-uri,'/graphic/',vsr:view-id($value)),
                                                        'id otherwise',$defin)"/--> <!-- 5th arg visual-form-uri changed from $value to $visualFormURI May 2015 -->
      <!-- Can't ask for the id or else it'll think it already drew it -->
               <xsl:value-of select="$value"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <!-- note this value copied above to avoid chicken-and-egg -->
      <xsl:variable name="visualFormURI" select="concat($visual-artifact-uri,'/graphic/',vsr:view-id($id))"/>

      <!-- Sub-surfacing variables -->

      <xsl:variable name="should-depict"> <!-- a node -->
         <xsl:choose>
            <xsl:when test="$rdf-types = $blacklisted-subject-classes">
               <xsl:copy-of select="'false'"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,'should-depict','false','','instance of blacklisted class',$defin)"/>
            </xsl:when>
            <xsl:when test="idm:hasIdentified($visual-element-hash,$id)">
               <xsl:copy-of select="'false'"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,'should-depict','false','',concat('already created ',''),$defin)"/>
            </xsl:when>
            <!--xsl:when test="$already-created">
               <xsl:copy-of select="'false'"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,'should-depict','false','','already created',$defin)"/>
            </xsl:when-->
            <xsl:otherwise>
               <xsl:copy-of select="'true'"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,'should-depict','true','','not already-created)',$defin)"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <!-- Planar variables -->

      <xsl:variable name="x">
         <xsl:choose>
            <xsl:when test="$x">
               <xsl:variable name="value" select="$x"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,$vsr:x,string($value),$visualFormURI,'provided by deferrer.',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="$sink">
               <xsl:variable name="value" select="$separation[1]"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,$vsr:x,string($value),$visualFormURI,'$sink',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="$draw-literal-rdf">
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="y">
         <xsl:choose>
            <xsl:when test="$y">
               <xsl:variable name="value" select="$y"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,$vsr:y,string($value),$visualFormURI,'provided by deferrer.',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="$sink">
               <xsl:variable name="value" select="$separation[2] * (1 + position())"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,$vsr:y,string($value),$visualFormURI,'$sink',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:variable name="value" select="$separation[2] * (1 + position())"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,$vsr:y,string($value),$visualFormURI,'$sink',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <!--xsl:message select="concat('num in label preds: ',count($in-label-predicates))"/-->
      <!-- NOTE: This is listed out "elevation predominance" b/c it is needed by less-dominant elevation logic -->
      <xsl:variable name="in-label-predicates-label">
         <!--xsl:for-each select="$in-label-predicates">
            <xsl:variable name="label-pred" select="."/-->
            <!--xsl:for-each select="$s/*[xfm:uri(.) = $label-pred and string-length(text())]"-->
            <xsl:for-each select="$s/*[xfm:uri(.) = $in-label-predicates and (string-length(text()) or @rdf:resource)]">
               <xsl:variable name="predicate" select="xfm:uri(.)"/>
               <!--xsl:message select="concat($label-pred,'(',string-length(text()),') vs ',$predicate)"/-->
               <xsl:if test="string-length(text())">
                  <xsl:value-of select="concat(if (position()=1) then '' else $NL,pmm:bestLocalName($predicate),' : ',text())"/>
               </xsl:if>
               <xsl:if test="@rdf:resource">
                  <xsl:value-of select="concat(if (position()=1) then '' else $NL,pmm:bestLocalName($predicate),' : ',pmm:bestLabelFor(@rdf:resource))"/>
               </xsl:if>
            </xsl:for-each>
         <!--/xsl:for-each-->
      </xsl:variable>

      <!-- Elevation variables, to be ordered by visual dominance. -->

      <xsl:variable name="fill-color">
         <xsl:variable name="class-fill"     select="$class-strategy/visual-form[class[.=$rdf-types]]/@fill-color"/>
         <xsl:variable name="namespace-fill" select="$namespace-strategy/visual-form[namespace[starts-with($resource,.)]]/@fill-color"/>
         <xsl:choose>
            <xsl:when test="string-length($fill-color)">
               <xsl:variable name="value" select="$fill-color"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$vsr:fill,$value,$visualFormURI,$vsr:determined_by_deferrer,$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="$draw-literal-rdf">
               <xsl:variable name="value" select="'1 1 1'"/> <!-- white -->
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$vsr:fill,$value,$visualFormURI,'$draw-literal-rdf',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="$class-fill">
               <xsl:variable name="value" select="$class-fill[1]"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$vsr:fill,$value,$visualFormURI,'$class-fill',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="$namespace-fill">
               <xsl:variable name="value" select="$namespace-fill"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$vsr:fill,$value,$visualFormURI,'$namespace-strategy',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="string-length($in-label-predicates-label)">
               <xsl:variable name="value" select="'.95 .95 .95'"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$vsr:fill,$value,$visualFormURI,$vsr:determined_by_deferrer,$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:variable name="value" select="'1 1 1'"/> <!-- white -->
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$vsr:fill,$value,$visualFormURI,'fill color otherwise',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="shape">
         <xsl:variable name="class-shape" select="$class-strategy/visual-form[class[.=$rdf-types]]/@shape"/>
         <xsl:choose>
            <xsl:when test="string-length($shape)">
               <xsl:value-of select="$shape"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'shape',$shape,$visualFormURI,$vsr:determined_by_deferrer,$defin)"/>
            </xsl:when>
            <xsl:when test="$class-shape">
               <xsl:variable name="value" select="$class-shape[1]"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$vsr:shape,$value,$visualFormURI,'$class-shape',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="''"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'shape','',$visualFormURI,'shape otherwise',$defin)"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <xsl:variable name="rotation">
         <xsl:choose>
         <xsl:when test="$draw-literal-rdf"></xsl:when>
         <xsl:otherwise></xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <xsl:variable name="draw-stroke">
         <xsl:choose>
            <xsl:when test="string-length($draw-stroke)">
               <xsl:variable name="value" select="$draw-stroke"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'draw-stroke',$value,$visualFormURI,$vsr:determined_by_deferrer,$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="string-length($in-label-predicates-label)">
               <xsl:variable name="value" select="'YES'"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'draw-stroke',$value,$visualFormURI,$vsr:determined_by_deferrer,$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="$is-bnode and $rdf-types">
               <xsl:variable name="value" select="'YES'"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'draw-stroke',$value,$visualFormURI,'$is-bnode and $rdf-types',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="$draw-literal-rdf">NO</xsl:when>
            <xsl:otherwise>
               <xsl:variable name="value" select="'NO'"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'draw-stroke',$value,$visualFormURI,'draw stroke otherwise',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="stroke-color">
         <xsl:choose>
            <xsl:when test="string-length($stroke-color2)">
               <xsl:variable name="value" select="$stroke-color2"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$vsr:stroke,$value,$visualFormURI,$vsr:determined_by_deferrer,$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="string-length($in-label-predicates-label)">
               <xsl:variable name="value" select="'.7 .7 .7'"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$vsr:stroke,$value,$visualFormURI,$vsr:determined_by_deferrer,$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="$is-bnode and $rdf-types">
               <xsl:variable name="value" select="'.69 .69 .69'"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$vsr:stroke,$value,$visualFormURI,'$is-bnode and $rdf-types',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
         <xsl:when test="$draw-literal-rdf"></xsl:when>          <!-- white                 -->
         <xsl:otherwise>
             <!-- white -->
         </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <xsl:variable name="namespace-abbreviation-labels">
         <xsl:for-each select="$namespace-strategy/visual-form[@prefix]">
            <!-- Essentially a re-implementation of edu.rpi.tw.string.pmm.PrefixMappings -->
            <!--xsl:message  select="concat($resource,' ',@prefix)"/-->
            <xsl:if test="starts-with($resource,namespace)">
               <!--xsl:message  select="concat(@prefix,':',substring-after($resource,namespace))"/-->
               <abbreviation length="{string-length(substring-after($resource,namespace))}">
                  <xsl:value-of select="concat(@prefix,':',substring-after($resource,namespace))"/>
               </abbreviation>
            </xsl:if>
         </xsl:for-each>
      </xsl:variable>
      <!--xsl:message  select="concat('NUM PREFIXES: ',count($namespace-strategy/visual-form[@prefix]))"/>
      <xsl:message  select="concat('NUM PREFIXES: ',$namespace-abbreviation-labels/abbreviation[@length = min($namespace-abbreviation-labels/abbreviation/@length)][1],' of ',count($namespace-abbreviation-labels))"/-->

      <xsl:variable name="label">
         <xsl:choose>
            <!--xsl:when test="true()">
               <xsl:value-of select="$resource"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$resource,$visualFormURI,'debug',$defin)"/>
            </xsl:when-->
            <xsl:when test="$namespace-abbreviation-labels/abbreviation[@length = min($namespace-abbreviation-labels/abbreviation/@length)][1]">
               <xsl:value-of select="$namespace-abbreviation-labels/abbreviation[@length = min($namespace-abbreviation-labels/abbreviation/@length)][1]"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,pmm:tryQName($resource),$visualFormURI,'vsr prefix mapping',$defin)"/>
            </xsl:when>
            <xsl:when test="$sink">
               <xsl:variable name="value" select="pmm:tryQName($resource)"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$value,$visualFormURI,'sink',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="count($label) gt 1">
               <xsl:value-of select="$label[1]"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$label[1],$visualFormURI,$vsr:determined_by_deferrer,$defin)"/>
            </xsl:when>
            <xsl:when test="string-length($label)">
               <xsl:value-of select="$label"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$label,$visualFormURI,$vsr:determined_by_deferrer,$defin)"/>
            </xsl:when>
            <xsl:when test="$anonymous-instance-classes = $rdf-types">
               <xsl:variable name="value" select="concat('a ',pmm:tryQName($rdf-types[1]),
                                                         if (string-length($in-label-predicates-label)) then concat($NL,'with',$NL) else '',$in-label-predicates-label)"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$value,$visualFormURI,'instance should be anonymous.',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="string-length($in-label-predicates-label)">
               <xsl:variable name="value" select="$in-label-predicates-label"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$value,$visualFormURI,'has in-label predicates',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="$priority-label-descriptions/*">
               <xsl:variable name="value" select="$priority-label-descriptions/*[1]/text()"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$value,$visualFormURI,'$priority-label-descriptions',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="$rdf-types[.=$rdf:Statement]">
               <xsl:variable name="value" select="concat('a',$NL,pmm:tryQName($s/rdf:predicate/@rdf:resource),$NL,'rdf:Statement')"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$value,$visualFormURI,'rdf:Statement = $rdf-types',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="$is-bnode and $rdf-types">
               <xsl:variable name="value" select="concat('a ',pmm:tryQName($rdf-types[1]))"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$value,$visualFormURI,'$is-bnode and $rdf-types',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="$is-bnode and $show-bnode-IDs">
               <xsl:value-of select="$resource"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$resource,$visualFormURI,'$is-bnode and $show-bnode-IDs',$defin)"/>
            </xsl:when>
            <xsl:when test="$is-bnode">
               <xsl:value-of select="'[  ]'"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,'[  ]',$visualFormURI,'$is-bnode',$defin)"/>
            </xsl:when>
            <xsl:when test="$is-resource">
               <xsl:value-of select="pmm:tryQName($resource)"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,pmm:tryQName($resource),$visualFormURI,'$is-resource',$defin)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="$resource"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$resource,$visualFormURI,'label otherwise',$defin)"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="fit-text">
         <xsl:choose>
            <xsl:when test="$fit-text">
               <xsl:value-of select="$fit-text"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'fit-text',$fit-text,$visualFormURI,$vsr:determined_by_deferrer,$defin)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="''"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'fit-text','',$visualFormURI,'fit text otherwise',$defin)"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="h-text-pad">
         <xsl:choose>
            <xsl:when test="$is-bnode">
               <xsl:variable name="value" select="'5'"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,'h-text-pad',$value,$visualFormURI,'$is-bnode',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:variable name="value" select="'5'"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,'h-text-pad',$value,$visualFormURI,'h text pad otherwise',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="h-align-text"> <!-- 0, '', 2, or 3 (left, center, right, justify) -->
         <xsl:choose>
            <xsl:when test="string-length($in-label-predicates-label)">
               <xsl:variable name="value" select="'0'"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'h-align-text',string($value),$visualFormURI,'$in-label-predicates-label',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="$draw-literal-rdf">
               <xsl:variable name="value" select="'0'"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'h-align-text',string($value),$visualFormURI,'$draw-literal-rdf',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:variable name="value" select="''"/>
               <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'h-align-text',string($value),$visualFormURI,'h align text otherwise',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="v-align-text">
         <xsl:choose>
         <xsl:when test="$draw-literal-rdf"></xsl:when>
         <xsl:otherwise></xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <xsl:variable name="notes">
         <xsl:choose> <!-- TODO: handle more than one comment triple. -->
            <xsl:when test="$s/*[xfm:uri(.)=$notes-predicates]">
               <xsl:variable name="value">
                  <xsl:for-each select="$s/*[xfm:uri(.)=$notes-predicates]">
                     <xsl:value-of select="vsr:getObject(.)"/>
                     <xsl:if test="true or position != last()"><xsl:value-of select="$NL"/></xsl:if>
                  </xsl:for-each>
               </xsl:variable>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,'notes',$value,$visualFormURI,'$notes-predicates',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="count($rdfs-comments) gt 1">
               <xsl:variable name="value" select="'TODO:func($rdfs-comments)'"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,'notes',$value,$visualFormURI,'more than one comment',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:variable name="value" select="''"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,'notes',$value,$visualFormURI,'notes otherwise',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <xsl:variable name="tooltip">
         <xsl:choose>
            <xsl:when test="$s/*[xfm:uri(.)=$tooltip-predicates]">
               <xsl:variable name="value">
                  <xsl:for-each select="$s/*[xfm:uri(.)=$tooltip-predicates]">
                     <xsl:choose>
                        <xsl:when test="key('descriptions-by-subject',vsr:getObject(.))/prov:value">
                           <xsl:value-of select="concat(pmm:bestLabelFor(xfm:uri(.)),' : ',key('descriptions-by-subject',vsr:getObject(.))/prov:value[text() and position() = 1])"/>
                           <xsl:if test="true or position != last()"><xsl:value-of select="$NL"/></xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of select="concat(pmm:bestLabelFor(xfm:uri(.)),' : ',vsr:getObject(.))"/>
                           <xsl:if test="true or position != last()"><xsl:value-of select="$NL"/></xsl:if>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:for-each>
               </xsl:variable>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,$vsr:tooltip,$value,$visualFormURI,'$tooltip-predicates',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:variable name="value" select="''"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,$vsr:tooltip,$value,$visualFormURI,'tooltip otherwise',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <xsl:variable name="url">
         <xsl:choose>
            <xsl:when test="$is-resource">
               <xsl:value-of select="$resource"/>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <xsl:variable name="a-root">
         <xsl:choose>
            <xsl:when test="$a-root">
               <xsl:variable name="value" select="$a-root"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,'a-root',string($value),$visualFormURI,$vsr:determined_by_deferrer,$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:when test="$rdf-types = $rooted-classes">
               <xsl:variable name="value" select="true()"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,'a-root',string($value),$visualFormURI,'depicting-a-rooted-class',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:variable name="value" select="false()"/>
               <xsl:message select="acv:explainResource($resource,$owl:sameAs,'a-root',string($value),$visualFormURI,'a root otherwise',$defin)"/>
               <xsl:value-of select="$value"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <!--xsl:message select="concat('rdf2.xsl before creating: hasIdentified: ',idm:hasIdentified($visual-element-hash,$resource),' should emit; ',$should-depict)"/-->
      <xsl:if test="$should-depict = 'true'"> <!-- unclean, but doesn't work with true() and false() above...  >:-{   -->
         <!--xsl:message select="concat('rdf2.xsl CREATING. hasIdentified: ',idm:hasIdentified($visual-element-hash,$resource),' should emit; ',$should-depict)"/-->
         <!--xsl:message select="concat($defin,$in,'calling node for vnode id ::',$id,'::')"/-->
         <xsl:call-template name="node">
            <xsl:with-param name="visual-artifact-uri" select="$visual-artifact-uri"/>
            <xsl:with-param name="context"             select="''"/>
            <xsl:with-param name="depicts"             select="$resource"/>
            <xsl:with-param name="id"                  select="$id"/>

            <xsl:with-param name="x"                   select="$x"/>
            <xsl:with-param name="y"                   select="$y"/>
            <xsl:with-param name="fill-color"          select="$fill-color"/>
            <xsl:with-param name="shape"               select="$shape"/>
            <xsl:with-param name="height"              select="$height"/>
            <xsl:with-param name="width"               select="$width"/>
            <xsl:with-param name="rotation"            select="$rotation"/>
            <xsl:with-param name="draw-stroke"         select="$draw-stroke"/>
            <xsl:with-param name="stroke-color"        select="$stroke-color"/>

            <xsl:with-param name="label"               select="$label"/>
            <xsl:with-param name="fit-text"            select="$fit-text"/>
            <xsl:with-param name="h-text-pad"          select="$h-text-pad"/>
            <xsl:with-param name="h-align-text"        select="$h-align-text"/>
            <xsl:with-param name="v-align-text"        select="$v-align-text"/>

            <xsl:with-param name="url"                 select="$url"/>
            <xsl:with-param name="isDefinedBy"         select="$rdfs-isDefinedBy"/>
            <xsl:with-param name="rdfTypes"            select="$rdf-types-as-string"/>
            <xsl:with-param name="notes"               select="$notes"/>
            <xsl:with-param name="tooltip"             select="$tooltip"/>
            <xsl:with-param name="a-root"              select="$a-root"/>

            <xsl:with-param name="ignore"              select="idm:getIdentifier($visual-element-hash,$id)"/>
         </xsl:call-template>
         <!--xsl:message select="concat('rdf2.xsl JUST CREATED. hasIdentified: ',idm:hasIdentified($visual-element-hash,$resource))"/-->
      </xsl:if>

      <!--/xsl:otherwise>
   </xsl:choose-->
</xsl:template>


<xsl:include href="rdf2.xsl"/>

</xsl:transform>
