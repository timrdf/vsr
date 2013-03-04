<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:dce="http://purl.org/dc/elements/1.1/">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="dce"                select="'http://purl.org/dc/elements/1.1/'"/>

<!-- Terms within the namespace -->
<xsl:variable name="dce:contributor"    select="concat($dce,'contributor')"/>
<xsl:variable name="dce:coverage"    select="concat($dce,'coverage')"/>
<xsl:variable name="dce:creator"    select="concat($dce,'creator')"/>
<xsl:variable name="dce:date"    select="concat($dce,'date')"/>
<xsl:variable name="dce:description"    select="concat($dce,'description')"/>
<xsl:variable name="dce:format"    select="concat($dce,'format')"/>
<xsl:variable name="dce:identifier"    select="concat($dce,'identifier')"/>
<xsl:variable name="dce:language"    select="concat($dce,'language')"/>
<xsl:variable name="dce:publisher"    select="concat($dce,'publisher')"/>
<xsl:variable name="dce:relation"    select="concat($dce,'relation')"/>
<xsl:variable name="dce:rights"    select="concat($dce,'rights')"/>
<xsl:variable name="dce:source"    select="concat($dce,'source')"/>
<xsl:variable name="dce:subject"    select="concat($dce,'subject')"/>
<xsl:variable name="dce:title"    select="concat($dce,'title')"/>
<xsl:variable name="dce:type"    select="concat($dce,'type')"/>

<xsl:variable name="dce:ALL" select="(
   $dce:type,
   $dce:date,
   $dce:title,
   $dce:source,
   $dce:contributor,
   $dce:language,
   $dce:subject,
   $dce:publisher,
   $dce:format,
   $dce:coverage,
   $dce:identifier,
   $dce:description,
   $dce:relation,
   $dce:creator,
   $dce:rights
)"/>

</xsl:transform>
