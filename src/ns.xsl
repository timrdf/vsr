<xsl:transform version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:sr="http://www.w3.org/2005/sparql-results#"
   exclude-result-prefixes="">
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

<!-- 
<sparql xmlns="http://www.w3.org/2005/sparql-results#">
  <head>
    <variable name="term"/>
  </head>
  <results>
    <result>
      <binding name="term">
        <uri>http://rdfs.org/ns/void#Dataset</uri>
      </binding>
    </result>
-->

<xsl:template match="/">
   <xsl:apply-templates select="sr:sparql/sr:results/sr:result/sr:binding[@name='term']/sr:uri"/>
</xsl:template>

<xsl:template match="sr:uri">
   <xsl:value-of select="concat(text(),$NL)"/>
</xsl:template>

<xsl:template match="@*|node()">
  <xsl:copy>
      <xsl:copy-of select="@*"/>   
      <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:variable name="NL" select="'&#xa;'"/>

</xsl:transform>
