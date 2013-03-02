<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:pmlj="http://inference-web.org/2.0/pml-justification.owl#">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="pmlj"                select="'http://inference-web.org/2.0/pml-justification.owl#'"/>

<!-- Terms within the namespace -->
<xsl:variable name="pmlj:java"    select="concat($pmlj,'java')"/>
<xsl:variable name="pmlj:AbstractionRule"    select="concat($pmlj,'AbstractionRule')"/>
<xsl:variable name="pmlj:InferenceStep"    select="concat($pmlj,'InferenceStep')"/>
<xsl:variable name="pmlj:JustificationElement"    select="concat($pmlj,'JustificationElement')"/>
<xsl:variable name="pmlj:Mapping"    select="concat($pmlj,'Mapping')"/>
<xsl:variable name="pmlj:NodeSet"    select="concat($pmlj,'NodeSet')"/>
<xsl:variable name="pmlj:NodeSetList"    select="concat($pmlj,'NodeSetList')"/>
<xsl:variable name="pmlj:Query"    select="concat($pmlj,'Query')"/>
<xsl:variable name="pmlj:Question"    select="concat($pmlj,'Question')"/>
<xsl:variable name="pmlj:fromAnswer"    select="concat($pmlj,'fromAnswer')"/>
<xsl:variable name="pmlj:fromAnswerOrQuery"    select="concat($pmlj,'fromAnswerOrQuery')"/>
<xsl:variable name="pmlj:fromQuery"    select="concat($pmlj,'fromQuery')"/>
<xsl:variable name="pmlj:hasAnswer"    select="concat($pmlj,'hasAnswer')"/>
<xsl:variable name="pmlj:hasAnswerPattern"    select="concat($pmlj,'hasAnswerPattern')"/>
<xsl:variable name="pmlj:hasAntecedentList"    select="concat($pmlj,'hasAntecedentList')"/>
<xsl:variable name="pmlj:hasConclusion"    select="concat($pmlj,'hasConclusion')"/>
<xsl:variable name="pmlj:hasDischarge"    select="concat($pmlj,'hasDischarge')"/>
<xsl:variable name="pmlj:hasIndex"    select="concat($pmlj,'hasIndex')"/>
<xsl:variable name="pmlj:hasInferenceEngine"    select="concat($pmlj,'hasInferenceEngine')"/>
<xsl:variable name="pmlj:hasInferenceRule"    select="concat($pmlj,'hasInferenceRule')"/>
<xsl:variable name="pmlj:hasMetaBinding"    select="concat($pmlj,'hasMetaBinding')"/>
<xsl:variable name="pmlj:hasPatternNodeSet"    select="concat($pmlj,'hasPatternNodeSet')"/>
<xsl:variable name="pmlj:hasSourceUsage"    select="concat($pmlj,'hasSourceUsage')"/>
<xsl:variable name="pmlj:hasVariableMapping"    select="concat($pmlj,'hasVariableMapping')"/>
<xsl:variable name="pmlj:isConsequentOf"    select="concat($pmlj,'isConsequentOf')"/>
<xsl:variable name="pmlj:isExplanationOf"    select="concat($pmlj,'isExplanationOf')"/>
<xsl:variable name="pmlj:isFromEngine"    select="concat($pmlj,'isFromEngine')"/>
<xsl:variable name="pmlj:isQueryFor"    select="concat($pmlj,'isQueryFor')"/>
<xsl:variable name="pmlj:mapFrom"    select="concat($pmlj,'mapFrom')"/>
<xsl:variable name="pmlj:mapTo"    select="concat($pmlj,'mapTo')"/>

<xsl:variable name="pmlj:ALL" select="(
   $pmlj:isConsequentOf,
   $pmlj:hasSourceUsage,
   $pmlj:JustificationElement,
   $pmlj:NodeSetList,
   $pmlj:hasIndex,
   $pmlj:hasConclusion,
   $pmlj:Mapping,
   $pmlj:mapTo,
   $pmlj:hasInferenceEngine,
   $pmlj:hasAntecedentList,
   $pmlj:hasPatternNodeSet,
   $pmlj:Query,
   $pmlj:Question,
   $pmlj:java,
   $pmlj:hasDischarge,
   $pmlj:fromAnswer,
   $pmlj:hasInferenceRule,
   $pmlj:isExplanationOf,
   $pmlj:hasAnswer,
   $pmlj:InferenceStep,
   $pmlj:hasMetaBinding,
   $pmlj:fromQuery,
   $pmlj:isQueryFor,
   $pmlj:fromAnswerOrQuery,
   $pmlj:hasAnswerPattern,
   $pmlj:mapFrom,
   $pmlj:isFromEngine,
   $pmlj:hasVariableMapping,
   $pmlj:NodeSet,
   $pmlj:AbstractionRule
)"/>

</xsl:transform>
