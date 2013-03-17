<!-- 
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/blob/master/src/xsl/to/2graphml.xsl> .
-->
<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"

   xmlns:vsr="http://purl.org/twc/vocab/vsr#"
   xmlns:grddl="http://www.w3.org/2003/g/data-view#"

   xmlns:graphml="http://graphml.graphdrawing.org/xmlns/graphml"
   xmlns="http://graphml.graphdrawing.org/xmlns/graphml"
   xmlns:y="http://www.yworks.com/xml/graphml"

   xmlns:xfm="transform namespace">

<xsl:output method="xml" indent="yes"/>

<xsl:include href="../util/atoid.xsl"/>
<xsl:include href="../util/tertiary.xsl"/>
<!--xsl:include href="../ns/vsr-ns.xsl"/-->
<xsl:include href="../ns/yworks-ns.xsl"/>

<xd:doc>
   <xd:short>GraphML-friendly alternate identifiers.</xd:short>
   <xd:detail>
   </xd:detail>
   <xd:param name="id">A client-side string that uniquely identifies some thing.</xd:param>
</xd:doc>
<xsl:function name="vsr:view-id">
   <xsl:param name="id"/>
   <!-- xsl:value-of select="if (false()) then xfm:atoid($id) else $id"/-->
   <xsl:variable name="value" select="1000 + xfm:atoid-smaller($id)"/>
   <xsl:message select="concat('             GRAPHML view-id ',$value,' from ',$id)"/>
   <xsl:value-of select="$value"/>
</xsl:function>

<xsl:variable name="graphml-id-prefix" select="'n'"/>
<xsl:function name="graphml:to-graphml-id">
  <xsl:param name="id"/>
   <xsl:value-of select="concat($graphml-id-prefix,$id)"/>
</xsl:function>

<xsl:variable name="default-color" select="'#FFCC00'"/>

<xsl:template match="/"> <!-- This root template should be matched by any execution of x2graphml.xsl.
                            the only thing that needs to be in the x2graphml.xsl is a template for each node
                                              and edge that should manifest. These templates should call-by-name yed-node and yed-edge
                                              TODO: rename yed-node and yed-edge to graphml-node and graphml-edge -->
   <graphml grddl:transformation="https://raw.github.com/timrdf/vsr/master/src/xsl/grddl/graphml.xsl">
      <key id="d0" for="node" yfiles.type="nodegraphics"/>
      <key id="d1" for="node" attr.name="url"            attr.type="string"/>
      <key id="d2" for="node" attr.name="description"    attr.type="string"/>
      <key id="d6" for="node" attr.name="{$vsr:depicts}" attr.type="string"/>

      <key id="d3" for="edge" yfiles.type="edgegraphics"/>
      <key id="d4" for="edge" attr.name="url"         attr.type="string"/>
      <key id="d5" for="edge" attr.name="description" attr.type="string"/>
      <graph id="G" edgedefault="directed">
         <xsl:apply-templates select="*"/>
      </graph>
   </graphml>
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

   <xsl:call-template name="yed-node">
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

<xsl:template name="yed-node">
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

   <node id="{concat($graphml-id-prefix,$id)}">
      <data key="d0">
         <!-- ImageNode or ShapeNode -->
         <xsl:element name="{if ($image-url) then 'ImageNode' else 'ShapeNode'}" namespace="{$yworks}"> 
            <y:Geometry x="{$x}" y="{$y}" width="{$width}" height="{$height}"/>
            <y:Fill color="{$color}" transparent="false"/>
            <y:BorderStyle type="line" width="{$border-width}" color="{$border-color}"/>
            <y:NodeLabel x="{$label-x}" y="{$label-y}" width="{$width}" height="{$height}" 
                               visible="true" alignment="{$label-alignment}" 
                               fontFamily="Dialog" fontSize="{$label-fontSize}" fontStyle="plain" textColor="{$label-textColor}" 
                               backgroundColor="{$label-backgroundColor}" lineColor="#000000" 
                               modelName="{$label-modelName}" modelPosition="{$label-modelPosition}" 
                               autoSizePolicy="content">
               <xsl:value-of select="$label"/>
            </y:NodeLabel>
            <xsl:choose>
               <xsl:when test="$image-url">
                  <y:Image href="{$image-url}"/>
               </xsl:when>
               <xsl:otherwise>
                  <y:Shape type="{$shape}"/>
               </xsl:otherwise>
           </xsl:choose>
         </xsl:element>
      </data>
      <data key="d1"> <xsl:value-of select="$url"/>         </data>
      <data key="d2"> <xsl:value-of select="$description"/> </data>
      <xsl:if test="string-length($depicts)">
         <data key="d6"> <xsl:value-of select="$depicts"/>  </data>
      </xsl:if>
   </node>
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

   <xsl:call-template name="yed-edge">
      <xsl:with-param name="id"    select="$id"/>
      <xsl:with-param name="from"  select="$from"/>
      <xsl:with-param name="to"    select="$to"/>

      <xsl:with-param name="url"   select="$url"/>
   </xsl:call-template>
</xsl:template>

<xsl:template name="yed-edge">
   <xsl:param name="id"         required="yes"/>
   <xsl:param name="from"       required="yes"/>
   <xsl:param name="to"         required="yes"/>

   <xsl:param name="line-width" required="no">1.0</xsl:param> 
   <xsl:param name="line-color" required="no">#000000</xsl:param>
   <xsl:param name="line-style" required="no">line</xsl:param> <!-- line, dashed, XXXX -->
   <xsl:param name="label"      required="no"/>
   <xsl:param name="url"        required="no"/>

   <edge id="{concat($graphml-id-prefix,$id)}" source="{concat($graphml-id-prefix,$from)}" target="{concat($graphml-id-prefix,$to)}">
      <data key="d3">
         <y:PolyLineEdge>
            <y:Path sx="0.0" sy="0.0" tx="0.0" ty="0.0"/>
            <y:LineStyle type="{$line-style}" width="{$line-width}" color="{$line-color}"/>
            <y:Arrows source="none" target="standard"/>
            <xsl:if test="$label">
               <y:EdgeLabel x="160.09068674185983" y="5.236263711168558" 
                                  width="65.0" height="18.1328125" visible="true" 
                                  alignment="center" 
                                  fontFamily="Dialog" fontSize="12" fontStyle="plain" textColor="#000000" 
                                  hasBackgroundColor="false" hasLineColor="false" modelName="six_pos" modelPosition="tail" 
                                  preferredPlacement="anywhere" distance="2.0" ratio="0.5">
                  <xsl:value-of select="$label"/>
               </y:EdgeLabel>
            </xsl:if>
            <y:BendStyle smoothed="false"/>
         </y:PolyLineEdge>
      </data>
      <data key="d4"> <xsl:value-of select="$url"/> </data>
     <data key="d5"/>
   </edge>
</xsl:template>

</xsl:transform>
