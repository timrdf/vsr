<!--
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/blob/master/src/xsl/grddl/graffle.xsl>;
#3>    prov:has_provenance   <https://raw.github.com/timrdf/vsr/master/src/xsl/grddl/graffle.xsl.prov.ttl>;
#3>    prov:wasAttributedTo  <http://purl.org/twc/id/person/TimLebo>;
#3> .
-->
<xsl:transform version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:g="https://raw.github.com/timrdf/vsr/master/src/xsl/grddl/graffle.xsl#"
   xmlns:xfm="transform namespace"
   xmlns:pmm="edu.rpi.tw.string.pmm"
   exclude-result-prefixes="g xfm">
<!--xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/-->
<xsl:output method="text"/>

<xsl:include href="../util/rtf-function.xsl"/>

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
   <!-- TODO: use the modification date to create altenrates of those that were minted during the visualization process.
      the latest alternate can be found, and the series of alternates can be clustered into "no change" -->
   <!--rdf:RDF-->
   <xsl:value-of select="concat(
            '@prefix rdfs: &lt;http://www.w3.org/2000/01/rdf-schema#&gt; .',$NL
         )"/>

      <xsl:apply-templates select="//key[.='GraphicsList']/following-sibling::array[1]/dict" mode="turtle"/>
   <!--/rdf:RDF-->
</xsl:template>

<xsl:template match="dict" mode="turtle">
   <xsl:value-of select="concat($NL,
      '&lt;',g:value-of('ID',.),'&gt;',$NL,
      '   a &lt;',g:value-of('Class',.),'&gt;;',$NL,
      if (string-length(g:value-of('Shape',.))) 
         then concat('   a &lt;',g:value-of('Shape',.),'&gt;;',$NL) 
         else '',
      if (g:value-of('Text',.))
         then concat('   rdfs:label ',$DQ,xfm:rtf2txt(g:value-of('Text',g:value-of('Text',.))),$DQ,';',$NL) 
         else ''
   )"/>
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

</xsl:transform>
