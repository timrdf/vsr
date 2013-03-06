<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:vsr="http://purl.org/twc/vocab/vsr#">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="vsr"                                 select="'http://purl.org/twc/vocab/vsr#'"/>

<!-- Terms within the namespace -->
<xsl:variable name="vsr:VisualElementFactory"            select="concat($vsr,'VisualElementFactory')"/>
<xsl:variable name="vsr:BlacklistChecker"                select="concat($vsr,'BlacklistChecker')"/>
<xsl:variable name="vsr:Relaxer"                         select="concat($vsr,'Relaxer')"/>
<xsl:variable name="vsr:CleanupCrew"                     select="concat($vsr,'CleanupCrew')"/>
<xsl:variable name="vsr:determined_by_deferrer"          select="concat($vsr,'determined_by_deferrer')"/>
<xsl:variable name="vsr:Dataset"                         select="concat($vsr,'Dataset')"/>
<xsl:variable name="vsr:SubjectsDataset"                 select="concat($vsr,'SubjectsDataset')"/>
<xsl:variable name="vsr:PredicatesDataset"               select="concat($vsr,'PredicatesDataset')"/>
<xsl:variable name="vsr:ObjectsDataset"                  select="concat($vsr,'ObjectsDataset')"/>
<xsl:variable name="vsr:ResourceObjectsDataset"          select="concat($vsr,'ResourceObjectsDataset')"/>
<xsl:variable name="vsr:LiteralObjectsDataset"           select="concat($vsr,'LiteralObjectsDataset')"/>
<xsl:variable name="vsr:TypedLiteralObjectDataset"       select="concat($vsr,'TypedLiteralObjectDataset')"/>
<xsl:variable name="vsr:TypedLiteralObjectsValueDataset" select="concat($vsr,'TypedLiteralObjectsValueDataset')"/>
<xsl:variable name="vsr:PredicateOccurrenceDataset"      select="concat($vsr,'PredicateOccurrenceDataset')"/>
<xsl:variable name="vsr:Bin"                             select="concat($vsr,'Bin')"/>

<!-- Processing provenance -->
<xsl:variable name="vsr:Prevent_default_processing"      select="concat($vsr,'Prevent_default_processing')"/>

<!-- Abstract Visual Representation -->
<xsl:variable name="vsr:fill"                            select="concat($vsr,'fill')"/>
<xsl:variable name="vsr:stroke"                          select="concat($vsr,'stroke')"/>
<xsl:variable name="vsr:from"                            select="concat($vsr,'from')"/>
<xsl:variable name="vsr:from_domain"                     select="concat($vsr,'from_domain')"/>
<xsl:variable name="vsr:from_context"                    select="concat($vsr,'from_context')"/>
<xsl:variable name="vsr:to"                              select="concat($vsr,'to')"/>
<xsl:variable name="vsr:to_domain"                       select="concat($vsr,'to_domain')"/>
<xsl:variable name="vsr:tooltip"                         select="concat($vsr,'tooltip')"/>


<xsl:variable name="vsr:ALL" select="(
   $vsr:VisualElementFactory,
   $vsr:BlacklistChecker,
   $vsr:Relaxer,
   $vsr:CleanupCrew,
   $vsr:determined_by_deferrer,
   $vsr:Dataset,
   $vsr:TypedLiteralObjectDataset,
   $vsr:Bin,
   $vsr:TypedLiteralObjectsValueDataset,
   $vsr:PredicateOccurrenceDataset,
   $vsr:Prevent_default_processing
)"/>

</xsl:transform>
