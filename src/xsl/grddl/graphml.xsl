<!--
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/blob/master/src/xsl/grddl/graphml.xsl>;
#3>    prov:has_provenance   <https://raw.github.com/timrdf/vsr/master/src/xsl/grddl/graphml.xsl.prov.ttl>;
#3>    prov:wasAttributedTo  <http://purl.org/twc/id/person/TimLebo>;
#3>    rdfs:seeAlso <http://graphml.graphdrawing.org/>;
#3> .
-->
<xsl:transform version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"

   xmlns:vsr="http://purl.org/twc/vocab/vsr#"

   xmlns:g="https://raw.github.com/timrdf/vsr/master/src/xsl/grddl/graphml.xsl#"
   xmlns:graphml="http://graphml.graphdrawing.org/xmlns/graphml"
   xmlns:y="http://www.yworks.com/xml/graphml"

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

<xsl:key name="graphic" match="graphml:node | graphml:edge" use="@id"/>

<!-- See http://graphml.graphdrawing.org/primer/graphml-primer.html#Attributes -->

<xsl:key name="attr" match="graphml:key/@attr.name" use="../@id"/>
<xsl:key name="id"   match="graphml:key/@id"        use="../@attr.name"/>
   <!--                                 .- - - input
                                        \/
      <key id="d6" for="node" attr.name="http://purl.org/twc/vocab/vsr#depicts" attr.type="string"/>
      ...
      <node>
         <data key="d6">http://foo.org/source/epa-gov/dataset/aqs/version/2013-Feb-05/site/45</data>
      </node>
                        ^^ - - - output                                                        -->
<xsl:key name="value" match="graphml:data"          use="@key"/>


<!--                                  .- - - input
                                     \/
<key id="d0" for="node" yfiles.type="nodegraphics"/>
...
<node id="n000009">
   <data key="d0">
      <ShapeNode>           < - - - - - - - - - - - - - - - - - - output
         <y:Geometry x="0.0" y="0.0" width="250" height="100"/>
-->
<xsl:key name="yid"   match="graphml:key/@id"       use="../@yfiles.type"/>


<xsl:template match="/">
   <!-- TODO: use the modification date to create alternates of those that were minted during the visualization process.
      the latest alternate can be found, and the series of alternates can be clustered into "no change" -->
   <xsl:value-of select="concat(
            '@prefix rdfs:    &lt;http://www.w3.org/2000/01/rdf-schema#&gt; .',$NL,
            '@prefix dcterms: &lt;http://purl.org/dc/terms/&gt; .',$NL,
            '@prefix sio:     &lt;http://semanticscience.org/resource/&gt; .',$NL,
            '@prefix vsr:     &lt;http://purl.org/twc/vocab/vsr#&gt; .',$NL,
            '@prefix graphml: &lt;http://purl.org/twc/vocab/vsr/graphml#&gt; .',$NL
         )"/>

      <xsl:apply-templates select="//(graphml:node | graphml:edge)" mode="turtle"/>
</xsl:template>

<xsl:template match="graphml:node | graphml:edge" mode="turtle">

   <xsl:variable name="edge" select="if (name(.) = 'edge') then 'edge/' else ''"/>
   <xsl:value-of select="concat($NL,
      '&lt;graphic/',$edge,sof:checksum(@id),'&gt;',$NL,
      '   a vsr:Graphic, graphml:',name(.),';',$NL,
      if (@id) 
         then concat('   dcterms:identifier ',$DQ,@id,$DQ,';',$NL) 
         else ''
   )"/>
   <!--
      if (key('value',key('id',$vsr:depicts),.)) 
         then concat('   vsr:depicts &lt;',key('value',key('id',$vsr:depicts),.),'&gt;;',$NL) 
         else ''
   -->

   <xsl:for-each select="graphml:data">
      <xsl:variable name="attr"  select="key('attr',@key)"/>
      <xsl:variable name="value" select="text()[1]"/>
      <xsl:choose>
         <xsl:when test="starts-with($attr,'http:') and starts-with($value,'http:')">
            <xsl:value-of select="concat('   &lt;',$attr,'&gt; &lt;',$value,'&gt;;',$NL)"/>
         </xsl:when>
         <xsl:otherwise>
            <!--xsl:value-of select="concat('   &lt;',.,'&gt; ',$DQ,replace($value,$DQ,''),$DQ,';',$NL)"/-->
         </xsl:otherwise>
      </xsl:choose>
   </xsl:for-each>

   <xsl:apply-templates select="key('value',key('yid','nodegraphics'),.)/y:ShapeNode"/>

   <xsl:value-of select="concat('.',$NL)"/>

   <xsl:apply-templates select="key('value',key('yid','nodegraphics'),.)/y:ShapeNode">
      <xsl:with-param name="objects" select="true()" tunnel="yes"/>
   </xsl:apply-templates>

   <xsl:if test="@source and @target">
      <xsl:value-of select="concat(
         '&lt;graphic/',sof:checksum(@source),'&gt;',$NL,
         '   vsr:relatesTo &lt;',sof:checksum(@target),'&gt;;',$NL
      )"/>
      <xsl:if test="@id">
         <xsl:value-of select="concat(
            '   sio:has-attribute &lt;graphic/edge/',sof:checksum(@id),'&gt;;',$NL
         )"/>
      </xsl:if>
      <xsl:value-of select="concat('.',$NL)"/>
      <xsl:if test="@id">
         <xsl:value-of select="concat(
            '&lt;graphic/edge/',sof:checksum(@id),'&gt;',$NL,
            '   a sio:Attribute;',$NL,
            '   sio:refers-to &lt;graphic/',sof:checksum(@target),'&gt;;',$NL,'.',$NL
         )"/>
      </xsl:if>
   </xsl:if>
</xsl:template>

<xsl:template match="y:ShapeNode">
   <!--
     <ShapeNode xmlns="http://www.yworks.com/xml/graphml">
        <y:Geometry xmlns="http://graphml.graphdrawing.org/xmlns/graphml" x="0.0" y="0.0"
                    width="250"
                    height="100"/>
        <y:Fill xmlns="http://graphml.graphdrawing.org/xmlns/graphml" color="#FFCC00"
                transparent="false"/>
        <y:BorderStyle xmlns="http://graphml.graphdrawing.org/xmlns/graphml" type="line" width="1.0"
                       color="#000000"/>
        <y:NodeLabel xmlns="http://graphml.graphdrawing.org/xmlns/graphml" x="0.0" y="0.0"
                     width="250"
                     height="100"
                     visible="true"
                     alignment="center"
                     fontFamily="Dialog"
                     fontSize="12"
                     fontStyle="plain"
                     textColor="#000000"
                     backgroundColor="#FFFFFF"
                     lineColor="#000000"
                     modelName="internal"
                     modelPosition="c"
                     autoSizePolicy="content">(48)   foaf:   http://xmlns.com/foaf/0.1/
   (2751)   prov:   http://www.w3.org/ns/prov#
   (24)   sioc:   http://rdfs.org/sioc/ns#
   (3853)   sio:   http://semanticscience.org/resource/
   </y:NodeLabel>
        <y:Shape xmlns="http://graphml.graphdrawing.org/xmlns/graphml" type="rectangle"/>
     </ShapeNode>
   -->
   <xsl:apply-templates select="*"/>
</xsl:template>

<xsl:template match="y:Geometry">
   <xsl:param name="objects" select="false()" tunnel="yes"/>
   <!--
     <ShapeNode xmlns="http://www.yworks.com/xml/graphml">
        <y:Geometry x="0.0"     y="0.0"
                    width="250" height="100"/>
     </ShapeNode>
   -->
   <xsl:choose>
      <xsl:when test="not($objects)">
         <xsl:value-of select="concat(
            '   vsr:x      ',@x,';',$NL,
            '   vsr:y      ',@y,';',$NL,
            '   vsr:width  ',@width,';',$NL,
            '   vsr:height ',@height,';',$NL
         )"/>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xsl:template match="y:Fill">
   <xsl:param name="objects" select="false()" tunnel="yes"/>
   <!--
     <ShapeNode xmlns="http://www.yworks.com/xml/graphml">
        <y:Fill xmlns="http://graphml.graphdrawing.org/xmlns/graphml" color="#FFCC00"
                transparent="false"/>
     </ShapeNode>
   -->
   <xsl:variable name="number">
      <xsl:number select="." count="y:Fill" level="any"/>
   </xsl:variable>
   <xsl:variable name="fill" select="concat('&lt;graphic/fill/',if (string-length(@color)) then sof:checksum(@color) else $number,'&gt;')"/>

   <xsl:choose>
      <xsl:when test="not($objects)">
         <xsl:value-of select="concat('   vsr:fill ',$fill,';',$NL)"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="concat(
            $fill,$NL,
            '   a vsr:Color',
                  if (@transparent = 'true') then ', vsr:Transparent' else '',';',$NL,
            if (@color) then concat(
               '   vsr:rgb ',$DQ,@color,$DQ,';',$NL) else '',
            '.',$NL)"/>
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xsl:template match="y:BorderStyle">
   <xsl:param name="objects" select="false()" tunnel="yes"/>
   <!--
     <ShapeNode xmlns="http://www.yworks.com/xml/graphml">
        <y:BorderStyle xmlns="http://graphml.graphdrawing.org/xmlns/graphml" type="line" width="1.0"
                       color="#000000"/>
     </ShapeNode>
   -->
   <xsl:variable name="number">
      <xsl:number select="." count="y:BorderStyle" level="any"/>
   </xsl:variable>
   <xsl:variable name="border" select="concat('&lt;graphic/border/',$number,'&gt;')"/>

   <xsl:choose>
      <xsl:when test="not($objects)">
         <xsl:value-of select="concat('   vsr:border ',$border,';',$NL)"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="concat($border,' a vsr:Graphic .',$NL)"/>
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xsl:template match="y:NodeLabel">
   <xsl:param name="objects" select="false()" tunnel="yes"/>
   <!--
     <ShapeNode xmlns="http://www.yworks.com/xml/graphml">
        <y:NodeLabel xmlns="http://graphml.graphdrawing.org/xmlns/graphml" x="0.0" y="0.0"
           width="250"
           height="100"
           visible="true"
           alignment="center"
           fontFamily="Dialog"
           fontSize="12"
           fontStyle="plain"
           textColor="#000000"
           backgroundColor="#FFFFFF"
           lineColor="#000000"
           modelName="internal"
           modelPosition="c"
           autoSizePolicy="content">(48)   foaf:   http://xmlns.com/foaf/0.1/
   (2751)   prov:   http://www.w3.org/ns/prov#
   (24)   sioc:   http://rdfs.org/sioc/ns#
   (3853)   sio:   http://semanticscience.org/resource/</y:NodeLabel>
   </ShapeNode>
   -->
   <xsl:choose>
      <xsl:when test="not($objects)">
         <xsl:value-of select="concat(
            '   rdfs:label ',$DQ,normalize-space(.),$DQ,';',$NL
         )"/>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xsl:template match="y:Shape">
   <xsl:param name="objects" select="false()" tunnel="yes"/>
   <!--
     <ShapeNode xmlns="http://www.yworks.com/xml/graphml">
        <y:Shape xmlns="http://graphml.graphdrawing.org/xmlns/graphml" type="rectangle"/>
     </ShapeNode>
   -->
   <xsl:choose>
      <xsl:when test="not($objects)">
         <xsl:value-of select="concat('   a graphml:',@type,';',$NL)"/>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
   </xsl:choose>
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
