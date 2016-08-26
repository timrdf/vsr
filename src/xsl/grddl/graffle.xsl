<!--
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/blob/master/src/xsl/grddl/graffle.xsl>;
#3>    prov:has_provenance   <https://raw.github.com/timrdf/vsr/master/src/xsl/grddl/graffle.xsl.prov.ttl>;
#3>    prov:wasAttributedTo  <http://purl.org/twc/id/person/TimLebo>;
#3>    rdfs:seeAlso          <https://github.com/timrdf/vsr/wiki/GRDDL>;
#3> .

   xsl:templates in this script:

      match="/"
      match="dict" mode="turtle"
      match="dict" mode="layer"
      match="@*|node()"

   xsl:functions in this script:

      xfm:rtf2txt
      g:value-of
      xfm:isURI
      sof:checksum
      sof:fletcher16
      g:percentRGB2hex
      g:percent2_0_255
      msg20090200215:int-to-hex
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
   xmlns:msg20090200215="http://www.oxygenxml.com/archives/xsl-list/200902/msg00215.html"
   exclude-result-prefixes="g xfm">
<!--xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/-->
<xsl:output method="text"/>

<!--xsl:include href="../util/rtf-function.xsl"/-->
<xd:doc>
   <xd:short>Strip RTF to get the textual message.</xd:short>
   <xd:detail> e.g. 'Firstly: Do some thing. Secondly: Do another thing.' from:

                  {\rtf1\ansi\ansicpg1252\cocoartf1348\cocoasubrtf170
                  {\fonttbl\f0\fnil\fcharset0 Georgia;}
                  {\colortbl;\red255\green255\blue255;}
                  \pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural

                  \f0\b\fs32 \cf0 \expnd0\expndtw0\kerning0
                  Firstly:
                  \b0 \expnd0\expndtw0\kerning0
                  Do some thing.
                  \b \expnd0\expndtw0\kerning0
                  Secondly:
                  \b0 \expnd0\expndtw0\kerning0
                   Do another thing.}



         <string>{\rtf1\ansi\ansicpg1252\cocoartf949\cocoasubrtf430{\fonttbl\f0\fnil\fcharset0 LucidaGrande;}{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\qc\pardirnatural\f0\fs22 \cf2  WebView}</string>

   </xd:detail>
   <xd:param name="rtf">A Rich Text Formatted string from which to extract the string message.</xd:param>
</xd:doc>
<xsl:function name="xfm:rtf2txt">
   <xsl:param name="rtf"/>
   <!-- This assumed that there were no spaces in the content string encoded within the RTF. -->
   <!--xsl:value-of select="replace(replace(replace($rtf,'^.* ','','s'),'.$',''),$NL,'')"/--> <!-- dot-all mode, see http://www.w3.org/TR/xpath-functions/#flags -->
   <!--xsl:value-of select="replace(replace($rtf,'^.*\\[a-z0-9]+ ?','','s'),'\}$','')"/-->
   <!-- http://stackoverflow.com/questions/188545/regular-expression-for-extracting-text-from-an-rtf-string -->
   <xsl:variable name="most" select="replace(replace(replace(replace(replace($rtf,
                                                                 '^\{',      ''),
                                                         '\s?\\[A-Za-z0-9]+','','s'),
                                                 '\{.*\}',''),
                                         $NL,                        ''),
                                 '\}\s*$',                           '')"/>
   <!--xsl:message select="concat('extracted ',$most,' from:',$rtf)"/-->
   <xsl:choose>
      <xsl:when test="string-length($most) gt 2">
         <xsl:value-of select="replace($most,'^ ','')"/>
      </xsl:when>
      <xsl:otherwise>
         <!-- hack to chew the output from https://github.com/timrdf/vsr/blob/master/src/xsl/to/graffle.xsl#L373 -->
         <xsl:value-of select="replace(replace($rtf,'^.*\\cf2  ',''),'\}$','')"/>
      </xsl:otherwise>
   </xsl:choose>
</xsl:function>

<!--
   Index the <dict> "graphic" by its <key>ID</key> == its following <integer> so that the other
   attributes (e.g. <key>Bounds</key>) can be easily accessed.
-->
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
   <xsl:value-of select="concat(
            '@prefix rdfs:    &lt;http://www.w3.org/2000/01/rdf-schema#&gt; .',$NL,
            '@prefix owl:     &lt;http://www.w3.org/2002/07/owl#&gt; .',$NL,
            '@prefix dcterms: &lt;http://purl.org/dc/terms/&gt; .',$NL,
            '@prefix foaf:    &lt;http://xmlns.com/foaf/0.1/&gt; .',$NL,
            '@prefix prov:    &lt;http://www.w3.org/ns/prov#&gt; .',$NL,
            '@prefix vsr:     &lt;http://purl.org/twc/vocab/vsr#&gt; .',$NL,
            '@prefix graffle: &lt;http://purl.org/twc/vocab/vsr/graffle#&gt; .',$NL,
            '@prefix dbpo:    &lt;http://dbpedia.org/ontology/&gt; .',$NL,
            '@prefix dbpp:    &lt;http://dbpedia.org/property/&gt; .',$NL,
            '@prefix cv:      &lt;http://ontologi.es/colour/vocab#&gt; .',$NL,
            '@prefix colour:  &lt;http://data.colourphon.co.uk/def/colour-ontology#&gt; .',$NL
         )"/>

   <!-- 
      List all of the colors mentioned within the entire document.
   -->
   <!--xsl:value-of select="concat('COUNT ',count(//key[.='Color']/following-sibling::dict),$NL)"/-->
   <xsl:for-each-group select="//key[.='Color']/following-sibling::dict" group-by="g:value-of('r',.)">
      <!--xsl:value-of select="concat('   R COUNT ',current-grouping-key(),' : ',count(current-group()),$NL)"/-->
      <xsl:for-each-group select="current-group()" group-by="g:value-of('g',.)">
         <!--xsl:value-of select="concat('       G COUNT ',current-grouping-key(),' : ',count(current-group()),$NL)"/-->
         <xsl:for-each-group select="current-group()" group-by="g:value-of('b',.)">
            <xsl:variable name="rx" select="g:percentRGB2hex(g:value-of('r',current-group()[1]))"/>
            <xsl:variable name="gx" select="g:percentRGB2hex(g:value-of('g',current-group()[1]))"/>
            <xsl:variable name="bx" select="g:percentRGB2hex(g:value-of('b',current-group()[1]))"/>
            <xsl:variable name="ax" select="g:percentRGB2hex(g:value-of('a',current-group()[1]))"/>
            <xsl:variable name="r"  select="g:percent2_0_255(g:value-of('r',current-group()[1]))"/>
            <xsl:variable name="g"  select="g:percent2_0_255(g:value-of('g',current-group()[1]))"/>
            <xsl:variable name="b"  select="g:percent2_0_255(g:value-of('b',current-group()[1]))"/>
            <xsl:variable name="a"  select="g:percent2_0_255(g:value-of('a',current-group()[1]))"/>
            <xsl:variable name="r1" select="g:value-of('r',current-group()[1])"/>
            <xsl:variable name="g1" select="g:value-of('g',current-group()[1])"/>
            <xsl:variable name="b1" select="g:value-of('b',current-group()[1])"/>
            <xsl:variable name="a1" select="g:value-of('a',current-group()[1])"/>
            <xsl:if test="$r and $g and $b">
               <xsl:value-of select="concat($NL,
                  '&lt;http://purl.org/colors/rgb/',$rx,$gx,$bx,'&gt;',$NL,
                  '  a dbpo:Colour, vsr:Color, vsr:Graphic;',$NL,
                  '  dbpp:hex    ',$DQ,$rx,$gx,$bx,$DQ,';',$NL,
                  '  cv:hex_code ',$DQ,$rx,$gx,$bx,$DQ,';',$NL,
                  '  dbpp:rgbCoordinateRed   ',$DQ,$r,$DQ,';',$NL,
                  '  dbpp:rgbCoordinateGreen ',$DQ,$g,$DQ,';',$NL,
                  '  dbpp:rgbCoordinateBlue  ',$DQ,$b,$DQ,';',$NL,
                  '  colour:red   ',$DQ,$r,$DQ,';',$NL,
                  '  colour:green ',$DQ,$g,$DQ,';',$NL,
                  '  colour:blue  ',$DQ,$b,$DQ,';',$NL,
                  '  vsr:rgb  ',$DQ,$r1,' ',$g1,' ',$b1,$DQ,';',$NL,
                  '  owl:sameAs &lt;http://ontologi.es/colour/',$rx,$gx,$bx,'&gt;;',$NL,
                  '.',$NL)"/>
                   <!--'     &lt;http://data.colourphon.co.uk/id/colour/',$rx,$gx,$bx,'&gt;, ',$NL,-->
            </xsl:if>
         </xsl:for-each-group>
      </xsl:for-each-group>
   </xsl:for-each-group>

   <!--
      Graphics that are *not* grouped appear directly under:

      <key>GraphicsList</key>
      <array>
        <dict>
          <key>Bounds</key>
          <string>{{0, 0}, {10, 10}}</string>
          <key>Class</key>
          <string>ShapedGraphic</string>


      Graphics that *are* grouped appear one level deeper:

         <dict>
            <key>Class</key>
            <string>Group</string>
            <key>Graphics</key>
            <array>
               <dict>
                  <key>Bounds</key>
                  <string>{{1709.125, 417.52705879661335}, {77, 18}}</string>
                  <key>Class</key>
                  <string>ShapedGraphic</string>
                  <key>FitText</key>
                  <string>YES</string>
                  <key>Flow</key>
                  <string>Resize</string>
                  <key>ID</key>
                  <integer>1306</integer>
   -->
   <!--xsl:apply-templates select="//key[.='GraphicsList']/following-sibling::array[1]/dict" mode="turtle"/> was used before handling grouping -->
   <xsl:apply-templates select="//dict[g:value-of('Class',.) = 'ShapedGraphic']"    mode="turtle"/> <!-- Added to handle grouped graphics Oct 2014 -->
   <xsl:apply-templates select="//key[.='Layers']/following-sibling::array[1]/dict" mode="layer"/>  <!-- Added to handle layers           Apr 2015 -->
   <xsl:apply-templates select="//dict[g:value-of('Class',.) = 'LineGraphic']"      mode="turtle"/> <!-- Added to handle grouped graphics Oct 2014 -->
</xsl:template>

<xsl:template match="dict" mode="turtle">
   <!--
         <dict>
         <key>Bounds</key>
         <string>{{2474.5614858691711, 2260.4238326323234}, {66, 34}}</string>
         <key>Class</key>
         <string>ShapedGraphic</string>
         <key>FontInfo</key>
         <dict>
            <key>Font</key>
            <string>LucidaGrande</string>
            <key>Size</key>
            <real>24</real>
         </dict>
         <key>ID</key>
         <integer>1765</integer>
   -->
   <xsl:variable name="graphic" select="g:value-of('ID',.)"/>
   <!--xsl:message select="concat('The RTF value:', $NL,g:value-of('Text',g:value-of('Text',.)),$NL,' became: ',$NL, xfm:rtf2txt(g:value-of('Text',g:value-of('Text',.))) )"/-->

   <xsl:value-of select="concat($NL,
      '&lt;',$graphic,'&gt;',$NL,
      '   a vsr:Graphic, graffle:',g:value-of('Class',.),';',$NL,
      if (string-length(g:value-of('Shape',.))) 
         then concat('   a graffle:',g:value-of('Shape',.),';',$NL) 
         else '',
      if (g:value-of('Name',.))
         then concat('   foaf:name ',$DQ,replace(g:value-of('Name',.),'\\','\\\\'),$DQ,';',$NL) 
         else '',
      if (g:value-of('Text',.))
         then concat('   rdfs:label ',$DQ,$DQ,$DQ,replace(xfm:rtf2txt(g:value-of('Text',g:value-of('Text',.))),'\\','\\\\'),$DQ,$DQ,$DQ,';',$NL) 
         else '',
      if (g:value-of('Link',.))
         then concat('   rdfs:seeAlso &lt;',g:value-of('url',g:value-of('Link',.)),'&gt;;',$NL) 
         else ''
   )"/>

   <xsl:variable name="rgb" select="
      if(                                        g:value-of('Style',.)  and 
                              g:value-of('fill', g:value-of('Style',.)) and
          g:value-of('Color', g:value-of('fill', g:value-of('Style',.)))
        )
         then concat( g:value-of('r',g:value-of('Color',g:value-of('fill',g:value-of('Style',.)))),' ',
                      g:value-of('g',g:value-of('Color',g:value-of('fill',g:value-of('Style',.)))),' ',
                      g:value-of('b',g:value-of('Color',g:value-of('fill',g:value-of('Style',.)))),
                      if (g:value-of('a',g:value-of('Color',g:value-of('fill',g:value-of('Style',.))))) 
                      then concat(' ',g:value-of('a',g:value-of('Color',g:value-of('fill',g:value-of('Style',.))))) else ''
                    ) 
         else ''"/>
   <xsl:if test="string-length($rgb)">
      <xsl:variable name="rx" select="g:percentRGB2hex(g:value-of('r',g:value-of('Color',g:value-of('fill',g:value-of('Style',.)))))"/>
      <xsl:variable name="gx" select="g:percentRGB2hex(g:value-of('g',g:value-of('Color',g:value-of('fill',g:value-of('Style',.)))))"/>
      <xsl:variable name="bx" select="g:percentRGB2hex(g:value-of('b',g:value-of('Color',g:value-of('fill',g:value-of('Style',.)))))"/>
      <xsl:variable name="ax" select="g:percentRGB2hex(g:value-of('a',g:value-of('Color',g:value-of('fill',g:value-of('Style',.)))))"/>
      <xsl:value-of select="concat('   vsr:fill &lt;http://purl.org/colors/rgb/',$rx,$gx,$bx,'&gt;;',$NL)"/>
   </xsl:if>

   <!--
         <dict>
            <key>Bounds</key>
            <string>{{67.5, 421.00800000000072}, {72, 30}}</string>
            <key>Class</key>
            <string>ShapedGraphic</string>
   -->
   <xsl:variable name="bounds" select="tokenize(translate(g:value-of('Bounds',.),',{}',''),' ')"/>
   <xsl:value-of select="
      if (count($bounds) = 4) 
         then concat('   vsr:x      ',$bounds[1],';',$NL,
                     '   vsr:y      ',$bounds[2],';',$NL,
                     '   vsr:width  ',$bounds[3],';',$NL,
                     '   vsr:height ',$bounds[4],';',$NL)
         else ''
   "/>

   <!--
         rgb: 200, 20, 2
         hex: C81402

         <key>Style</key>
         <dict>
            <key>shadow</key>
            <dict>
               <key>Draws</key>
               <string>NO</string>
            </dict>
            <key>stroke</key>
            <dict>
               <key>Color</key>
               <dict>
                  <key>b</key>
                  <string>0.00784314</string>
                  <key>g</key>
                  <string>0.0784314</string>
                  <key>r</key>
                  <string>0.784314</string>
               </dict>
               <key>HeadArrow</key>
               <string>0</string>
               <key>Legacy</key>
               <true/>
               <key>LineType</key>
               <integer>1</integer>
               <key>TailArrow</key>
               <string>FilledArrow</string>
               <key>Width</key>
               <real>4</real>
            </dict>
         </dict>
   -->
   <xsl:for-each select="g:value-of('Style',.)/key">
      <!-- e.g. keys : shadow, stroke, fill -->
      <xsl:if test="not(. = 'fill')">
         <xsl:value-of select="concat('   vsr:',.,' &lt;',$graphic,'/',.,'&gt;;',$NL)"/>
      </xsl:if>
   </xsl:for-each>

   <xsl:for-each select="g:value-of('UserInfo',.)/key">
      <!-- e.g. keys :
         vid_given
      -->
      <xsl:variable name="value" select="./following-sibling::*[1]"/>
      <xsl:choose>
         <xsl:when test="xfm:isURI($value)">
            <!-- Multi-URI values that are delimited with ', ' need to become '>, <', e.g. curieTypeList's value:
                 http://ieeevis.tw.rpi.edu/.../vocab/Commit, http://ieeevis.tw.rpi.edu/../vocab/Minor -->
            <xsl:value-of select="concat('   &lt;',.,'&gt; &lt;',replace($value,', http','&gt;, &lt;http'),'&gt;;',$NL)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="concat('   &lt;',.,'&gt; ',$DQ,replace($value,$DQ,''),$DQ,';',$NL)"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:for-each>

   <!-- 
         - - - 5 - - >
                     | 51.52
                    \x/
         - - - - - - - - - - - 103.5 - - - - - - > 
                                                 | 436.08
                                                \x/
         <key>Points</key>
         <array>
            <string>{5, 51.523809523808495}</string>
            <string>{103.5, 436.00800000000072}</string>
         </array>
   -->
   <xsl:if test="g:value-of('Points',.)/string">
      <xsl:for-each select="g:value-of('Points',.)/string">
         <xsl:variable name="points" select="tokenize(translate(.,',{}',''),' ')"/>
         <xsl:value-of select="concat('   vsr:point ',$DQ,$points[1],' ',$points[2],$DQ,';',$NL)"/>
      </xsl:for-each>
   </xsl:if>

   <!--
         <key>ID</key>
         <integer>1765</integer>
         <key>Line</key>
         <dict>
            <key>ID</key>
            <integer>1764</integer>
            <key>Position</key>
            <real>0.54379593861090036</real>
            <key>RotationType</key>
            <integer>0</integer>
         </dict>
   -->
   <xsl:if test="g:value-of('Line',.)">
      <xsl:value-of select="concat('   foaf:based_near &lt;',g:value-of('ID',g:value-of('Line',.)),'&gt;;',$NL)"/>
   </xsl:if>

   <!--
       <key>GraphicsList</key>
       <array>
          <dict>
             <key>Bounds</key>
             <string>{{31.625, 548.47413487900235}, {238, 41}}</string>
             <key>Class</key>
             <string>ShapedGraphic</string>
             <key>Layer</key>
             <integer>3</integer>
           ...
       </array>
       ...
       <key>Layers</key>
       <array>
          <dict>
             <key>Lock</key>
             <string>NO</string>
             <key>Name</key>
             <string>equiv</string>
             <key>Print</key>
             <string>YES</string>
             <key>View</key>
             <string>NO</string>
          </dict>
          <dict>
             <key>Lock</key>
             <string>NO</string>
             <key>Name</key>
             <string>restriction</string>
          ...
       </array>
       ...
   -->
   <xsl:variable name="layer" select="g:value-of('Layer',.)"/>
   <xsl:if test="string-length($layer)">
      <xsl:value-of select="concat('   dcterms:isPartOf &lt;layer/',$layer,'&gt;;',$NL)"/>
   </xsl:if>

   <!--
         <dict>
         <key>AllowLabelDrop</key>
         <false/>
         <key>Class</key>
         <string>LineGraphic</string>
         <key>Head</key>
         <dict>
            <key>ID</key>
            <integer>1762</integer>
         </dict>
         <key>ID</key>
         <integer>1764</integer>
         ...
         <key>Tail</key>
         <dict>
            <key>ID</key>
            <integer>1007</integer>
         </dict>
   -->
   <xsl:if test="g:value-of('Head',.) and g:value-of('ID',g:value-of('Head',.))">
      <!-- a.k.a "to" -->
      <xsl:value-of select="concat('   a vsr:Connection;',$NL)"/>
      <xsl:value-of select="concat('   prov:entity &lt;',g:value-of('ID',g:value-of('Head',.)),'&gt;;',$NL)"/>
   </xsl:if>

   <xsl:value-of select="concat('.',$NL)"/> 
   <!-- End of vsr:Graphic -->

   <!--
         rgb % of 255:   0.00784314,  0.0784314, 0.784314
         rgb         : 200,          20,         2
         hex         :  C8           14         02

         <key>Style</key>
         <dict>
            <key>shadow</key>
            <dict>
               <key>Draws</key>
               <string>NO</string>
            </dict>
            <key>stroke</key>
            <dict>
               <key>Color</key>
               <dict>
                  <key>b</key>
                  <string>0.00784314</string>
                  <key>g</key>
                  <string>0.0784314</string>
                  <key>r</key>
                  <string>0.784314</string>
               </dict>
               <key>HeadArrow</key>
               <string>0</string>
               <key>Legacy</key>
               <true/>
               <key>LineType</key>
               <integer>1</integer>
               <key>TailArrow</key>
               <string>FilledArrow</string>
               <key>Width</key>
               <real>4</real>
            </dict>
         </dict>
   -->
   <xsl:for-each select="g:value-of('Style',.)/key">
      <!-- ^^ e.g. keys : shadow, stroke, fill -->

      <xsl:if test="not(. = 'fill')">
      
         <xsl:variable name="value" select="g:value-of(., ..)"/>
         <!-- ^^ e.g. Draws, Color, Width, LineType, Pattern, TailArrow -->

         <xsl:value-of select="concat('&lt;',$graphic,'/',.,'&gt;',$NL,
                                      '   a vsr:',upper-case(substring(.,1,1)),substring(., 2),', vsr:Graphic;',$NL)"/>

         <xsl:if test="g:value-of('Draws',$value) = 'NO'">
            <xsl:value-of select="concat('   a vsr:Invisible;',$NL)"/>
         </xsl:if>

         <xsl:if test="g:value-of('TailArrow',$value)">
            <xsl:variable name="head" select="g:value-of('TailArrow',$value)"/>
            <xsl:if test="not( '0' = g:value-of('TailArrow',$value))">
               <xsl:value-of select="concat('   vsr:tail graffle:',upper-case(substring($head,1,1)),substring($head, 2),';',$NL)"/>
            </xsl:if>
         </xsl:if>

         <xsl:if test="g:value-of('Color',$value)">
            <xsl:variable name="r" select="g:percentRGB2hex(g:value-of('r',g:value-of('Color',$value)))"/>
            <xsl:variable name="g" select="g:percentRGB2hex(g:value-of('g',g:value-of('Color',$value)))"/>
            <xsl:variable name="b" select="g:percentRGB2hex(g:value-of('b',g:value-of('Color',$value)))"/>
            <xsl:variable name="a" select="g:percentRGB2hex(g:value-of('a',g:value-of('Color',$value)))"/>
            <xsl:if test="$r and $g and $b">
               <xsl:value-of select="concat('   vsr:fill &lt;http://purl.org/colors/rgb/',$r,$g,$b,'&gt;;',$NL)"/>
            </xsl:if>
         </xsl:if>

         <xsl:if test="g:value-of('Width',$value)">
            <xsl:value-of select="concat('   vsr:width ',g:value-of('Width',$value),';',$NL)"/>
         </xsl:if>

         <xsl:if test="g:value-of('HeadArrow',$value)">
            <xsl:variable name="head" select="g:value-of('HeadArrow',$value)"/>
            <xsl:value-of select="concat('   vsr:head graffle:',upper-case(substring($head,1,1)),substring($head, 2),';',$NL)"/>
         </xsl:if>

         <!-- Punt -->
         <xsl:if test="not(g:value-of('Color',$value) | g:value-of('Width',$value) | g:value-of('Draws',$value))">
            <xsl:value-of select="concat('   vsr:todo &lt;',$value/key[1],'&gt;;',$NL)"/>
         </xsl:if>
         <xsl:value-of select="concat('.',$NL)"/>
         <!-- end of Styles -->

      </xsl:if>

   </xsl:for-each>

   <xsl:if test="g:value-of('Tail',.) and g:value-of('ID',g:value-of('Tail',.))">
      <!-- a.k.a "from" -->
      <xsl:value-of select="concat('&lt;',g:value-of('ID',g:value-of('Tail',.)),'&gt;',$NL)"/>
      <xsl:value-of select="concat('   a vsr:Graphic;',$NL)"/>
      <xsl:value-of select="concat('   vsr:qualifiedConnection &lt;',g:value-of('ID',.),'&gt;;',$NL)"/>
      <xsl:value-of select="concat('.',$NL)"/> 
   </xsl:if>

   <!--xsl:if test="string-length($rgb)">
      <xsl:value-of select="concat($NL,'&lt;color/',sof:checksum($rgb),'&gt; a vsr:Color; vsr:rgb ',$DQ,$rgb,$DQ,' .',$NL)"/>
   </xsl:if-->

</xsl:template>

<xsl:template match="dict" mode="layer">
   <!--
     <dict>
        <key>Lock</key>
           <string>NO</string>
           <key>Name</key>
           <string>equiv</string>
           <key>Print</key>
           <string>YES</string>
           <key>View</key>
           <string>NO</string>
        </dict>
   -->
   <!--
         then concat('   rdfs:label ',$DQ,replace(xfm:rtf2txt(g:value-of('Name',g:value-of('Name',.))),'\\','\\\\'),$DQ,';',$NL) 
   -->
   <xsl:value-of select="concat($NL,
      '&lt;layer/',position() - 1,'&gt;',$NL,
      '   a vsr:Graphic, graffle:Layer;',$NL,
      if( 'YES' = g:value-of('Lock',.) ) 
         then concat('   a graffle:Locked;',  $NL) 
         else concat('   a graffle:Unlocked;',$NL),
      if( string-length(g:value-of('Name',.)) )
         then concat('   rdfs:label ',$DQ,replace(g:value-of('Name',.),$DQ,concat('\\',$DQ)),$DQ,';',$NL) 
         else '',
      if( 'NO' = g:value-of('View',.) )
         then concat('   a graffle:Invisible;', $NL) 
         else concat('   a graffle:Visible;',   $NL),
      '.',$NL
   )"/>
</xsl:template>

<xsl:template match="@*|node()">
  <xsl:copy>
      <xsl:copy-of select="@*"/>   
      <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:variable name="NL" select="'&#xa;'"/>
<xsl:variable name="DQ">"</xsl:variable>

<xsl:function name="xfm:isURI" as="xs:boolean">
   <xsl:param name="str" as="xs:string"/>
   <xsl:variable name="codepoints" select="string-to-codepoints($str)"/>
   <xsl:sequence select="(starts-with($str,'http:') or starts-with($str,'https:')) and not(matches($str,'^http.*http:'))"/>
</xsl:function>

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

<xsl:function name="g:percentRGB2hex" as="xs:string">
   <xsl:param name="percentage"/> <!-- as="xs:double"/-->
   <xsl:variable name="hex" select="msg20090200215:int-to-hex(xs:integer(floor($percentage * 255)))"/>
   <xsl:value-of select="if( string-length($hex) lt 2 ) then concat('0',$hex) else $hex"/>
</xsl:function>

<xsl:function name="g:percent2_0_255" as="xs:string">
   <xsl:param name="percentage"/> <!-- as="xs:double"/-->
   <xsl:variable name="dec" select="xs:integer(floor($percentage * 255))"/>
   <xsl:value-of select="$dec"/>
</xsl:function>

<!--
#3> <> prov:wasDerivedFrom [ prov:wasQuotedFrom <http://www.oxygenxml.com/archives/xsl-list/200902/msg00215.html> ] .
-->
<xsl:function name="msg20090200215:int-to-hex" as="xs:string">
  <xsl:param name="in" as="xs:integer"/>
  <xsl:sequence
    select="if ($in eq 0)
            then '0'
            else
              concat(if ($in gt 16)
                     then msg20090200215:int-to-hex($in idiv 16)
                     else '',
                     substring('0123456789ABCDEF',
                               ($in mod 16) + 1, 1))"/>
</xsl:function>
</xsl:transform>
