<!--
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/blob/master/src/xsl/grddl/svg.xsl>;
#3>    prov:has_provenance   <https://raw.github.com/timrdf/vsr/master/src/xsl/grddl/svg.xsl.prov.ttl>;
#3>    prov:wasAttributedTo  <http://purl.org/twc/id/person/TimLebo>;
#3> .
-->
<xsl:transform version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"

   xmlns:vsr="http://purl.org/twc/vocab/vsr#"

   xmlns:g="https://raw.github.com/timrdf/vsr/master/src/xsl/grddl/svg.xsl#"
   xmlns:svg="http://www.w3.org/2000/svg"

   xmlns:pmm="edu.rpi.tw.string.pmm"
   xmlns:xfm="transform namespace"
   xmlns:sof="http://stackoverflow.com/questions/6753343/using-xsl-to-make-a-hash-of-xml-file"
   exclude-result-prefixes="g xfm">
<!--xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/-->
<xsl:output method="text"/>

<!--xsl:include href="../util/rtf-function.xsl"/-->
<xd:doc>
   <xd:short>Strip RTF to get the textual message.</xd:short>
   <xd:detail>
   </xd:detail>
   <xd:param name="rtf">A Rich Text Formatted string from which to extract the string message.</xd:param>
</xd:doc>
<xsl:function name="xfm:rtf2txt">
   <xsl:param name="rtf"/>
   <xsl:value-of select="replace(replace(replace($rtf,'^.* ','','s'),'.$',''),$NL,'')"/>
</xsl:function>

<xsl:variable name="vsr:depicts" select="'http://purl.org/twc/vocab/vsr#depicts'"/>

<xsl:template match="/">
   <!-- TODO: use the modification date to create alternates of those that were minted during the visualization process.
      the latest alternate can be found, and the series of alternates can be clustered into "no change" -->
   <xsl:value-of select="concat(
            '@prefix rdfs:    &lt;http://www.w3.org/2000/01/rdf-schema#&gt; .',$NL,
            '@prefix dcterms: &lt;http://purl.org/dc/terms/&gt; .',$NL,
            '@prefix sio:     &lt;http://semanticscience.org/resource/&gt; .',$NL,
            '@prefix vsr:     &lt;http://purl.org/twc/vocab/vsr#&gt; .',$NL,
            '@prefix svg:     &lt;http://purl.org/twc/vocab/vsr/svg#&gt; .',$NL
         )"/>

      <xsl:apply-templates select="//svg:*[svg:metadata[*]]" mode="turtle"/>
</xsl:template>

<xsl:template match="svg:svg[svg:metadata[*]]" mode="turtle"/>

<xsl:template match="svg:*[svg:metadata[*]]" mode="turtle">

   <xsl:variable name="number">
      <xsl:number select="." count="svg:*" level="any"/>
   </xsl:variable>

   <xsl:value-of select="concat($NL,
      '&lt;graphic/',if (@id) then sof:checksum(@id) else $number,'&gt;',$NL,
      '   a vsr:Graphic, svg:',local-name(.),';',$NL,
      if (@id) 
         then concat('   dcterms:identifier ',$DQ,@id,$DQ,';',$NL) 
         else ''
   )"/>
   <!--
      if (key('value',key('id',$vsr:depicts),.)) 
         then concat('   vsr:depicts &lt;',key('value',key('id',$vsr:depicts),.),'&gt;;',$NL) 
         else ''
   -->

   <xsl:for-each select="svg:metadata/*">
      <xsl:variable name="attr"  select="xfm:uri(.)"/>
      <xsl:variable name="value" select="@rdf:resource | text()[1]"/>
      <xsl:choose>
         <xsl:when test="starts-with($attr,'http:') and starts-with($value,'http:')">
            <xsl:value-of select="concat('   &lt;',$attr,'&gt; &lt;',$value,'&gt;;',$NL)"/>
         </xsl:when>
         <xsl:otherwise>
            <!--xsl:value-of select="concat('   &lt;',.,'&gt; ',$DQ,replace($value,$DQ,''),$DQ,';',$NL)"/-->
         </xsl:otherwise>
      </xsl:choose>
   </xsl:for-each>

   <xsl:value-of select="concat('.',$NL)"/>

</xsl:template>

<xsl:variable name="NL" select="'&#xa;'"/>
<xsl:variable name="DQ">"</xsl:variable>

<xsl:function name="sof:checksum" as="xs:integer">
   <xsl:param name="str" as="xs:string"/>
   <!-- Quoted from http://stackoverflow.com/questions/6753343/using-xsl-to-make-a-hash-of-xml-file -->
   <xsl:variable name="codepoints" select="string-to-codepoints($str)"/>
   <xsl:value-of select="sof:fletcher16($codepoints, count($codepoints), 1, 0, 0)"/>
</xsl:function>

<xsl:function name="sof:fletcher16">
   <xsl:param name="str"   as="xs:integer*"/>
   <xsl:param name="len"   as="xs:integer" />
   <xsl:param name="index" as="xs:integer" />
   <xsl:param name="sum1"  as="xs:integer" />
   <xsl:param name="sum2"  as="xs:integer"/>
   <!-- Quoted from http://stackoverflow.com/questions/6753343/using-xsl-to-make-a-hash-of-xml-file -->
   <xsl:choose>
      <xsl:when test="$index ge $len">
         <xsl:sequence select="$sum2 * 256 + $sum1"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:variable name="newSum1" as="xs:integer"
             select="($sum1 + $str[$index]) mod 255"/>
         <xsl:sequence select="sof:fletcher16($str, $len, $index + 1, $newSum1,
                 ($sum2 + $newSum1) mod 255)" />
      </xsl:otherwise>
   </xsl:choose>
</xsl:function>

<xsl:function name="xfm:uri"> <!-- DEPRECATED; use xutil:uri -->
   <xsl:param name="node" as="node()"/>
   <xsl:value-of select="concat(namespace-uri-from-QName(node-name($node)),local-name($node))"/>
</xsl:function>

</xsl:transform>