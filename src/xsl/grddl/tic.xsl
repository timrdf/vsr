<!--
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/blob/master/src/xsl/grddl/tic.xsl>;
#3>    rdfs:seeAlso <https://github.com/timrdf/csv2rdf4lod-automation/wiki/tic-turtle-in-comments>;
#3> .
-->
<xsl:transform version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   exclude-result-prefixes="">
<xsl:output method="text"/>

<xsl:template match="/">
   <xsl:apply-templates select="//comment()[contains(.,'#3')]"/>
</xsl:template>

<xsl:template match="comment()">
   <xsl:value-of select="replace(.,'#3&gt; *','')"/>
</xsl:template>

<xsl:variable name="NL" select="'&#xa;'"/>
<xsl:variable name="DQ" select="'&#x22;'"/>

</xsl:transform>
