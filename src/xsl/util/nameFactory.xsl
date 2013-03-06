<!-- Timothy Lebo -->
<xsl:transform version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:jvr="jvr"
   xmlns:nmf="java:edu.rpi.tw.string.NameFactory"
   exclude-result-prefixes="xs jvr nmf">

<xd:doc type="stylesheet">
   <xd:short>Name things.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<xsl:function name="jvr:getUUIDName">
   <xsl:param name="string_id"/>
   <xsl:value-of select="nmf:getUUIDName($string_id)"/>
</xsl:function>

<xsl:function name="jvr:getMD5">
   <xsl:param name="string"/>
   <xsl:value-of select="nmf:getMD5($string)"/>
</xsl:function>

</xsl:transform>
