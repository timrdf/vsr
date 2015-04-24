<!-- Timothy Lebo -->
<xsl:transform version="2.0" 
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:xs="http://www.w3.org/2001/XMLSchema#"
               xmlns:xd="http://www.pnp-software.com/XSLTdoc"
               xmlns:xutil="https://github.com/timrdf/vsr/tree/master/src/xsl/util"
					exclude-result-prefixes="">

<xd:doc type="stylesheet">
   <xd:short>Abbreviate strings for display purposes.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- 
-  @return the given 'string' if 'true'. 
-  Optionally wrap in an indent and newline if 'wrap-in-indent-and-NL'.
- -->
<xsl:function name="xutil:chomp">
   <xsl:param name="long-string"/>
   <xsl:value-of select="xutil:chomp($long-string,30)"/>
</xsl:function>

<!-- 
-  @return the given 'string' if 'true'. 
-  Optionally wrap in an indent and newline if 'wrap-in-indent-and-NL'.
- -->
<xsl:function name="xutil:chomp">
   <xsl:param name="long-string"/>
   <xsl:param name="limit"/>
   <xsl:value-of select="if (string-length($long-string) le number($limit)) 
                         then $long-string 
                         else concat(substring($long-string,1,15),'  . . .  ',substring($long-string,string-length($long-string)-15,16))"/>
</xsl:function>

</xsl:transform>
