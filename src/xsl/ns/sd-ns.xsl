<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:sd="http://www.w3.org/ns/sparql-service-description#">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="sd"                select="'http://www.w3.org/ns/sparql-service-description#'"/>

<!-- Terms within the namespace -->
<xsl:variable name="sd:Aggregate"    select="concat($sd,'Aggregate')"/>
<xsl:variable name="sd:Dataset"    select="concat($sd,'Dataset')"/>
<xsl:variable name="sd:EntailmentProfile"    select="concat($sd,'EntailmentProfile')"/>
<xsl:variable name="sd:EntailmentRegime"    select="concat($sd,'EntailmentRegime')"/>
<xsl:variable name="sd:Feature"    select="concat($sd,'Feature')"/>
<xsl:variable name="sd:Function"    select="concat($sd,'Function')"/>
<xsl:variable name="sd:Graph"    select="concat($sd,'Graph')"/>
<xsl:variable name="sd:GraphCollection"    select="concat($sd,'GraphCollection')"/>
<xsl:variable name="sd:Language"    select="concat($sd,'Language')"/>
<xsl:variable name="sd:NamedGraph"    select="concat($sd,'NamedGraph')"/>
<xsl:variable name="sd:Service"    select="concat($sd,'Service')"/>
<xsl:variable name="sd:availableGraphs"    select="concat($sd,'availableGraphs')"/>
<xsl:variable name="sd:defaultDataset"    select="concat($sd,'defaultDataset')"/>
<xsl:variable name="sd:defaultEntailmentRegime"    select="concat($sd,'defaultEntailmentRegime')"/>
<xsl:variable name="sd:defaultGraph"    select="concat($sd,'defaultGraph')"/>
<xsl:variable name="sd:defaultSupportedEntailmentProfile"    select="concat($sd,'defaultSupportedEntailmentProfile')"/>
<xsl:variable name="sd:endpoint"    select="concat($sd,'endpoint')"/>
<xsl:variable name="sd:entailmentRegime"    select="concat($sd,'entailmentRegime')"/>
<xsl:variable name="sd:extensionAggregate"    select="concat($sd,'extensionAggregate')"/>
<xsl:variable name="sd:extensionFunction"    select="concat($sd,'extensionFunction')"/>
<xsl:variable name="sd:feature"    select="concat($sd,'feature')"/>
<xsl:variable name="sd:graph"    select="concat($sd,'graph')"/>
<xsl:variable name="sd:inputFormat"    select="concat($sd,'inputFormat')"/>
<xsl:variable name="sd:languageExtension"    select="concat($sd,'languageExtension')"/>
<xsl:variable name="sd:name"    select="concat($sd,'name')"/>
<xsl:variable name="sd:namedGraph"    select="concat($sd,'namedGraph')"/>
<xsl:variable name="sd:propertyFeature"    select="concat($sd,'propertyFeature')"/>
<xsl:variable name="sd:resultFormat"    select="concat($sd,'resultFormat')"/>
<xsl:variable name="sd:supportedEntailmentProfile"    select="concat($sd,'supportedEntailmentProfile')"/>
<xsl:variable name="sd:supportedLanguage"    select="concat($sd,'supportedLanguage')"/>

<xsl:variable name="sd:ALL" select="(
   $sd:Language,
   $sd:languageExtension,
   $sd:supportedEntailmentProfile,
   $sd:name,
   $sd:Graph,
   $sd:feature,
   $sd:GraphCollection,
   $sd:EntailmentProfile,
   $sd:namedGraph,
   $sd:Aggregate,
   $sd:defaultEntailmentRegime,
   $sd:defaultDataset,
   $sd:EntailmentRegime,
   $sd:defaultGraph,
   $sd:resultFormat,
   $sd:graph,
   $sd:endpoint,
   $sd:Dataset,
   $sd:inputFormat,
   $sd:NamedGraph,
   $sd:extensionFunction,
   $sd:Function,
   $sd:defaultSupportedEntailmentProfile,
   $sd:supportedLanguage,
   $sd:extensionAggregate,
   $sd:entailmentRegime,
   $sd:availableGraphs,
   $sd:Feature,
   $sd:propertyFeature,
   $sd:Service
)"/>

</xsl:transform>
