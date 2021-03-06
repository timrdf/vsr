<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:xfm="transform namespace">

<xd:doc type="stylesheet">
   <xd:short>Variables for characters that are tricky to use in XSL.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<xsl:variable name="SQ">'</xsl:variable>
<xsl:variable name="DQ">"</xsl:variable>
<xsl:variable name="DAPOS">"</xsl:variable>
<xsl:variable name="LT">&lt;</xsl:variable>
<xsl:variable name="GT">&gt;</xsl:variable>

<xsl:variable name="IN">
   <xsl:value-of select="'   '"/>
</xsl:variable>

<xsl:variable name="NL">
<xsl:text>
</xsl:text>
</xsl:variable>

<xsl:function name="xfm:printNspaces">
   <xsl:param name="n" as="xs:integer"/>
   <xsl:choose>
      <xsl:when test="$n = 0">
         <xsl:value-of select="' '"/>
      </xsl:when>
      <xsl:when test="$n > 0">
         <xsl:value-of select="concat(' ',xfm:printNspaces($n - 1))"/>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
   </xsl:choose>
</xsl:function>

</xsl:transform>
