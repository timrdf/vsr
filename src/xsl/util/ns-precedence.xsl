<!-- Timothy Lebo -->
<xsl:transform version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:xutil="https://github.com/timrdf/vsr/tree/master/src/xsl/util"
   exclude-result-prefixes="">

<!--xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/-->

<xd:doc type="stylesheet">
   <xd:short>Ordering namespaces.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<xsl:function name="xutil:ns-precedence-string">
   <xsl:param name="uri"/> 
   <!--xsl:variable name="shorthand"-->
      <xsl:choose>
         <xsl:when test="$uri = $rdf">
            <xsl:copy-of select="1"/>
         </xsl:when>
         <xsl:when test="$uri = $rdfs">
            <xsl:copy-of select="2"/>
         </xsl:when>
         <xsl:when test="$uri = $owl">
            <xsl:copy-of select="3"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="9999999"/>
         </xsl:otherwise>
      </xsl:choose>
   <!--/xsl:variable>
   <xsl:message select="concat('short hand for ',$restriction-type,': ',$shorthand)"/-->
 </xsl:function>

<xsl:function name="xutil:ns-precedence">
   <xsl:param name="contextNode"/> 
   <xsl:variable name="ns" select="namespace-uri-from-QName(node-name($contextNode))"/>
   <xsl:value-of select="xutil:ns-precedence-string($ns)"/>
   <!--xsl:variable name="shorthand"-->
      <!--xsl:choose>
         <xsl:when test="$ns = $rdf">
            <xsl:copy-of select="1"/>
         </xsl:when>
         <xsl:when test="$ns = $rdfs">
            <xsl:copy-of select="2"/>
         </xsl:when>
         <xsl:when test="$ns = $owl">
            <xsl:copy-of select="3"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="9999999"/>
         </xsl:otherwise>
      </xsl:choose-->
   <!--/xsl:variable>
   <xsl:message select="concat('short hand for ',$restriction-type,': ',$shorthand)"/-->
</xsl:function>

</xsl:transform>
