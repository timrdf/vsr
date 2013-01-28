<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:void="http://rdfs.org/ns/void#">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="void"                select="'http://rdfs.org/ns/void#'"/>

<!-- Terms within the namespace -->
<xsl:variable name="void:Dataset"    select="concat($void,'Dataset')"/>
<xsl:variable name="void:DatasetDescription"    select="concat($void,'DatasetDescription')"/>
<xsl:variable name="void:Linkset"    select="concat($void,'Linkset')"/>
<xsl:variable name="void:TechnicalFeature"    select="concat($void,'TechnicalFeature')"/>
<xsl:variable name="void:class"    select="concat($void,'class')"/>
<xsl:variable name="void:classPartition"    select="concat($void,'classPartition')"/>
<xsl:variable name="void:classes"    select="concat($void,'classes')"/>
<xsl:variable name="void:dataDump"    select="concat($void,'dataDump')"/>
<xsl:variable name="void:distinctObjects"    select="concat($void,'distinctObjects')"/>
<xsl:variable name="void:distinctSubjects"    select="concat($void,'distinctSubjects')"/>
<xsl:variable name="void:documents"    select="concat($void,'documents')"/>
<xsl:variable name="void:entities"    select="concat($void,'entities')"/>
<xsl:variable name="void:exampleResource"    select="concat($void,'exampleResource')"/>
<xsl:variable name="void:feature"    select="concat($void,'feature')"/>
<xsl:variable name="void:inDataset"    select="concat($void,'inDataset')"/>
<xsl:variable name="void:linkPredicate"    select="concat($void,'linkPredicate')"/>
<xsl:variable name="void:objectsTarget"    select="concat($void,'objectsTarget')"/>
<xsl:variable name="void:openSearchDescription"    select="concat($void,'openSearchDescription')"/>
<xsl:variable name="void:properties"    select="concat($void,'properties')"/>
<xsl:variable name="void:property"    select="concat($void,'property')"/>
<xsl:variable name="void:propertyPartition"    select="concat($void,'propertyPartition')"/>
<xsl:variable name="void:rootResource"    select="concat($void,'rootResource')"/>
<xsl:variable name="void:sparqlEndpoint"    select="concat($void,'sparqlEndpoint')"/>
<xsl:variable name="void:subjectsTarget"    select="concat($void,'subjectsTarget')"/>
<xsl:variable name="void:subset"    select="concat($void,'subset')"/>
<xsl:variable name="void:target"    select="concat($void,'target')"/>
<xsl:variable name="void:triples"    select="concat($void,'triples')"/>
<xsl:variable name="void:uriLookupEndpoint"    select="concat($void,'uriLookupEndpoint')"/>
<xsl:variable name="void:uriRegexPattern"    select="concat($void,'uriRegexPattern')"/>
<xsl:variable name="void:uriSpace"    select="concat($void,'uriSpace')"/>
<xsl:variable name="void:vocabulary"    select="concat($void,'vocabulary')"/>

<xsl:variable name="void:ALL" select="(
   $void:subset,
   $void:rootResource,
   $void:class,
   $void:property,
   $void:uriLookupEndpoint,
   $void:target,
   $void:uriRegexPattern,
   $void:TechnicalFeature,
   $void:feature,
   $void:classPartition,
   $void:distinctSubjects,
   $void:documents,
   $void:subjectsTarget,
   $void:exampleResource,
   $void:dataDump,
   $void:classes,
   $void:inDataset,
   $void:vocabulary,
   $void:properties,
   $void:DatasetDescription,
   $void:entities,
   $void:openSearchDescription,
   $void:distinctObjects,
   $void:sparqlEndpoint,
   $void:Linkset,
   $void:Dataset,
   $void:triples,
   $void:linkPredicate,
   $void:uriSpace,
   $void:objectsTarget,
   $void:propertyPartition
)"/>

</xsl:transform>
