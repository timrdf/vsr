<!--
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/blob/master/src/xsl/grddl/svg.xsl>;
#3>    prov:has_provenance   <https://raw.github.com/timrdf/vsr/master/src/xsl/grddl/svg.xsl.prov.ttl>;
#3>    prov:wasAttributedTo  <http://purl.org/twc/id/person/TimLebo>;
#3>    rdfs:seeAlso          <https://github.com/timrdf/csv2rdf4lod-automation/wiki/Scraping-HTML>,
#3>                          <https://github.com/timrdf/vsr/wiki/GRDDL>;
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
   xmlns:xlink="http://www.w3.org/1999/xlink"
   xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:sketch="http://www.bohemiancoding.com/sketch/ns"

   xmlns:pmm="edu.rpi.tw.string.pmm"
   xmlns:xfm="transform namespace"
   xmlns:sof="http://stackoverflow.com/questions/6753343/using-xsl-to-make-a-hash-of-xml-file"
   exclude-result-prefixes="g xfm">
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
            '@prefix prov:    &lt;http://www.w3.org/ns/prov#&gt; .',$NL,
            '@prefix sio:     &lt;http://semanticscience.org/resource/&gt; .',$NL,
            '@prefix vsr:     &lt;http://purl.org/twc/vocab/vsr#&gt; .',$NL,
            '@prefix svg:     &lt;http://purl.org/twc/vocab/vsr/svg#&gt; .',$NL
         )"/>
      
   <!-- https://github.com/timrdf/vsr/wiki/2grph.xsl#2svg
        places svg:metadata on each svg:g that it creates -->
   <xsl:apply-templates select="//svg:*[svg:metadata[*]]" mode="turtle"/>

   <!-- The following apply-templates is used in 
        https://github.com/timrdf/lodcloud/tree/master/data/source/us/the-living-lod-cloud

      e.g. http://lod-cloud.net/versions/2011-09-19/lod-cloud_colored.svg

      xmlns:svg="http://www.w3.org/2000/svg" 
      <svg:a id="dataset-gnoss" class="dataset usergeneratedcontent"
             xlink:href="http://thedatahub.org/dataset/gnoss"
             target="_blank"
             transform="translate(1047.3316495 529.0504495)">
         <svg:circle r="27"/>
         <svg:text class="label" x="0" y="3" font-size="10">gnoss</svg:text>
      </svg:a>
   -->

   <!-- The following apply-templates is used in
        source/ieeevis-tw-rpi-edu/IEEE-VAST-Challenge-2008-mc1-reverts-social-tally/version/2015-Apr-27/manual/downloaded-from-ieeevis-vm/against-and-supports.ttl.graffle.svg 

         <svg/g[title]/g[title]/rect[@x="2984.3554" @y="394.15198" @width="43" @height="18" @fill="white"]
         <svg/g[title]/g[title]/text[transform="translate(2986.3554 396.65198)" @fill="#b3b3b3"]/tspan[@font-family="Lucida Grande" @font-size="11" @font-weight="500" @fill="#b3b3b3"
                                                                                                       @x=".13183594" @y="11" @textLength="38.736328"]/text()
         <rect x="324.50133" y="899.6262" width="43" height="18" fill="white"/>
         <text transform="translate(326.50133 902.1262)" fill="#b3b3b3">
            <tspan font-family="Lucida Grande" font-size="11" font-weight="500" fill="#b3b3b3"
                   x=".13183594"
                   y="11"
                   textLength="38.736328">against</tspan>
         </text>

         <a xl:href="http://ieeevis.tw.rpi.edu/source/hcil-cs-umd-edu/dataset/IEEE-VAST-Challenge-2008-mc1/version/2014-Feb-21/user/Margaviota"
            xlink:type="simple"
            xlink:show="replace"
            xlink:actuate="onRequest">
            <rect x="2859.2508" y="394.16751" width="96" height="18" fill="white"/>
            <text transform="translate(2864.2508 396.66751)" fill="black">
               <tspan font-family="Lucida Grande" font-size="11" font-weight="500" x=".32666016"
                      y="11"
                      textLength="85.34668">user:Margaviota</tspan>
            </text>
         </a>
   -->
   <xsl:apply-templates select="//svg:a[svg:text]"                                   mode="turtle"/>
   <xsl:apply-templates select="//svg:text[html:text(.,' ') and not(parent::svg:a) and not(parent::svg:g/@sketch:type) and not(../parent::svg:g/@sketch:type)]" mode="turtle"/>
   <!--                                                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                                                                                              Added Jul 24 2016 b/c
      http://lod-cloud.net/versions/2014-08-30/lod-cloud_colored.svg triggers the rule above with:

       <g id="Group" transform="translate(4.000000, 27.000000)" font-size="30" font-family="sans-serif" fill="#000000" sketch:type="MSTextLayer" font-weight="normal">
           <text id="Linked-Datasets-as-of-August-2014">
               <tspan x="0.3712" y="29.4977">Linked Datasets as of August 2014</tspan>
           </text>
       </g>
   -->
   <xsl:apply-templates select="//svg:a[svg:line]"                                   mode="turtle"/>

   <!-- Used in https://github.com/timrdf/lodcloud/tree/master/data/source/lod-cloud-net/diagram/version/2014-08-30

      e.g. http://lod-cloud.net/versions/2014-08-30/lod-cloud_colored.svg
      line 17633

      <g id="y.node.225" style="filter:url(#filter199605)" transform="translate(2516.000000, 2255.000000)">
        <a target="_blank" xlink:type="simple" xlink:href="http://datahub.io/dataset/linkedfood" xlink:show="new">
          <g id="Group">
              <g id="Oval" fill="#EAF7F6" sketch:type="MSShapeGroup">
                  <circle cx="42.2871" cy="42.2871" r="42.2871"></circle>
              </g>
              <g transform="translate(13.000000, 21.000000)" font-size="18" font-family="sans-serif" fill="#000000" sketch:type="MSTextLayer" font-weight="normal">
                  <text id="Linked">
                      <tspan x="0.095" y="17.569">Linked</tspan>
                  </text>
                  <text id="Food">
                      <tspan x="7.4734" y="38.7682">Food</tspan>
                  </text>
              </g>
              <g id="Oval" stroke="#40584E" sketch:type="MSShapeGroup">
                  <circle cx="42.2871" cy="42.2871" r="42.2871"></circle>
              </g>
          </g>
       </a>
      </g>
   -->
   <xsl:apply-templates select="//svg:g[svg:a[@xlink:href and svg:g]]" mode="turtle"/>
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
      <xsl:variable name="value" select="@resource | @rdf:resource | text()[1]"/>
      <xsl:choose>
         <xsl:when test="starts-with($attr,'http:') and starts-with($value,'http:')">
            <xsl:for-each select="tokenize($value,'\s+')[starts-with(.,'http:')]">
               <xsl:value-of select="concat('   &lt;',$attr,'&gt; &lt;',.,'&gt;;',$NL)"/>
            </xsl:for-each>
         </xsl:when>
         <xsl:otherwise>
            <!--xsl:value-of select="concat('   &lt;',.,'&gt; ',$DQ,replace($value,$DQ,''),$DQ,';',$NL)"/-->
         </xsl:otherwise>
      </xsl:choose>
   </xsl:for-each>

   <xsl:value-of select="concat('.',$NL)"/>
</xsl:template>


<xsl:template match="svg:a[svg:line]" mode="turtle">
   <!--
         <a xl:href="http://ieeevis.tw.rpi.edu/source/ieeevis-tw-rpi-edu/dataset/IEEE-VAST-Challenge-2008-mc1-reverts-social-tally/vocab/qualifiedSupports"
            xlink:type="simple"
            xlink:show="replace"
            xlink:actuate="onRequest">
            <line x1="2814.75" y1="1289.4027" x2="2912.35" y2="1289.4027"
                  marker-end="url(#FilledArrow_Marker_2)"
                  stroke="green"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="1"/>
         </a>
   -->

   <xsl:variable name="number">
      <xsl:number select="." count="svg:*" level="any"/>
   </xsl:variable>

   <!-- if (@id) then sof:checksum(@id) else $number -->
   <xsl:value-of select="concat($NL,
      '&lt;graphic/',$number,'&gt;',$NL,
      '   a vsr:Graphic, svg:line;',$NL,
      if (@id) 
         then concat('   dcterms:identifier ',$DQ,@id,$DQ,';',$NL) 
         else '',
      if (@xlink:href) 
         then concat('   vsr:depicts ',$LT,@xlink:href,$GT,';',$NL) 
         else '',
      if (svg:line/@x1 and svg:line/@x2) 
         then concat('   vsr:todo ',$DQ,'model a line; just asserting double-x and double-y now.',$DQ,';',$NL,
                     '   vsr:x ',svg:line/@x1,', ',svg:line/@x2,';',$NL) 
         else '',
      if (svg:line/@y1 and svg:line/@y2) 
         then concat('   vsr:y ',svg:line/@y1,', ',svg:line/@y2,';',$NL) 
         else '',
      '.',$NL
   )"/>

</xsl:template>

<xsl:template match="svg:a[svg:text]" mode="turtle">

   <xsl:variable name="number">
      <xsl:number select="." count="svg:*" level="any"/>
   </xsl:variable>

   <!-- if (@id) then sof:checksum(@id) else $number -->
   <xsl:value-of select="concat($NL,
      '&lt;graphic/',$number,'&gt;',$NL,
      '   a vsr:Graphic, svg:',local-name((svg:circle | svg:g | svg:rect)[1]),';',$NL,
      if (@id) 
         then concat('   dcterms:identifier ',$DQ,@id,$DQ,';',$NL) 
         else '',
      if (@xlink:href) 
         then concat('   vsr:depicts ',$LT,@xlink:href,$GT,';',$NL) 
         else '',
      if (svg:text) 
         then concat('   rdfs:label ',$DQ,replace(html:text(svg:text,' '),'- ',''),$DQ,';',$NL) 
         else ''
   )"/>

   <!-- x and y -->
   <xsl:choose>
      <xsl:when test="svg:rect[@x and @y]"> <!-- Graffle's export -->
         <xsl:value-of select="concat('   vsr:x ',svg:rect/@x,';',$NL)"/>
         <xsl:value-of select="concat('   vsr:y ',svg:rect/@y,';',$NL)"/>
      </xsl:when>
      <xsl:when test="@transform[contains(.,'translate')]"> <!-- LOD cloud diagram -->
         <!-- transform="translate(1047.3316495 529.0504495)" -->
         <xsl:variable name="x" select="replace(@transform,'^[^0-9.]*([0-9.]+) *[^0-9.]*([0-9.]+).*$','$1')"/>
         <xsl:variable name="y" select="replace(@transform,'^[^0-9.]*([0-9.]+) *[^0-9.]*([0-9.]+).*$','$2')"/>
         <xsl:if test="string-length($x) and string-length($y)">
            <xsl:value-of select="concat('   vsr:x ',$x,';',$NL)"/>
            <xsl:value-of select="concat('   vsr:y ',$y,';',$NL)"/>
         </xsl:if>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
   </xsl:choose>

   <!-- height and width -->
   <xsl:choose>
      <xsl:when test="svg:rect[@height and @width]"> <!-- Graffle's export -->
         <xsl:value-of select="concat('   vsr:height ',svg:rect/@height,';',$NL)"/>
         <xsl:value-of select="concat('   vsr:width  ',svg:rect/@width,';',$NL)"/>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
   </xsl:choose>

   <!-- fill -->
   <xsl:choose>
      <xsl:when test="svg:rect[@fill]"> <!-- Graffle's export -->
         <xsl:value-of select="concat('   vsr:fill  &lt;',svg:rect/@fill,'&gt;;',$NL)"/> <!-- TODO: use http://purl.org/colors/css/red -->
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
   </xsl:choose>

   <!--xsl:for-each select="svg:text">
      <xsl:value-of select="concat('   rdfs:label ',$DQ,.,$DQ,';',$NL)"/>
   </xsl:for-each-->
   <!--
      if (key('value',key('id',$vsr:depicts),.)) 
         then concat('   vsr:depicts &lt;',key('value',key('id',$vsr:depicts),.),'&gt;;',$NL) 
         else ''
   -->

   <!--xsl:for-each select="svg:metadata/*">
      <xsl:variable name="attr"  select="xfm:uri(.)"/>
      <xsl:variable name="value" select="@resource | @rdf:resource | text()[1]"/>
      <xsl:choose>
         <xsl:when test="starts-with($attr,'http:') and starts-with($value,'http:')">
            <xsl:for-each select="tokenize($value,'\s+')[starts-with(.,'http:')]">
               <xsl:value-of select="concat('   &lt;',$attr,'&gt; &lt;',.,'&gt;;',$NL)"/>
            </xsl:for-each>
         </xsl:when>
         <xsl:otherwise>
            <!-xsl:value-of select="concat('   &lt;',.,'&gt; ',$DQ,replace($value,$DQ,''),$DQ,';',$NL)"/->
         </xsl:otherwise>
      </xsl:choose>
   </xsl:for-each-->

   <xsl:value-of select="concat('.',$NL)"/>

</xsl:template>

<xsl:template match="svg:text[@transform and svg:tspan]" mode="turtle">
   <!-- Graffle export -->
   <!--
         <text transform="translate(2276.0193 581.46974)" fill="#b3b3b3">
            <tspan font-family="Lucida Grande" font-size="11" font-weight="500" fill="#b3b3b3"
                   x=".13183594"
                   y="11"
                   textLength="38.736328">against</tspan>
         </text>
   -->
   <xsl:variable name="number">
      <xsl:number select="." count="svg:*" level="any"/>
   </xsl:variable>

   <xsl:value-of select="concat($NL,
      '&lt;graphic/',$number,'&gt;',$NL,
      '   a vsr:Graphic, svg:text;',$NL,
      if (html:text(.,' ')) 
         then concat('   rdfs:label ',$DQ,html:text(.,' '),$DQ,';',$NL) 
         else '',
      if (string-length(xfm:transform_xy(@transform)[1])) 
         then concat('   vsr:x ',xfm:transform_xy(@transform)[1],';',$NL) 
         else '',
      if (string-length(xfm:transform_xy(@transform)[2])) 
         then concat('   vsr:x ',xfm:transform_xy(@transform)[2],';',$NL) 
         else '',
      if (matches(@fill,'#[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]$')) 
         then concat('   vsr:fill &lt;http://purl.org/colors/rgb/',upper-case(replace(@fill,'^#','')),'&gt;;',$NL) 
         else '',
      '.',$NL
   )"/>
</xsl:template>

<xsl:template match="svg:g[svg:a[@xlink:href and svg:g]]" mode="turtle">
   <!-- Used in https://github.com/timrdf/lodcloud/tree/master/data/source/lod-cloud-net/diagram/version/2014-08-30

      e.g. http://lod-cloud.net/versions/2014-08-30/lod-cloud_colored.svg
      line 17633

      <g id="y.node.225" style="filter:url(#filter199605)" transform="translate(2516.000000, 2255.000000)">
        <a target="_blank" xlink:type="simple" xlink:href="http://datahub.io/dataset/linkedfood" xlink:show="new">
          <g id="Group">
              <g id="Oval" fill="#EAF7F6" sketch:type="MSShapeGroup">
                  <circle cx="42.2871" cy="42.2871" r="42.2871"></circle>
              </g>
              <g transform="translate(13.000000, 21.000000)" font-size="18" font-family="sans-serif" fill="#000000" sketch:type="MSTextLayer" font-weight="normal">
                  <text id="Linked">
                      <tspan x="0.095" y="17.569">Linked</tspan>
                  </text>
                  <text id="Food">
                      <tspan x="7.4734" y="38.7682">Food</tspan>
                  </text>
              </g>
              <g id="Oval" stroke="#40584E" sketch:type="MSShapeGroup">
                  <circle cx="42.2871" cy="42.2871" r="42.2871"></circle>
              </g>
          </g>
       </a>
      </g>
   -->
   <xsl:variable name="rs"      select=".//svg:circle[@r]/@r"/>
   <xsl:variable name="fills"   select=".//svg:g[matches(@fill,  '#[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]$')]/@fill"/>
   <xsl:variable name="strokes" select=".//svg:g[matches(@stroke,$HEX)]/@stroke"/>
   <xsl:value-of select="concat($NL,
      '&lt;graphic/',replace(@id,'^y.node.',''),'&gt;',$NL,
      '   a vsr:Graphic;',$NL,
      if (html:text(.,' ')) 
         then concat('   vsr:depicts ',$LT,svg:a/@xlink:href,$GT,';',$NL)
         else '',
      if (html:text(.,' ')) 
         then concat('   rdfs:label ',$DQ,html:text(.,' '),$DQ,';',$NL) 
         else '',
      if (string-length(xfm:transform_xy(@transform)[1])) 
         then concat('   vsr:x ',xfm:transform_xy(@transform)[1],';',$NL) 
         else '',
      if (string-length(xfm:transform_xy(@transform)[2])) 
         then concat('   vsr:y ',xfm:transform_xy(@transform)[2],';',$NL) 
         else '',
      if ($rs) 
         then concat('   vsr:height ',2 * $rs[1],';',$NL,
                     '   vsr:width  ',2 * $rs[1],';',$NL) 
         else '',
      if ($fills) 
         then concat('   vsr:fill   &lt;http://purl.org/colors/rgb/',upper-case(replace($fills[1],'^#','')),'&gt;;',$NL) 
         else '',
      if ($strokes) 
         then concat('   vsr:stroke &lt;http://purl.org/colors/rgb/',upper-case(replace($strokes[1],'^#','')),'&gt;;',$NL) 
         else '',
      '.',$NL
   )"/>
</xsl:template>


<xsl:variable name="NL" select="'&#xa;'"/>
<xsl:variable name="DQ">"</xsl:variable>
<xsl:variable name="LT">&lt;</xsl:variable>
<xsl:variable name="GT">&gt;</xsl:variable>
<xsl:variable name="HEX" select="'#[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]$'"/>

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

<xsl:function name="xfm:transform_xy">
   <xsl:param name="transform"/>
   <xsl:sequence select="(replace($transform,'^[^0-9.]*([0-9.]+) *[^0-9.]*([0-9.]+).*$','$1'), 
                          replace($transform,'^[^0-9.]*([0-9.]+) *[^0-9.]*([0-9.]+).*$','$2'))"/>
</xsl:function>

<xsl:function name="html:text">
   <xsl:param name="node"/>
   <xsl:param name="delim"/>
   <xsl:variable name="together">
      <xsl:for-each select="$node//text()">
         <xsl:value-of select="concat(normalize-space(.),$delim)"/>
      </xsl:for-each>
   </xsl:variable>
   <xsl:value-of select="normalize-space($together)"/>
</xsl:function>


</xsl:transform>
