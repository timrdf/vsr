<xsl:transform version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:xfm="transform namespace"
   xmlns:idm="java:edu.rpi.tw.string.IDManager"
   exclude-result-prefixes="xs xfm xd">

<xd:doc type="stylesheet">
   <xd:short>Maintain alternate identities.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<xd:doc>
   <xd:short>Maintain alternate identifiers for given identifiers.</xd:short>
   <xd:detail>Implemented in XPath.</xd:detail>
   <xd:param name="string_id">A client-side string that uniquely identifies some thing.</xd:param>
</xd:doc>
<xsl:function name="xfm:atoid">
   <xsl:param name="string_id"/>
   <!-- TODO: if the string is too long, the associated number gets too big quickly -->
   <xsl:value-of select="string-join(for $c in string-to-codepoints($string_id) return xs:string($c),'')"/>
</xsl:function>

<xsl:variable name="xfms_id_manager" select="idm:new()"/>
<xd:doc>
   <xd:short>Maintain alternate identifiers for given identifiers.</xd:short>
   <xd:detail>Implemented in Java.
              If the provided label has not been assigned an identifier, 
              assign an identifier that has not been assigned. 
              Requesting the identifier of a label repeatedly returns the same identifier.
    </xd:detail>
   <xd:param name="string_id">A client-side string that uniquely identifies some thing.</xd:param>
</xd:doc>
<xsl:function name="xfm:atoid-smaller">
   <!-- This is a modified version of xfm:atoid that returns a smaller number for the input string. -->
   <xsl:param name="string_id"/>
   <xsl:value-of select="idm:getIdentifier($xfms_id_manager,$string_id)"/>
</xsl:function>

</xsl:transform>
