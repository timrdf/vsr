<xsl:transform version="2.0" 
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:xd="http://www.pnp-software.com/XSLTdoc"
               xmlns:xfm="transform namespace"
               xmlns:xutil="https://github.com/timrdf/vsr/tree/master/src/xsl/util"
               exclude-result-prefixes="">

<xd:doc type="stylesheet">
   <xd:short>Determine the URI of an RDF/XML element, check if string is URI.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<xsl:function name="xfm:uri"> <!-- DEPRECATED; use xutil:uri -->
   <xsl:param name="node" as="node()"/>
   <xsl:value-of select="concat(namespace-uri-from-QName(node-name($node)),local-name($node))"/>
</xsl:function>

<xsl:function name="xutil:uri">
   <xsl:param name="node" as="node()"/>
   <xsl:value-of select="concat(namespace-uri-from-QName(node-name($node)),local-name($node))"/>
</xsl:function>

<xsl:function name="xutil:is-uri">
   <xsl:param name="string"/>
   <!--xsl:message select="concat($string,' ',matches($string,'^http'))"/-->
   <xsl:copy-of select="matches($string,'^http.*')"/>
</xsl:function>

</xsl:transform>
