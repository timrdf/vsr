<xsl:transform version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   exclude-result-prefixes="">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

<xsl:template match="@*|node()">
  <xsl:copy>
      <xsl:copy-of select="@*"/>   
      <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

</xsl:transform>
