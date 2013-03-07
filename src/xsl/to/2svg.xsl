<!-- 
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/blob/master/src/xsl/to/2svg.xsl> .
-->
<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"

   xmlns:vsr="http://purl.org/twc/vocab/vsr#"
   xmlns:grddl="http://www.w3.org/2003/g/data-view#"

   xmlns:svg="http://www.w3.org/2000/svg"

   xmlns:xfm="transform namespace">

<xsl:output method="xml" indent="yes"/>

<xsl:include href="../util/atoid.xsl"/>
<xsl:include href="../ns/vsr-ns.xsl"/>

<xd:doc>
   <xd:short>SVG-friendly alternate identifiers.</xd:short>
   <xd:detail>
   </xd:detail>
   <xd:param name="id">A client-side string that uniquely identifies some thing.</xd:param>
</xd:doc>
<xsl:function name="vsr:view-id">
   <xsl:param name="id"/>
   <!-- xsl:value-of select="if (false()) then xfm:atoid($id) else $id"/-->
   <xsl:variable name="value" select="1000 + xfm:atoid-smaller($id)"/>
   <xsl:message select="concat('             SVG view-id ',$value,' from ',$id)"/>
   <xsl:value-of select="$value"/>
</xsl:function>

<xsl:variable name="svg-id-prefix" select="'n'"/>
<xsl:function name="svg:to-svg-id">
   <xsl:param name="id"/>
   <xsl:value-of select="concat($svg-id-prefix,$id)"/>
</xsl:function>

<xsl:variable name="default-color" select="'#FFCC00'"/>

<xsl:template match="/"> <!-- This root template should be matched by any execution of x2svg.xsl.
                            the only thing that needs to be in the x2svg.xsl is a template for each node
                                              and edge that should manifest. These templates should call-by-name svg-node and svg-edge
                                              TODO: rename svg-node and svg-edge to svg-node and svg-edge -->
   <svg:svg version="1.1" grddl:transformation="https://raw.github.com/timrdf/vsr/master/src/xsl/grddl/svg.xsl">
      <svg:metadata>
         <grddl:transformation href="https://raw.github.com/timrdf/vsr/master/src/xsl/grddl/svg.xsl"/>
      </svg:metadata>
      <xsl:apply-templates select="*"/>
   </svg:svg>
</xsl:template>

<xsl:template name="node">

   <xsl:param name="visual-artifact-uri" required="yes"/>
   <xsl:param name="context"             required="no"/>
   <xsl:param name="depicts"             required="no"/>
   <xsl:param name="id"                  required="yes"/>
   <xsl:param name="visualArtifactURI"   required="no"/>

   <xsl:param name="uri"                 required="no"/>

   <xsl:param name="x"                   required="no"/>
   <xsl:param name="y"                   required="no"/>

   <xsl:param name="height"              required="no"/>
   <xsl:param name="width"               required="no"/>
   <xsl:param name="draw-fill"           required="no"/>
   <xsl:param name="fill-color"          required="no"/>
   <xsl:param name="draw-stroke"         required="no"/>
   <xsl:param name="stroke-color"        required="no"/>
   <xsl:param name="draw-shadow"         required="no"/>
   <xsl:param name="shape"               required="no"/>
   <xsl:param name="rotation"            required="no"/>

   <xsl:param name="label"               required="yes"/>
   <xsl:param name="fit-text"            required="no"/>
   <xsl:param name="font-color"          required="no"/>
   <xsl:param name="h-align-text"        required="no"/>
   <xsl:param name="h-text-pad"          required="no"/>
   <xsl:param name="v-align-text"        required="no"/>

   <xsl:param name="tooltip"             required="no"/>
   <xsl:param name="notes"               required="no"/>

   <xsl:param name="isDefinedBy"         required="no"/>
   <xsl:param name="rdfTypes"            required="no"/>
   <xsl:param name="url"                 required="no"/>
   <xsl:param name="a-root"              required="no"/>
   <xsl:param name="ignore"              required="no"/>

   <xsl:call-template name="svg-node">
      <xsl:with-param name="id"    select="$id"/>
      <xsl:with-param name="label" select="$label"/>

      <xsl:with-param name="url"         select="$url"/>
      <xsl:with-param name="description" select="$notes"/>
      <xsl:with-param name="depicts"     select="$depicts"/>

      <!--xsl:with-param name="color"             select="$fill-color"/-->
      <!--xsl:with-param name="fill-color"        select="''"/-->
      <!--xsl:with-param name="fit-text"          select="''"/-->
      <!--xsl:with-param name="font-color"        select="''"/>
      <xsl:with-param name="h-align-text"      select="''"/>
      <xsl:with-param name="h-text-pad"        select="''"/>
      <xsl:with-param name="head-style"        select="''"/>
      <xsl:with-param name="ignore"            select="''"/>
      <xsl:with-param name="isDefinedBy"       select="''"/>
      <xsl:with-param name="label"             select="''"/>
      <xsl:with-param name="line-style"        select="''"/>
      <xsl:with-param name="line-width"        select="''"/>
      <xsl:with-param name="notes"             select="''"/-->
      <!--xsl:with-param name="rdfTypes"          select="''"/-->
      <!--xsl:with-param name="rotation"          select="''"/-->
      <!--xsl:with-param name="border-color"      select="$stroke-color"/-->
      <!--xsl:with-param name="tail-style"        select="''"/-->
      <!--xsl:with-param name="url"               select="$url"/>
      <xsl:with-param name="v-align-text"      select="''"/-->
      <!--xsl:with-param name="visualArtifactURI" select="''"/-->
      <!--xsl:with-param name="x"                 select="$x"/>
      <xsl:with-param name="y"                 select="$y"/-->
   </xsl:call-template>
</xsl:template>

<xsl:template name="svg-node">
   <xsl:param name="id"                    required="yes"/>
   <xsl:param name="label"                 required="yes"/>

   <xsl:param name="x"                     required="no">0.0</xsl:param> <!-- center of node, NOT upper left -->
   <xsl:param name="y"                     required="no">0.0</xsl:param> <!-- coordinate system is 0,0 top left, +,+ down and to right -->
   <xsl:param name="width"                 required="no">250</xsl:param>
   <xsl:param name="height"                required="no">100</xsl:param>
   <xsl:param name="shape"                 required="no">rectangle</xsl:param> <!--trapezoid2, diamond, hexagon, rectangle, triangle, ellipse-->
   <xsl:param name="color"                 required="no">#FFCC00</xsl:param>
   <xsl:param name="border-color"          required="no">#000000</xsl:param>
   <xsl:param name="border-width"          required="no">1.0</xsl:param>
   <xsl:param name="label-fontSize"        required="no">12</xsl:param>
   <xsl:param name="label-textColor"       required="no">#000000</xsl:param>
   <xsl:param name="label-backgroundColor" required="no">#FFFFFF</xsl:param>
   <xsl:param name="label-modelName"       required="no">internal</xsl:param>
   <xsl:param name="label-modelPosition"   required="no">c</xsl:param>
   <xsl:param name="label-alignment"       required="no">center</xsl:param>
   <xsl:param name="label-x"               required="no">0.0</xsl:param>
   <xsl:param name="label-y"               required="no">0.0</xsl:param>
   <xsl:param name="label-width"           required="no">101.0</xsl:param>
   <xsl:param name="label-height"          required="no">35.0</xsl:param>
   <xsl:param name="image-url"             required="no"/>
   <xsl:param name="url"                   required="no"/>
   <xsl:param name="description"           required="no"/>
   <xsl:param name="depicts"               required="no"/>

   <!-- It is strongly recommended that at most one ‘metadata’ element appear as a child of any particular element, 
        and that this element appear before any other child elements (except possibly ‘desc’ or ‘title’ elements) 
        or character data content. If metadata-processing user agents need to choose among multiple ‘metadata’ 
        elements for processing it should choose the first one.
                                                      - - http://www.w3.org/TR/SVG11/metadata.html#MetadataElement
   -->

   <svg:g id="{concat($svg-id-prefix,$id)}">
      <svg:metadata>
         <xsl:if test="string-length($depicts) and starts-with($depicts,'http')">
            <vsr:depicts rdf:resource="{$depicts}"/>
         </xsl:if>
      </svg:metadata>
   </svg:g>
</xsl:template>

<xsl:template name="edge">

   <xsl:param name="id"           required="yes"/>
   <xsl:param name="depicts"      required="no"/>
   <xsl:param name="from"         required="yes"/>
   <xsl:param name="to"           required="yes"/>

   <xsl:param name="head-style"   required="no"/>
   <xsl:param name="stroke-color" required="no"/>
   <xsl:param name="line-style"   required="no"/>
   <xsl:param name="line-width"   required="no"/>

   <xsl:param name="font-color"   required="no"/>
   <xsl:param name="tail-style"   required="no"/>
   <xsl:param name="label"        required="no"/>
   <xsl:param name="draw-shadow"  required="no"/>

   <xsl:param name="url"          required="no"/>
   <xsl:param name="notes"        required="no"/>

   <xsl:call-template name="svg-edge">
      <xsl:with-param name="id"      select="$id"/>
      <xsl:with-param name="from"    select="$from"/>
      <xsl:with-param name="to"      select="$to"/>
      <xsl:with-param name="depicts" select="$depicts"/>

      <xsl:with-param name="url"     select="$url"/>
   </xsl:call-template>
</xsl:template>

<xsl:template name="svg-edge">
   <xsl:param name="id"         required="yes"/>
   <xsl:param name="from"       required="yes"/>
   <xsl:param name="to"         required="yes"/>

   <xsl:param name="line-width" required="no">1.0</xsl:param> 
   <xsl:param name="line-color" required="no">#000000</xsl:param>
   <xsl:param name="line-style" required="no">line</xsl:param> <!-- line, dashed, XXXX -->
   <xsl:param name="label"      required="no"/>
   <xsl:param name="url"        required="no"/>
   <xsl:param name="depicts"    required="no"/>

   <svg:g id="{concat($svg-id-prefix,$id)}">
      <svg:metadata>
         <xsl:if test="string-length($depicts) and starts-with($depicts,'http')">
            <vsr:depicts rdf:resource="{$depicts}"/>
         </xsl:if>
      </svg:metadata>
   </svg:g>
</xsl:template>

</xsl:transform>
