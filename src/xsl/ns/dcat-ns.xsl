<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:dcat="http://www.w3.org/ns/dcat#">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="dcat"                select="'http://www.w3.org/ns/dcat#'"/>

<!-- Terms within the namespace -->
<xsl:variable name="dcat:Catalog"    select="concat($dcat,'Catalog')"/>
<xsl:variable name="dcat:CatalogRecord"    select="concat($dcat,'CatalogRecord')"/>
<xsl:variable name="dcat:Dataset"    select="concat($dcat,'Dataset')"/>
<xsl:variable name="dcat:Distribution"    select="concat($dcat,'Distribution')"/>
<xsl:variable name="dcat:Download"    select="concat($dcat,'Download')"/>
<xsl:variable name="dcat:Feed"    select="concat($dcat,'Feed')"/>
<xsl:variable name="dcat:WebService"    select="concat($dcat,'WebService')"/>
<xsl:variable name="dcat:accessURL"    select="concat($dcat,'accessURL')"/>
<xsl:variable name="dcat:bytes"    select="concat($dcat,'bytes')"/>
<xsl:variable name="dcat:dataDictionary"    select="concat($dcat,'dataDictionary')"/>
<xsl:variable name="dcat:dataQuality"    select="concat($dcat,'dataQuality')"/>
<xsl:variable name="dcat:dataset"    select="concat($dcat,'dataset')"/>
<xsl:variable name="dcat:distribution"    select="concat($dcat,'distribution')"/>
<xsl:variable name="dcat:granularity"    select="concat($dcat,'granularity')"/>
<xsl:variable name="dcat:keyword"    select="concat($dcat,'keyword')"/>
<xsl:variable name="dcat:record"    select="concat($dcat,'record')"/>
<xsl:variable name="dcat:size"    select="concat($dcat,'size')"/>
<xsl:variable name="dcat:theme"    select="concat($dcat,'theme')"/>
<xsl:variable name="dcat:themeTaxonomy"    select="concat($dcat,'themeTaxonomy')"/>

<xsl:variable name="dcat:ALL" select="(
   $dcat:CatalogRecord,
   $dcat:size,
   $dcat:dataset,
   $dcat:WebService,
   $dcat:Download,
   $dcat:dataQuality,
   $dcat:Feed,
   $dcat:Distribution,
   $dcat:themeTaxonomy,
   $dcat:dataDictionary,
   $dcat:Catalog,
   $dcat:distribution,
   $dcat:granularity,
   $dcat:keyword,
   $dcat:Dataset,
   $dcat:accessURL,
   $dcat:theme,
   $dcat:bytes,
   $dcat:record
)"/>

</xsl:transform>
