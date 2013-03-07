<!--
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/blob/master/src/xsl/grddl/graffle.xsl>;
#3>    prov:has_provenance   <https://raw.github.com/timrdf/vsr/master/src/xsl/grddl/graffle.xsl.prov.ttl>;
#3>    prov:wasAttributedTo  <http://purl.org/twc/id/person/TimLebo>;
#3> .
-->
<xsl:transform version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:g="https://raw.github.com/timrdf/vsr/master/src/xsl/grddl/graffle.xsl#"
   xmlns:xfm="transform namespace"
   xmlns:pmm="edu.rpi.tw.string.pmm"
   xmlns:sof="http://stackoverflow.com/questions/6753343/using-xsl-to-make-a-hash-of-xml-file"
   exclude-result-prefixes="g xfm">
<!--xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/-->
<xsl:output method="text"/>

<!--xsl:include href="../util/rtf-function.xsl"/-->
<xd:doc>
   <xd:short>Strip RTF to get the textual message.</xd:short>
   <xd:detail>
   </xd:detail>
   <xd:param name="rtf">An Rich Text Formatted string from which to extract the string message.</xd:param>
</xd:doc>
<xsl:function name="xfm:rtf2txt">
   <xsl:param name="rtf"/>
   <xsl:value-of select="replace(replace(replace($rtf,'^.* ','','s'),'.$',''),$NL,'')"/>
</xsl:function>

<xsl:key name="vnode" match="dict" use="dict[key[.='ID']]/following-sibling::integer[1]"/>

<!--
<dict>
   <key>Bounds</key>  <string>{{333.48055399954319, 2072.000203193691}, {46, 18}}</string>
   <key>Class</key>   <string>ShapedGraphic</string>
   <key>ID</key>      <integer>1411</integer>
-->
<xsl:function name="g:value-of">
   <xsl:param name="key"/>
   <xsl:param name="node" as="node()"/>
   <xsl:copy-of select="$node/key[.=$key]/following-sibling::*[1]"/>
</xsl:function>

<xsl:template match="/">
   <!-- TODO: use the modification date to create alternates of those that were minted during the visualization process.
      the latest alternate can be found, and the series of alternates can be clustered into "no change" -->
   <!--rdf:RDF-->
   <xsl:value-of select="concat(
            '@prefix rdfs:    &lt;http://www.w3.org/2000/01/rdf-schema#&gt; .',$NL,
            '@prefix vsr:     &lt;http://purl.org/twc/vocab/vsr#&gt; .',$NL,
            '@prefix graffle: &lt;http://purl.org/twc/vocab/vsr/graffle#&gt; .',$NL
         )"/>

      <xsl:apply-templates select="//key[.='GraphicsList']/following-sibling::array[1]/dict" mode="turtle"/>
   <!--/rdf:RDF-->
</xsl:template>

<xsl:template match="dict" mode="turtle">
   <xsl:value-of select="concat($NL,
      '&lt;',g:value-of('ID',.),'&gt;',$NL,
      '   a vsr:Graphic, graffle:',g:value-of('Class',.),';',$NL,
      if (string-length(g:value-of('Shape',.))) 
         then concat('   a graffle:',g:value-of('Shape',.),';',$NL) 
         else '',
      if (g:value-of('Text',.))
         then concat('   rdfs:label ',$DQ,replace(xfm:rtf2txt(g:value-of('Text',g:value-of('Text',.))),'\\','\\\\'),$DQ,';',$NL) 
         else '',
      if (g:value-of('Link',.))
         then concat('   rdfs:seeAlso &lt;',g:value-of('url',g:value-of('Link',.)),'&gt;;',$NL) 
         else ''
   )"/>

   <xsl:variable name="rgb" select="
      if (g:value-of('Style',.) and 
          g:value-of('fill',g:value-of('Style',.)) and
          g:value-of('Color',g:value-of('fill',g:value-of('Style',.)))
         )
         then concat( g:value-of('r',g:value-of('Color',g:value-of('fill',g:value-of('Style',.)))),' ',
                      g:value-of('g',g:value-of('Color',g:value-of('fill',g:value-of('Style',.)))),' ',
                      g:value-of('b',g:value-of('Color',g:value-of('fill',g:value-of('Style',.)))),
                      if (g:value-of('a',g:value-of('Color',g:value-of('fill',g:value-of('Style',.))))) 
                      then concat(' ',g:value-of('a',g:value-of('Color',g:value-of('fill',g:value-of('Style',.))))) else ''
                    ) 
         else ''"/>
   <xsl:if test="string-length($rgb)">
      <xsl:value-of select="concat('   vsr:fill &lt;color/',sof:checksum($rgb),'&gt;;',$NL)"/>
   </xsl:if>

   <xsl:variable name="bounds" select="tokenize(translate(g:value-of('Bounds',.),',{}',''),' ')"/>
   <xsl:value-of select="
      if (count($bounds) = 4) 
         then concat('   vsr:x      ',$bounds[1],';',$NL,
                     '   vsr:y      ',$bounds[2],';',$NL,
                     '   vsr:width  ',$bounds[3],';',$NL,
                     '   vsr:height ',$bounds[4],';',$NL)
         else ''
   "/>

   <xsl:for-each select="g:value-of('UserInfo',.)/key">
      <xsl:variable name="value" select="./following-sibling::*[1]"/>
      <xsl:choose>
         <xsl:when test="starts-with($value,'http:')">
            <xsl:value-of select="concat('   &lt;',.,'&gt; &lt;',$value,'&gt;;',$NL)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="concat('   &lt;',.,'&gt; ',$DQ,replace($value,$DQ,''),$DQ,';',$NL)"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:for-each>
   <xsl:value-of select="concat('.',$NL)"/>

   <xsl:if test="string-length($rgb)">
      <xsl:value-of select="concat($NL,'&lt;color/',sof:checksum($rgb),'&gt; a vsr:Color; vsr:rgb ',$DQ,$rgb,$DQ,' .',$NL)"/>
   </xsl:if>

</xsl:template>

<!--xsl:template match="dict" mode="application/rdf+xml">
   <rdf:Description rdf:about="{g:value-of('ID',.)}">
      <rdf:type rdf:resource="{g:value-of('Class',.)}"/>
      <xsl:if test="string-length(g:value-of('Shape',.))">
         <rdf:type rdf:resource="{g:value-of('Shape',.)}"/>
      </xsl:if>
      <xsl:if test="g:value-of('Text',.)">
         <rdfs:label><xsl:value-of select="xfm:rtf2txt(g:value-of('Text',g:value-of('Text',.)))"/></rdfs:label>
      </xsl:if>
      <xsl:for-each select="g:value-of('UserInfo',.)/key">
         <xsl:element name="{pmm:bestQName(.)}">
           <xsl:value-of select="./following-sibling::*[1]"/>
         </xsl:element>
      </xsl:for-each>
   </rdf:Description>
</xsl:template-->

<xsl:template match="@*|node()">
  <xsl:copy>
      <xsl:copy-of select="@*"/>   
      <xsl:apply-templates/>
  </xsl:copy>
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

</xsl:transform>
