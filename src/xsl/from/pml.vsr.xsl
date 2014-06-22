<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:wgs="http://www.w3.org/2003/01/geo/wgs84_pos#"
   xmlns:time="http://www.w3.org/2006/time#"
   xmlns:skos="http://www.w3.org/2004/02/skos/core#"
   xmlns:ov="http://open.vocab.org/terms/"
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rl="http://purl.org/twc/vocab/vsr/"
   xmlns:p="http://purl.org/twc/vocab/vsr/"

   xmlns:pmlds="http://inference-web.org/2.0/ds.owl#"
   xmlns:pmlp="http://inference-web.org/2.0/pml-provenance.owl#"
   xmlns:pmlj="http://inference-web.org/2.0/pml-justification.owl#"

   xmlns:jvr="jvr"
   xmlns:nmf="java:edu.rpi.tw.string.NameFactory"
   xmlns:idm="java:edu.rpi.tw.string.IDManager"
   xmlns:log="java:edu.rpi.tw.visualization.log.VisualizationDecisions"

   xmlns:acv="accountable visualization"
   xmlns:pmap="edu.rpi.tw.string.pmm.DefaultPrefixMappings"
   xmlns:pmm="edu.rpi.tw.string.pmm"
   xmlns:xutil="https://github.com/timrdf/vsr/tree/master/src/xsl/util"
   xmlns:xsdabv="https://github.com/timrdf/vsr/tree/master/src/xsl/util/xsd-datatype-abbreviations.xsl"
   xmlns:vst="http://purl.org/twc/vocab/vsr#"
   xmlns:xfm="transform namespace">

<xd:doc type="stylesheet">
   <xd:short>Visual strategy for Proof Markup Language 2.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<xsl:include href="../ns/pml-ns.xsl"/>

<xsl:variable name="pml-blacklisted-predicates" select="(
   $pml-in-label-predicates,
   $rdfabbr-blacklisted-predicates,
   $pmlj:fromAnswer,
   $pmlj:hasIndex,
   $pmlj:fromQuery,
   $pmlp:affiliation
)"/>

<xsl:variable name="pml-blacklisted-objects" select="(
   $rdfabbr-blacklisted-objects,
   $pmlj:NodeSetList,
   $pmlj:Mapping,
   $pmlj:NodeSet,
   $pmlp:Information,
   $pmlj:InferenceStep
)"/>

<xsl:variable name="pml-swap-directionality-predicates" select="(
   $rdfabbr-swap-directionality-predicates,
   $pmlj:hasConclusion,
   $pmlp:hasRawString,
   $pmlj:fromQuery,
   $pmlj:isQueryFor,
   $pmlp:hasLanguage,
   $pmlj:hasInferenceRule,
   $pmlj:hasInferenceEngine,
   $pmlj:mapFrom, $pmlj:mapTo,
   $pmlp:hasCreationDateTime,
   $pmlp:hasContent, 
   $pmlp:hasName
)"/>

<xsl:variable name="pml-label-predicates" select="(
   $pmlp:hasName
)"/>

<xsl:variable name="pml-in-label-predicates" select="(
   $pml-label-predicates,
   $pmlp:hasFromRow,
   $pmlp:hasFromCol,
   $pmlp:hasToRow,
   $pmlp:hasToCol,
   $pmlp:hasLanguage,
   $pmlj:hasInferenceRule,
   $pmlj:hasInferenceEngine
)"/>

<xsl:variable name="pml-notes-predicates" select="(
   $pml-in-label-predicates
)"/>

<xsl:variable name="pml-class-strategy">
   <visual-form fill-color=".9647 .8353 .8314">       <!-- Pink -->
      <class><xsl:value-of select="$pmlj:Question"/></class>
   </visual-form> 
   <visual-form fill-color=".5020 .2510 .0000 .2500"> <!-- Brown -->
      <class><xsl:value-of select="$pmlj:Query"/></class>
   </visual-form> 
   <visual-form fill-color=".8392 .9882 .8000">       <!-- Green -->
      <class><xsl:value-of select="$pmlp:Information"/></class>
   </visual-form> 
   <visual-form fill-color=".9882 .9451 .8553">       <!-- Peach/Orange -->
      <class><xsl:value-of select="$pmlp:AgentList"/></class>
   </visual-form> 
   <visual-form fill-color="1 1 .847">                <!-- Yellow -->
      <class><xsl:value-of select="$pmlj:NodeSet"/></class>
   </visual-form> 
   <visual-form fill-color=".8 .8 .8">                <!-- Light Gray -->
      <class><xsl:value-of select="$pmlj:InferenceStep"/></class>
   </visual-form> 
   <visual-form fill-color=".5 .5 .5">                <!-- Gray -->
      <class><xsl:value-of select="$pmlj:InferenceEngine"/></class>
   </visual-form> 
   <visual-form fill-color=".8196 .8196 1.000">       <!-- Blue -->
      <class><xsl:value-of select="$pmlp:SourceUsage"/></class>
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

<xsl:variable name="pml-namespace-strategy">
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

<xsl:template match="rdf:Description[@rdf:about | @rdf:nodeID]" mode="visual-element">
   <xsl:variable name="owl:sameAs" select="concat($rl,'pml_subject_visual_form_factory')"/>
   <!-- Orient with domain form -->
   <xsl:variable name="subject"          select="@rdf:about | @rdf:nodeID"/><!--current-grouping-key()"/-->
   <xsl:message select="acv:arriveResource($owl:sameAs,$subject)"/>

   <xsl:variable name="p"                select="key('descriptions-by-subject',$subject)"/>
   <xsl:variable name="rdf-types"        select="$p/rdf:type/@rdf:resource"/>
   <xsl:variable name="label">
      <xsl:choose>
         <xsl:when test="$p/(pmlp:hasFromRow | pmlp:hasFromCol | pmlp:hasToRow | pmlp:hasToCol)">
            <xsl:variable name="value" select="concat('[',$p/pmlp:hasFromRow,',',$p/pmlp:hasFromCol,' ',$NL,
                                                      '     ',$p/pmlp:hasToRow,',',$p/pmlp:hasToCol,']')"/>
            <xsl:message select="acv:explainResource($subject,$owl:sameAs,'label',$value,
                                                     'visFormURI','info')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$pmlp:Information = $rdf-types">
            <xsl:variable name="value" select="concat(pmm:bestLabel(string($p/pmlp:hasLanguage/@rdf:resource)),' information')"/>
            <xsl:message select="acv:explainResource($subject,$owl:sameAs,'label',$value,
                                                     'visFormURI','info')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$pmlj:InferenceStep = $rdf-types and count($p/pmlj:hasInferenceEngine[1]) le 1">
            <xsl:message select="concat('count ',count($p/pmlj:hasInferenceEngine[1]),' ',count($p/pmlj:hasInferenceEngine[position()=1]))"/>
            <xsl:variable name="value" select="concat('Inference step from ',pmm:bestLabel(string($p/pmlj:hasInferenceEngine/@rdf:resource)),
                                                      ' using ',pmm:bestLabel(string($p/pmlj:hasInferenceRule/@rdf:resource)))"/> 
               <!--   XPTY0004: A sequence of more than one item is not allowed as the first argument of string() TODO: added [1] as a quick hack. -->
            <xsl:message select="acv:explainResource($subject,$owl:sameAs,'label',$value,
                                                     'visFormURI','info')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$pmlj:InferenceStep = $rdf-types">
            <xsl:value-of select="'ERROR making label for Node pml.vsr.xsl'"/>
         </xsl:when>
         <xsl:otherwise>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:apply-templates select="." mode="default">
      <xsl:with-param name="label-predicates"   select="$pml-label-predicates"/>
      <xsl:with-param name="notes-predicates"   select="$pml-notes-predicates"/>
      <xsl:with-param name="class-strategy"     select="$pml-class-strategy"/>
      <xsl:with-param name="namespace-strategy" select="$pml-namespace-strategy"/>
      <xsl:with-param name="label" tunnel="yes" select="$label"/>
   </xsl:apply-templates>
</xsl:template>

<xsl:template match="pmlp:hasInferenceEngine">
   <xsl:variable name="owl:sameAs" select="'pml_hasInferenceEngine_filter'"/>

   <xsl:variable name="subject"  select="../@rdf:about | ../@rdf:nodeID"/>
   <xsl:variable name="is-bnode" select="../@rdf:nodeID"/>

   <xsl:choose>
      <xsl:when test="$is-bnode">
         <xsl:message select="'TODO: handle bnode'"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:apply-templates select="." mode="blacklist_checker">
            <xsl:with-param name="blacklisted-subject-namespaces" select="()"/>
            <xsl:with-param name="blacklisted-predicates"         select="($pml-blacklisted-predicates, $pml-in-label-predicates)"/>
            <xsl:with-param name="blacklisted-objects"            select="$pml-blacklisted-objects"/>
            <xsl:with-param name="blacklisted-object-namespaces"  select="()"/>
            <xsl:with-param name="swap-directionality-predicates" select="$pml-swap-directionality-predicates"/>
            <xsl:with-param name="notes-predicates"               select="$pml-notes-predicates"/>
            <xsl:with-param name="class-strategy"                 select="$pml-class-strategy"/>
         </xsl:apply-templates>
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xsl:template match="rdf:Description/*" priority="-.25">
   <!--post-imports over include priority="-.25"-->
   <xsl:variable name="owl:sameAs" select="'pml_Cleanup_crew'"/>
   <xsl:variable name="rdf:type"   select="$vsr:CleanupCrew"/>

   <xsl:variable name="subject"   select="../@rdf:about | ../@rdf:nodeID"/>
   <xsl:variable name="predicate" select="xfm:uri(.)"/>
   <xsl:variable name="object"    select="vst:getObject(.)"/>
   <xsl:message                   select="acv:arriveTriple($owl:sameAs,$subject,$predicate,$object)"/>

   <!--xsl:call-template name="blacklist_checker"-->
   <xsl:apply-templates select="." mode="blacklist_checker">
      <xsl:with-param name="blacklisted-subject-namespaces" select="()"/>
      <xsl:with-param name="blacklisted-predicates"         select="($pml-blacklisted-predicates, $pml-in-label-predicates)"/>
      <xsl:with-param name="blacklisted-objects"            select="$pml-blacklisted-objects"/>
      <xsl:with-param name="blacklisted-object-namespaces"  select="()"/>
      <xsl:with-param name="swap-directionality-predicates" select="$pml-swap-directionality-predicates"/>
      <xsl:with-param name="notes-predicates"               select="$pml-notes-predicates"/>
      <xsl:with-param name="class-strategy"                 select="$pml-class-strategy"/>
   </xsl:apply-templates>
</xsl:template>

<xsl:include  href="rdf-abbrev.xsl"/>

</xsl:transform> 
