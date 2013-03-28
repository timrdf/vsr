<xsl:transform version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:sr="http://www.w3.org/2005/sparql-results#"
   exclude-result-prefixes="">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

<xsl:template match="/">
   <xsl:apply-templates select="//sr:results/sr:result"/>
</xsl:template>

<xsl:template match="sr:result">
   <xsl:value-of select="concat(sr:binding[@name='file'],if (sr:binding[@name='page']) then concat('_||_',sr:binding[@name='page']) else '',$NL)"/>
</xsl:template>

<!--xsl:template match="text()">
   <xsl:value-of select="normalize-space(.)"/>
</xsl:template-->

<xsl:variable name="NL" select="'&#xa;'"/>
<xsl:variable name="DQ" select="'&#x22;'"/>

</xsl:transform>
