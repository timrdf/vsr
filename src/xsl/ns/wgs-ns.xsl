<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:wgs="http://www.w3.org/2003/01/geo/wgs84_pos#">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<xsl:variable name="wgs" select="'http://www.w3.org/2003/01/geo/wgs84_pos#'"/>
<xsl:variable name="wgs-ns" select="'http://www.w3.org/2003/01/geo/wgs84_pos#'"/>

<xsl:variable name="wgs_lat"                select="concat($wgs-ns,'lat')"/>
<xsl:variable name="wgs_long"               select="concat($wgs-ns,'long')"/>

</xsl:transform>
