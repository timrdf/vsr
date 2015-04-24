<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:bte="http://purl.org/twc/vocab/between-the-edges/">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="bte"                                 select="'http://purl.org/twc/vocab/between-the-edges/'"/>

<!-- Terms within the namespace -->
<xsl:variable name="bte:Node"        select="concat($bte,'Node')"/>
<xsl:variable name="bte:RDFNode"     select="concat($bte,'RDFNode')"/>
<xsl:variable name="bte:SlashEndURI" select="concat($bte,'SlashEndURI')"/>

<xsl:variable name="bte:depth"       select="concat($bte,'depth')"/>
<xsl:variable name="bte:scheme"      select="concat($bte,'scheme')"/>
<xsl:variable name="bte:path"        select="concat($bte,'path')"/>
<xsl:variable name="bte:length"      select="concat($bte,'length')"/>
<xsl:variable name="bte:fragment"    select="concat($bte,'fragment')"/>
<xsl:variable name="bte:broader"     select="concat($bte,'broader')"/>
<xsl:variable name="bte:extension"   select="concat($bte,'extension')"/>
<xsl:variable name="bte:step"        select="concat($bte,'step')"/>
<xsl:variable name="bte:netloc"      select="concat($bte,'netloc')"/>

<xsl:variable name="bte:ALL" select="(
   $bte:RDFNode,
   $bte:depth,
   $bte:scheme,
   $bte:path,
   $bte:length,
   $bte:fragment,
   $bte:broader,
   $bte:extension,
   $bte:step,
   $bte:netloc
)"/>

</xsl:transform>
