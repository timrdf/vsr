<!-- 
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/blob/master/src/xsl/util/tertiary.xsl> .
-->
<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:xfm="transform namespace">

<xsl:function name="xfm:tertiary">
  <xsl:param name="condition"/>
  <xsl:param name="true-val"/>
  <xsl:param name="false-val"/>
   <xsl:value-of select="if ($condition) 
                           then $true-val
                                       else $false-val"/>
</xsl:function>

</xsl:transform>
