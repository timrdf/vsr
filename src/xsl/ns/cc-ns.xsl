<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:cc="http://creativecommons.org/ns#">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="cc"                select="'http://creativecommons.org/ns#'"/>

<!-- Terms within the namespace -->
<xsl:variable name="cc:Jurisdiction"    select="concat($cc,'Jurisdiction')"/>
<xsl:variable name="cc:License"    select="concat($cc,'License')"/>
<xsl:variable name="cc:Permission"    select="concat($cc,'Permission')"/>
<xsl:variable name="cc:Prohibition"    select="concat($cc,'Prohibition')"/>
<xsl:variable name="cc:Requirement"    select="concat($cc,'Requirement')"/>
<xsl:variable name="cc:Work"    select="concat($cc,'Work')"/>
<xsl:variable name="cc:attributionName"    select="concat($cc,'attributionName')"/>
<xsl:variable name="cc:attributionURL"    select="concat($cc,'attributionURL')"/>
<xsl:variable name="cc:deprecatedOn"    select="concat($cc,'deprecatedOn')"/>
<xsl:variable name="cc:jurisdiction"    select="concat($cc,'jurisdiction')"/>
<xsl:variable name="cc:legalcode"    select="concat($cc,'legalcode')"/>
<xsl:variable name="cc:license"    select="concat($cc,'license')"/>
<xsl:variable name="cc:morePermissions"    select="concat($cc,'morePermissions')"/>
<xsl:variable name="cc:permits"    select="concat($cc,'permits')"/>
<xsl:variable name="cc:prohibits"    select="concat($cc,'prohibits')"/>
<xsl:variable name="cc:requires"    select="concat($cc,'requires')"/>
<xsl:variable name="cc:useGuidelines"    select="concat($cc,'useGuidelines')"/>

<xsl:variable name="cc:ALL" select="(
   $cc:attributionName,
   $cc:prohibits,
   $cc:Requirement,
   $cc:deprecatedOn,
   $cc:requires,
   $cc:License,
   $cc:Jurisdiction,
   $cc:morePermissions,
   $cc:Work,
   $cc:attributionURL,
   $cc:jurisdiction,
   $cc:legalcode,
   $cc:Permission,
   $cc:license,
   $cc:useGuidelines,
   $cc:Prohibition,
   $cc:permits
)"/>

</xsl:transform>
