<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:dcterms="http://purl.org/dc/terms/">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="dc"      select="'http://purl.org/dc/elements/1.1/'"/>
<xsl:variable name="dcterms" select="'http://purl.org/dc/terms/'"/>

<xsl:variable name="dcTitle"        select="concat($dc,'title')"/>
<xsl:variable name="dc-description" select="concat($dc,'description')"/>
<xsl:variable name="dc-creator"     select="concat($dc,'creator')"/>

<!-- Terms within the namespace -->
<xsl:variable name="dcterms:rightsHolder"   select="concat($dcterms,'rightsHolder')"/>
<xsl:variable name="dcterms:isReferencedBy" select="concat($dcterms,'isReferencedBy')"/>
<xsl:variable name="dcterms:identifier"     select="concat($dcterms,'identifier')"/>
<xsl:variable name="dcterms:description"    select="concat($dcterms,'description')"/>

</xsl:transform>
