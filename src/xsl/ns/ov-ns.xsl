<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:ov="http://open.vocab.org/terms/">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<xsl:variable name="ov" select="'http://open.vocab.org/terms/'"/>
<xsl:variable name="ov:VisualElement"         select="concat($ov,'VisualElement')"/>
<xsl:variable name="ov:manchax"               select="concat($ov,'manchax')"/>
<xsl:variable name="ov:involves"              select="concat($ov,'involves')"/>
<xsl:variable name="ov:depictsSameResourceAs" select="concat($ov,'depictsSameResourceAs')"/>
<xsl:variable name="ov:depicts"               select="concat($ov,'depicts')"/>

<xsl:variable name="ov:shortName"             select="concat($ov,'shortName')"/>

<xsl:variable name="ov:csvRow"                select="concat($ov,'csvRow')"/>
<xsl:variable name="ov:csvCol"                select="concat($ov,'csvCol')"/>
<xsl:variable name="ov:csvHeader"             select="concat($ov,'csvHeader')"/>
<xsl:variable name="ov:subjectDiscriminator"  select="concat($ov,'subjectDiscriminator')"/>

<xsl:variable name="ov:ALL" select="(
   $ov:csvRow,
   $ov:csvCol,
   $ov:csvHeader,
   $ov:subjectDiscriminator
)"/>

</xsl:transform>
