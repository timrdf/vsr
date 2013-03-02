<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:opmv="http://purl.org/net/opmv/ns#">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="opmv"                select="'http://purl.org/net/opmv/ns#'"/>

<!-- Terms within the namespace -->
<xsl:variable name="opmv:java"    select="concat($opmv,'java')"/>
<xsl:variable name="opmv:Agent"    select="concat($opmv,'Agent')"/>
<xsl:variable name="opmv:Artifact"    select="concat($opmv,'Artifact')"/>
<xsl:variable name="opmv:Process"    select="concat($opmv,'Process')"/>
<xsl:variable name="opmv:used"    select="concat($opmv,'used')"/>
<xsl:variable name="opmv:wasControlledBy"    select="concat($opmv,'wasControlledBy')"/>
<xsl:variable name="opmv:wasDerivedFrom"    select="concat($opmv,'wasDerivedFrom')"/>
<xsl:variable name="opmv:wasEncodedBy"    select="concat($opmv,'wasEncodedBy')"/>
<xsl:variable name="opmv:wasEndedAt"    select="concat($opmv,'wasEndedAt')"/>
<xsl:variable name="opmv:wasGeneratedAt"    select="concat($opmv,'wasGeneratedAt')"/>
<xsl:variable name="opmv:wasGeneratedBy"    select="concat($opmv,'wasGeneratedBy')"/>
<xsl:variable name="opmv:wasPerformedAt"    select="concat($opmv,'wasPerformedAt')"/>
<xsl:variable name="opmv:wasPerformedBy"    select="concat($opmv,'wasPerformedBy')"/>
<xsl:variable name="opmv:wasStartedAt"    select="concat($opmv,'wasStartedAt')"/>
<xsl:variable name="opmv:wasTriggeredBy"    select="concat($opmv,'wasTriggeredBy')"/>
<xsl:variable name="opmv:wasUsedAt"    select="concat($opmv,'wasUsedAt')"/>
<xsl:variable name="opmv:withRespectOf"    select="concat($opmv,'withRespectOf')"/>

<xsl:variable name="opmv:ALL" select="(
   $opmv:wasEndedAt,
   $opmv:wasPerformedAt,
   $opmv:Artifact,
   $opmv:wasDerivedFrom,
   $opmv:java,
   $opmv:Agent,
   $opmv:wasEncodedBy,
   $opmv:wasStartedAt,
   $opmv:wasGeneratedBy,
   $opmv:wasUsedAt,
   $opmv:withRespectOf,
   $opmv:wasTriggeredBy,
   $opmv:wasPerformedBy,
   $opmv:used,
   $opmv:Process,
   $opmv:wasControlledBy,
   $opmv:wasGeneratedAt
)"/>

</xsl:transform>
