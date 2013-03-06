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

<xsl:import href="../ns/ov-ns.xsl"/>
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
         <xsl:apply-templates select="." mode="blacklist_checker"/> <!-- DEFER -->
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
   <xsl:param name="swap-directionality-predicates" select="$rdfabbr-swap-directionality-predicates" tunnel="yes"/>
   <!-- TODO: parameterize distinction between 'swap-visual-directionality-predicates' and 'swap-force-directionality-predicates'-->
   <xsl:param name="predicate-color-strategy"       select="()"                                      tunnel="yes"/>
   <xsl:param name="label"                                                                           tunnel="yes"/>
   <xsl:param name="namespaces-to-relax"            select="()"                                      tunnel="yes"/>
   <xsl:param name="relax-identical-literals"       select="true()"                                  tunnel="yes"/>
   <xsl:param name="relaxed-object-classes"         select="()"                                      tunnel="yes"/>
   <xsl:param name="subject-view-context"           select="''"                                      tunnel="yes"/>
   <xsl:param name="object-view-context"            select="''"                                      tunnel="yes"/>

   <!-- The URI for _this_ template, and its type. -->
   <xsl:variable name="owl:sameAs" select="concat($rdf-abbrev-plan,'#RDF-ABBREV_Default_statement_handler_572')"/>
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

   <xsl:variable name="q-object" select="$o/*[xfm:uri(.) = $qualified-object-predicates]/(@rdf:resource | */rdf:about)[1]"/>
   <xsl:variable name="q-o"      select="key('descriptions-by-subject',$q-object)"/>

   <xsl:variable name="true-object" select="if ($q-object) then $q-object else $object"/>

   <xsl:variable name="object-is-set-operation"       select="key('descriptions-by-subject',$object)/(owl:unionOf | owl:intersectionOf | owl:complementOf)"/>
   <xsl:variable name="set-operand"                   select="$object-is-set-operation/(@rdf:resource | @rdf:nodeID)"/>
   <xsl:variable name="set-operand-a-list"            select="key('descriptions-by-subject',$set-operand)/rdf:first"/>
   <xsl:variable name="object-is-qualification-and-should-be-swapped" select="$o/rdf:type[@rdf:resource = $qualification-classes and 
                                                                                          @rdf:resource = $swap-directionality-predicates]"/>
   <!--xsl:message select="concat('BLAH: ',$object,' ',$object-is-bnode,' ',count($object-is-set-operation),' ',$set-operand,' ',$set-operand-a-list)"/-->

   <!--xsl:message select="concat('size of q-object ',$q-object,' = ',count($q-o))"/-->

   <xsl:variable name="gedge-id" select="nmf:getUUIDName('gedge')"/> <!-- TODO: Just concat spo -->
   <!--xsl:variable name="gedge-id" select="concat($subject,' ',$predicate,' ',$object)"/-->
   <xsl:variable name="visualFormURI" select="concat($visual-artifact-uri,'/graphic/edge/',xfm:view-id($gedge-id))"/>

   <xsl:variable name="subject-vnode">
      <xsl:choose>
         <xsl:when test="string-length($subject-view-context)">
            <xsl:variable name="value" select="concat($subject-view-context,' ',$subject)"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','subject-vnode',$value,'subject-view-context given')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$subject"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','subject-vnode',$subject,'otherwise')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="object-view-context">
      <xsl:choose>
         <xsl:when test="string-length($object-view-context)">
            <xsl:variable name="value" select="$object-view-context"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri',$vsr:from_context,$value,'object-view-context given')"/>
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
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri',$vsr:from_context,'','otherwise')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <!--xsl:for-each-group select="$o/rdf:type/(@rdf:resource | */@rdf:about)" group-by=".">
      <xsl:message select="concat('o type:            ',.)"/>
   </xsl:for-each-group>
   <xsl:for-each-group select="$q-o/rdf:type/(@rdf:resource | */@rdf:about)" group-by=".">
      <xsl:message select="concat('q-o type:          ',.)"/>
   </xsl:for-each-group>
   <xsl:for-each-group select="$relaxed-object-classes" group-by=".">
      <xsl:message select="concat(count($relaxed-object-classes),' relaxed classes: ',.)"/>
   </xsl:for-each-group-->

   <xsl:variable name="unique-literal-vnode" select="concat($subject,'_',$predicate,'_',$object,'_',@rdf:datatype,@xml:lang,'_value')"/>
   <!-- Determine if new vnode should be created to depict object -->
   <xsl:variable name="object-vnode">
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
         <!--xsl:when test="matches($object,'^http://inference-web.org/registry/*')"> <!- TODO: ->
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
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-vnode',$unique-literal-vnode,'otherwise')"/>
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
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from,xfm:view-id($value),'$swap-directionality-predicates')"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from_domain,$value,'$swap-directionality-predicates')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$object-is-qualification-and-should-be-swapped">
            <xsl:variable name="value" select="$q-object"/>
            <xsl:variable name="justification" select="'qualification class is a $swap-directionality-predicates'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from,xfm:view-id($value),$justification)"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from_domain,$value,$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = $rdfs:subClassOf and $object-is-bnode">
            <!-- TODO: this should be pushed up to owl and it should call down with 'swap-directionality-predicates' -->
            <xsl:variable name="value" select="$subject-vnode"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from,xfm:view-id($value),'subclassof of object is bnode')"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from_domain,$value,'subclassof of object is bnode')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="$subject-vnode"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from,xfm:view-id($value),'otherwise')"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from_domain,$value,'otherwise')"/>
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
            <xsl:variable name="justification" select="'otherwise'"/>
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
            <xsl:variable name="justification" select="'otherwise'"/>
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
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'line-style','2','otherwise')"/>
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
         <xsl:otherwise>
            <xsl:value-of select="''"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'line-width','','otherwise')"/>
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
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'draw-shadow','NO','otherwise')"/>
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
                     <xsl:value-of select="replace(pmm:bestLabelFor(vsr:getObject(.)),'^.*\.','')"/>
                  </xsl:if>
               </xsl:for-each-group>
            </xsl:variable>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$rdfs:label,$value,'$label param')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$draw-literal-rdf">
            <xsl:variable name="value" select="pmm:bestQName($predicate)"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$rdfs:label,$value,'$label param')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = $owl:onProperty">
            <xsl:variable name="value" select="''"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$rdfs:label,$value,'$label param')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$subject-has-same-domain-and-range">
            <xsl:variable name="value" select="'rdfs:domain and rdfs:range'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$rdfs:label,$value,'$label param')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$subject-has-same-range-and-domain">
            <xsl:variable name="value" select="'rdfs:range and rdfs:domain'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$rdfs:label,$value,'$label param')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="pmm:tryQName($predicate)"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$rdfs:label,$value,'$label param')"/>
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
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,'edge-notes',pmm:tryQName($predicate),'otherwise')"/>
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
            <xsl:variable name="justification" select="'otherwise'"/>
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
            <xsl:variable name="justification" select="'otherwise'"/>
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
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from,$value,xfm:view-id($from),xfm:view-id($value),'$draw-literal-rdf')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = $rdfs:subClassOf and $object-is-bnode">
            <xsl:variable name="value" select="$object-vnode"/>
            <xsl:variable name="justification" select="'$predicate = $rdfs:subClassOf and $object-is-bnode'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from,$value,xfm:view-id($from),xfm:view-id($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = $swap-directionality-predicates">
            <xsl:variable name="value" select="$subject-vnode"/>
            <xsl:variable name="justification" select="'$predicate = $swap-directionality-predicates'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from,$value,xfm:view-id($from),xfm:view-id($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$object-is-qualification-and-should-be-swapped">
            <xsl:variable name="value" select="$subject-vnode"/>
            <xsl:variable name="justification" select="'qualification class is a $swap-directionality-predicates'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from,$value,xfm:view-id($from),xfm:view-id($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="$object-vnode"/>
            <xsl:variable name="justification" select="'otherwise'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$visualFormURI,$vsr:from,$value,xfm:view-id($from),xfm:view-id($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <!-- Visual properties of the object-vnode -->

   <!--xsl:variable name="object-label">
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
   </xsl:variable-->
   <!--xsl:variable name="object-font-color">
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:variable name="value" select="'0 0 0'"/>
            <xsl:variable name="justification" select="'draw-literal-rdf'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-font-color',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <- TODO: make dc literals 0 0 166 ->
         <xsl:when test="$predicate = $rdfs:label">
            <xsl:variable name="value" select="'1 0 .501961'"/> <-        pink label ->
            <xsl:variable name="justification" select="'$predicate = $rdfs:label'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-font-color',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$predicate = $rdfs:comment">
            <xsl:variable name="value" select="'0 0 1'"/> <-        blue label ->
            <xsl:variable name="justification" select="'$predicate = $rdfs:comment'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-font-color',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$object-is-literal">
            <xsl:variable name="value" select="'0 0 .65'"/> <- darker blue label ->
            <xsl:variable name="justification" select="'object is literal'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-font-color',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="'0 0 0'"/> <-       black label ->
            <xsl:variable name="justification" select="'object is literal'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','object-font-color',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable-->
   <!--xsl:variable name="object-width">
      <xsl:choose>
         <xsl:when test="string-length($object-label) gt 45">360</xsl:when> <- Avoid wide comments ->
         <xsl:otherwise></xsl:otherwise>                                    <- wrap to shape - could be wide ->
      </xsl:choose>
   </xsl:variable-->
   <!--xsl:variable name="wrap-text">
      <xsl:choose>
         <xsl:when test="string-length($object-label) gt 45">true</xsl:when> <- Avoid wide comments ->
         <xsl:otherwise>false</xsl:otherwise>                                <- wrap to shape - could be wide ->
      </xsl:choose>
   </xsl:variable-->
   <!--xsl:variable name="h-text-pad">
      <xsl:choose>
         <xsl:when test="$subject-is-bnode">
            <xsl:value-of select="'5'"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','h-text-pad','5','$subject-is-bnode')"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="'5'"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','h-text-pad','5','otherwise')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable-->
   <!-- xsl:variable name="draw-fill">
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:value-of select="'YES'"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','draw-fill','YES','draw-literal-rdf')"/>
         </xsl:when>
         <xsl:when test="$predicate = ($rdfs:label, $rdfs:comment)">
            <xsl:value-of select="'NO'"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','draw-fill','NO','$predicate = ($rdfs:label, $rdfs:comment)')"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="'YES'"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','draw-fill','YES','otherwise')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable-->

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

   <xsl:variable name="should-depict">
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
            <xsl:variable name="justification" select="'otherwise'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'vis-art-uri','should-depict',string($value),$justification)"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <!--xsl:message select="acv:explainTriple($subject,$predicate,concat($object,$at-or-carat,@rdf:datatype,@xml:lang),$owl:sameAs,'vis-art-uri',$action,'',$justification)"/-->

   <xsl:if test="$should-depict = 'true'">
      <!-- Make the edge from the resource to the object-vnode -->
      <xsl:message select="'          ( = Drawing edge = = = = = = = )'"/>
      <xsl:call-template name="edge">
         <xsl:with-param name="id"           select="$gedge-id"/>

         <xsl:with-param name="from"         select="$from"/> <!-- Encodes *force* directionality; not necessarily _visual_ directionality. -->
         <xsl:with-param name="to"           select="$to"/>   <!-- Encodes *force* directionality; not necessarily _visual_ directionality. -->

         <xsl:with-param name="depicts"      select="$predicate"/>

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

      <xsl:if test="not(idm:hasIdentified($visual-element-hash,$subject-vnode))">
         <xsl:message select="concat('          ( = = Drawing subject ',$subject,' )')"/>
         <!-- A bit of a hack to provide a context node for the template's key -->
         <!--xsl:for-each-group select="key('descriptions-by-subject',$subject)
                                      /(@rdf:about | @rdf:resource | @rdf:nodeID | @rdf:ID)" group-by="."-->
         <xsl:apply-templates select="$subject" mode="default">
            <xsl:with-param name="deferrer"     select="$owl:sameAs"/>
            <xsl:with-param name="view-context" select="$subject-view-context"/>
         </xsl:apply-templates>
         <!--/xsl:for-each-group-->
      </xsl:if>

      <!--xsl:if test="$object-is-literal and not(idm:hasIdentified($visual-element-hash,$object-vnode))"-->
      <xsl:if test="not(idm:hasIdentified($visual-element-hash,$object-vnode))">
         <xsl:choose>
            <xsl:when test="$object-is-resource">
               <xsl:message select="concat('          ( = = Drawing object ',$true-object,' ) ',count(key('descriptions-by-subject',$true-object)),' references')"/>
               <!-- A bit of a hack to provide a context node for the template's key -->
               <xsl:for-each-group select="if (count(key('descriptions-by-subject',if ($q-object) then $q-object else $object)
                                                       /(@rdf:about | @rdf:resource | @rdf:nodeID | @rdf:ID)))
                                              then  key('descriptions-by-subject',if ($q-object) then $q-object else $object)
                                                       /(@rdf:about | @rdf:resource | @rdf:nodeID | @rdf:ID)
                                              else //*[@rdf:resource = $object]/@rdf:resource" group-by="."> <!-- second condition for 'sinks' -->
                  <xsl:apply-templates select="current-group()[1]" mode="default">
                     <xsl:with-param name="deferrer"     select="$owl:sameAs"/>
                     <xsl:with-param name="view-context" select="$object-view-context"/>
                  </xsl:apply-templates>
               </xsl:for-each-group>
            </xsl:when>
            <xsl:otherwise>
               <!--xsl:message select="'          ( = = Drawing object with old, bad way = = = = = = = = = = = = = = = = = = = = = )'"/>
               <- Mint the object-vnode for the literal ->
               <- This should be done by calling the original visual-element template, 
                    given a new context (as is done above). ->
               <xsl:call-template name="node">  
                  <xsl:with-param name="id"                  select="$object-vnode"/> <- id = (depicts, context, visual-artifact-uri, *)         ->
                                                                                      <-       ^        ^        ^                    ^          ->
                                                                                      <-       data     ""       vis,                 a bit more ->
                  <xsl:with-param name="depicts"             select="$object"/>
                  <xsl:with-param name="context"             select="$visual-artifact-uri"/>
                  <xsl:with-param name="visual-artifact-uri" select="$visual-artifact-uri"/>

                  <xsl:with-param name="label"               select="concat(' ',$object-label)"/>
                  <xsl:with-param name="x"                   select="5 * $separation[1]"/>
                  <xsl:with-param name="y"                   select="5 * $separation[2]"/>
                  <xsl:with-param name="font-color"          select="$object-font-color"/>
                  <xsl:with-param name="width"               select="$object-width"/>
                  <xsl:with-param name="h-text-pad"          select="$h-text-pad"/>
                  <xsl:with-param name="draw-fill"           select="$draw-fill"/>
                  <xsl:with-param name="wrap-text"           select="$wrap-text"/>
                  <xsl:with-param name="ignore"              select="idm:getIdentifier($visual-element-hash, $object-vnode)"/>
               </xsl:call-template-->
            </xsl:otherwise>
         </xsl:choose>
      </xsl:if>
      <xsl:if test="$literal-has-datatype or $literal-has-lang">
         <!-- TODO: make the node for the datatype, link from the triple's object to the datatype node -->
      </xsl:if>
   </xsl:if>
</xsl:template>

<xsl:include href="rdf2.xsl"/>

</xsl:transform>
