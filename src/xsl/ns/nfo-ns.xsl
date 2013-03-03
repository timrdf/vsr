<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:nfo="http://www.semanticdesktop.org/ontologies/nfo/#">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="nfo"                select="'http://www.semanticdesktop.org/ontologies/nfo/#'"/>

<!-- Terms within the namespace -->
<xsl:variable name="nfo:FileDataObject" select="concat($nfo,'FileDataObject')"/>
<xsl:variable name="nfo:fileName"       select="concat($nfo,'fileName')"/>
<xsl:variable name="nfo:hasHash"        select="concat($nfo,'hasHash')"/>

<xsl:variable name="nfo:FileHash"       select="concat($nfo,'FileHash')"/>
<xsl:variable name="nfo:hashValue"      select="concat($nfo,'hashValue')"/>
<xsl:variable name="nfo:hashAlgorithm"  select="concat($nfo,'hashAlgorithm')"/>

<xsl:variable name="nfo:ALL" select="(
   $nfo:fileName,
   $nfo:hashAlgorithm,
   $nfo:FileDataObject
)"/>

</xsl:transform>
