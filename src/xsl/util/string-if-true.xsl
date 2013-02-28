<!-- Timothy Lebo -->
<xsl:transform version="2.0" 
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:xs="http://www.w3.org/2001/XMLSchema#"
               xmlns:xd="http://www.pnp-software.com/XSLTdoc"
               xmlns:xutil="https://github.com/timrdf/vsr/tree/master/src/xsl/util"
					exclude-result-prefixes="">

<xd:doc type="stylesheet">
   <xd:short>Conditional strings.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- 
-  @return the given 'string' if 'true'. 
-  Optionally wrap in an indent and newline if 'wrap-in-indent-and-NL'.
- -->
<xsl:function name="xutil:string-if-true">
   <xsl:param name="string"/>
   <xsl:param name="true"  />
   <xsl:value-of select="xutil:string-if-true($string,$true,false())"/>
</xsl:function>

<!-- 
-  @return the given 'string' if 'true'. 
-  Optionally wrap in an indent and newline if 'wrap-in-indent-and-NL'.
- -->
<xsl:function name="xutil:string-if-true">
   <xsl:param name="string"/>
   <xsl:param name="true"/>
   <xsl:param name="wrap-in-indent-and-NL"/>

   <xsl:if test="$wrap-in-indent-and-NL">
      <xsl:value-of select="if ($true) then concat($in,$string,$NL) else ''"/>
   </xsl:if>
   <xsl:if test="not($wrap-in-indent-and-NL)">
      <xsl:value-of select="if ($true) then $string else ''"/>
   </xsl:if>
</xsl:function>

</xsl:transform>
