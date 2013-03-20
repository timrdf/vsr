<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:qb="http://purl.org/linked-data/cube#">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="qb"                select="'http://purl.org/linked-data/cube#'"/>

<!-- Terms within the namespace -->
<xsl:variable name="qb:Attachable"    select="concat($qb,'Attachable')"/>
<xsl:variable name="qb:AttributeProperty"    select="concat($qb,'AttributeProperty')"/>
<xsl:variable name="qb:CodedProperty"    select="concat($qb,'CodedProperty')"/>
<xsl:variable name="qb:ComponentProperty"    select="concat($qb,'ComponentProperty')"/>
<xsl:variable name="qb:ComponentSet"    select="concat($qb,'ComponentSet')"/>
<xsl:variable name="qb:ComponentSpecification"    select="concat($qb,'ComponentSpecification')"/>
<xsl:variable name="qb:DataSet"    select="concat($qb,'DataSet')"/>
<xsl:variable name="qb:DataStructureDefinition"    select="concat($qb,'DataStructureDefinition')"/>
<xsl:variable name="qb:DimensionProperty"    select="concat($qb,'DimensionProperty')"/>
<xsl:variable name="qb:HierarchicalCodeList"    select="concat($qb,'HierarchicalCodeList')"/>
<xsl:variable name="qb:MeasureProperty"    select="concat($qb,'MeasureProperty')"/>
<xsl:variable name="qb:Observation"    select="concat($qb,'Observation')"/>
<xsl:variable name="qb:ObservationGroup"    select="concat($qb,'ObservationGroup')"/>
<xsl:variable name="qb:Slice"    select="concat($qb,'Slice')"/>
<xsl:variable name="qb:SliceKey"    select="concat($qb,'SliceKey')"/>
<xsl:variable name="qb:attribute"    select="concat($qb,'attribute')"/>
<xsl:variable name="qb:codeList"    select="concat($qb,'codeList')"/>
<xsl:variable name="qb:component"    select="concat($qb,'component')"/>
<xsl:variable name="qb:componentAttachment"    select="concat($qb,'componentAttachment')"/>
<xsl:variable name="qb:componentProperty"    select="concat($qb,'componentProperty')"/>
<xsl:variable name="qb:componentRequired"    select="concat($qb,'componentRequired')"/>
<xsl:variable name="qb:concept"    select="concat($qb,'concept')"/>
<xsl:variable name="qb:dataSet"    select="concat($qb,'dataSet')"/>
<xsl:variable name="qb:dimension"    select="concat($qb,'dimension')"/>
<xsl:variable name="qb:hierarchyRoot"    select="concat($qb,'hierarchyRoot')"/>
<xsl:variable name="qb:measure"    select="concat($qb,'measure')"/>
<xsl:variable name="qb:measureDimension"    select="concat($qb,'measureDimension')"/>
<xsl:variable name="qb:measureType"    select="concat($qb,'measureType')"/>
<xsl:variable name="qb:observation"    select="concat($qb,'observation')"/>
<xsl:variable name="qb:observationGroup"    select="concat($qb,'observationGroup')"/>
<xsl:variable name="qb:order"    select="concat($qb,'order')"/>
<xsl:variable name="qb:parentChildProperty"    select="concat($qb,'parentChildProperty')"/>
<xsl:variable name="qb:slice"    select="concat($qb,'slice')"/>
<xsl:variable name="qb:sliceKey"    select="concat($qb,'sliceKey')"/>
<xsl:variable name="qb:sliceStructure"    select="concat($qb,'sliceStructure')"/>
<xsl:variable name="qb:structure"    select="concat($qb,'structure')"/>

<xsl:variable name="qb:ALL" select="(
   $qb:Slice,
   $qb:ComponentProperty,
   $qb:slice,
   $qb:attribute,
   $qb:Observation,
   $qb:observation,
   $qb:dimension,
   $qb:structure,
   $qb:sliceStructure,
   $qb:hierarchyRoot,
   $qb:dataSet,
   $qb:componentAttachment,
   $qb:codeList,
   $qb:HierarchicalCodeList,
   $qb:ComponentSet,
   $qb:concept,
   $qb:componentRequired,
   $qb:DataSet,
   $qb:measureType,
   $qb:measureDimension,
   $qb:component,
   $qb:ObservationGroup,
   $qb:MeasureProperty,
   $qb:DimensionProperty,
   $qb:Attachable,
   $qb:sliceKey,
   $qb:DataStructureDefinition,
   $qb:AttributeProperty,
   $qb:measure,
   $qb:CodedProperty,
   $qb:parentChildProperty,
   $qb:observationGroup,
   $qb:componentProperty,
   $qb:SliceKey,
   $qb:order,
   $qb:ComponentSpecification
)"/>

</xsl:transform>
