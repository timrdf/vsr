<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:wgs="http://www.w3.org/2003/01/geo/wgs84_pos#"
   xmlns:time="http://www.w3.org/2006/time#"
   xmlns:ov="http://open.vocab.org/terms/"
   xmlns:rl="http://purl.org/twc/vocab/vsr/"
   xmlns:p="http://purl.org/twc/vocab/vsr/"
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:dcterms="http://purl.org/dc/terms/"

   xmlns:jvr="jvr"
   xmlns:nmf="java:edu.rpi.tw.string.NameFactory"
   xmlns:idm="java:edu.rpi.tw.string.IDManager"
   xmlns:log="java:edu.rpi.tw.visualization.log.VisualizationDecisions"

   xmlns:acv="accountable visualization"
   xmlns:pmap="edu.rpi.tw.string.pmm.DefaultPrefixMappings"
   xmlns:xutil="https://github.com/timrdf/vsr/tree/master/src/xsl/util"
   xmlns:xsdabv="https://github.com/timrdf/vsr/tree/master/src/xsl/util/xsd-datatype-abbreviations.xsl"
   xmlns:pmm="edu.rpi.tw.string.pmm"
   xmlns:vsr="http://purl.org/twc/vocab/vsr#"
   xmlns:xfm="transform namespace">

<xd:doc type="stylesheet">
   <xd:short>Functions to render rdf:Lists</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>Return a serialization of the URIs and nodeIDs in the given <tt>rdf:List</tt>, delimited by the string <tt>$connective</tt>.
   </xd:detail>
   <xd:param name="first"      type="xs:string"><tt>URIRef</tt> of the <tt>rdf:List</tt> to serialize.</xd:param>   
   <xd:param name="connective" type="xs:string">String value to delimit element serializations. Defaults to "comma-space", i.e. "<tt>, </tt>".</xd:param>   
   <xd:param name="abbreviate" type="xs:boolean">If true, use curie, else return the full URIRef or nodeID.</xd:param>   
</xd:doc>
<xsl:template name="list-string">
   <xsl:param name="first"      as="xs:string"  required="yes"/>
   <xsl:param name="connective" as="xs:string"  select="', '"/>
   <xsl:param name="abbreviate" as="xs:boolean" select="true()"/>

   <!--xsl:message select="concat('list-string ',$first)"/>
   < TODO: is a list of literals ok? -->
   <xsl:variable name="element"     select="key('descriptions-by-subject',$first)/rdf:first/(@rdf:resource | @rdf:nodeID)"/>
   <xsl:variable name="element-str" select="if ($abbreviate and string-length($element)) then pmm:tryQName($element) else $element"/>

   <xsl:variable name="rest"        select="key('descriptions-by-subject',$first)/rdf:rest/(@rdf:resource | @rdf:nodeID)"/>

   <!--xsl:message select="$in,$in,'list-string(',$first,') first: ',$element,' rest: ',$rest"/-->
   <xsl:choose>
      <xsl:when test="string-length($first) and string-length($rest) and $rest != $rdf:nil">
         <xsl:variable name="list-string">
            <xsl:call-template name="list-string">
               <xsl:with-param name="first"      select="$rest"/>
               <xsl:with-param name="connective" select="$connective"/>
               <xsl:with-param name="abbreviate" select="$abbreviate"/>
            </xsl:call-template>
         </xsl:variable>
         <xsl:value-of select="concat($element-str,$connective,$list-string)"/>
      </xsl:when>
      <xsl:when test="$rest = $rdf:nil">
         <xsl:value-of select="$element-str"/>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xd:doc>
   <xd:short>Render a visual edge from each V(node) in the given list to a V(node) of the given node.</xd:short>
   <xd:detail>Connect <tt>$subject</tt> to each element in the rdf:List <tt>$list-URIRef</tt> using the predicate <tt>$predicate</tt>.
   </xd:detail>
   <xd:param name="subject">The node to which all elements of <tt>$list-URIRef</tt> will have rendered a visual edge from.</xd:param>
   <xd:param name="list-URIRef">Connect <tt>$subject</tt> to every element in this list.</xd:param>
   <xd:param name="predicate">The RDF predicate that the visual edges depict.</xd:param>
   <xd:param name="notes">A textual message to associate with each visual edge rendered.</xd:param>
   <xd:param name="reverse">If true, swap the directionality of the visual edges. Defaults to false.</xd:param>
   <xd:param name="line-width">The width of the visual edges rendered.</xd:param>
   <xd:param name="line-style">The stipple pattern of the visual edge to render (1 to 24, 1 solid, 2 dashed, 3 dotted).</xd:param>
   <xd:param name="head-style">The arrow style for the head of the visual edges to render.</xd:param>
   <xd:param name="tail-style">The arrow style for the tail of the visual edges to render.</xd:param>
   <xd:param name="draw-shadow">Draw the visual edges with a shadow?</xd:param>
   <xd:param name="stroke-color">The color of the visual edges to render.</xd:param>
</xd:doc>
<xsl:template name="connect-to-elements">
   <xsl:param name="subject"     required="yes"/>
   <xsl:param name="list-URIRef" required="yes"/>
   <xsl:param name="predicate"/> 
   <xsl:param name="notes"/> 

   <xsl:param name="reverse"      select="false()"/> 
   <xsl:param name="line-width"   select="3"/> 
   <xsl:param name="line-style"   select="2"/>
   <xsl:param name="head-style"   select="'FilledArrow'"/>
   <xsl:param name="tail-style"   select="''"/>
   <xsl:param name="draw-shadow"  select="'YES'"/>
   <xsl:param name="stroke-color" select="'0.701961'"/>

   <xsl:variable name="elements"> 
      <xsl:call-template name="list-string">
         <xsl:with-param name="first" select="$list-URIRef"/>
         <xsl:with-param name="connective" select="' '"/>
         <xsl:with-param name="abbreviate" select="false()"/>
      </xsl:call-template>
   </xsl:variable>
   <xsl:for-each-group select="tokenize($elements,'\s')" group-by=".">
      <xsl:message select="concat($in,$in,'linking ',$subject,' to list element ',.)"/>
      <xsl:call-template name="edge">
         <xsl:with-param name="id"           select="nmf:getUUIDName('_linking_to_list_elements')"/>
         <xsl:with-param name="from"         select="if ($reverse) then . else $subject"/>
         <xsl:with-param name="depicts"      select="$predicate"/>
         <xsl:with-param name="to"           select="if ($reverse) then $subject else ."/>
         <xsl:with-param name="label"        select="pmm:tryQName($predicate)"/>
         <xsl:with-param name="notes"        select="if ($notes) then $notes else pmm:tryQName($predicate)"/>
         <xsl:with-param name="url"          select="$predicate"/>
         <xsl:with-param name="line-width"   select="$line-width"/>
         <xsl:with-param name="line-style"   select="$line-style"/>
         <xsl:with-param name="head-style"   select="if ($reverse) then $tail-style else $head-style"/>
         <xsl:with-param name="tail-style"   select="if ($reverse) then $head-style else $tail-style"/>
         <xsl:with-param name="draw-shadow"  select="$draw-shadow"/>
         <xsl:with-param name="stroke-color" select="$stroke-color"/>
      </xsl:call-template>
   </xsl:for-each-group>
</xsl:template>

<xd:doc>
   <xd:short>Render a visual edge from a V(node) to a new VNode whose label 
             serializes the elements in a list.</xd:short>
   <xd:detail>Render a visual edge from V(<tt>$subject</tt>) to a newly 
              minted VNode with a label serializing all elements in <tt>$list-URIRef</tt>.
   </xd:detail>
</xd:doc>
<xsl:template name="label-with-manchax-list">
   <xsl:param name="subject"     required="yes"/> <!-- the subject to link the manchax label to -->
   <xsl:param name="connective"  required="yes"/> <!-- string to insert in between elements of the list -->
   <xsl:param name="list-URIRef" required="yes"/> <!-- uri of the list -->
   <xsl:param name="gnode"/>                      <!-- id to use for label node (instead of minting one) -->

   <xsl:variable name="elements-string">
      <xsl:call-template name="list-string">
         <xsl:with-param name="first"      select="$list-URIRef"/>
         <xsl:with-param name="connective" select="$connective"/>
      </xsl:call-template>
   </xsl:variable>
   
   <xsl:message select="concat($in,'labelling ',$subject,' ',
                               'with-manchax for list ', $in,$list-URIRef,$in,' ',
                               'label:',$DQ,$elements-string,$DQ)"/>

   <xsl:variable name="blank-gnode"     select="if ($gnode) then $gnode else nmf:getUUIDName('gnode')"/>

   <xsl:call-template name="node"> <!-- Make the node for the manchax literal -->
      <xsl:with-param name="id"                  select="$blank-gnode"/>
      <xsl:with-param name="label"               select="$elements-string"/>
      <xsl:with-param name="depicts"             select="$elements-string"/>
      <xsl:with-param name="visual-artifact-uri" select="$visual-artifact-uri"/>
      <xsl:with-param name="x"                   select="5 * $separation[1]"/>
      <xsl:with-param name="y"                   select="5 * $separation[2]"/>
   </xsl:call-template>

   <xsl:call-template name="edge"> <!-- Make the edge from the $subject to the manchax literal -->
      <xsl:with-param name="id"         select="nmf:getUUIDName('gedge')"/>
      <xsl:with-param name="from"       select="$subject"/>
      <xsl:with-param name="to"         select="$blank-gnode"/>
      <xsl:with-param name="depicts"    select="$ov:manchax"/>
      <xsl:with-param name="label"      select="'ov:manchax'"/>
      <xsl:with-param name="notes"      select="'ov:manchax'"/>
      <xsl:with-param name="url"        select="$ov:manchax"/>
   </xsl:call-template>
</xsl:template>

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>Return the number of elements in the given rdf:List.
   </xd:detail>
</xd:doc>
<xsl:template name="list-length">
   <xsl:param name="list" as="xs:string" required="yes"/>   <!-- URIRef for the rdf:List -->

   <xsl:variable name="rest"    select="key('descriptions-by-subject',$list)/rdf:rest/(@rdf:resource  | @rdf:nodeID)"/>

   <!--xsl:message select="$in,$in,'list-length(',$first,') first: ',$element,' rest: ',$rest"/-->
   <xsl:choose>
      <xsl:when test="string-length($list) and string-length($rest) and $rest != $rdf:nil">
         <xsl:variable name="list-length" as="xs:integer">
            <xsl:call-template name="list-length">
               <xsl:with-param name="list" select="$rest"/>
            </xsl:call-template>
         </xsl:variable>
         <xsl:value-of select="$list-length + 1"/>
      </xsl:when>
      <xsl:when test="$rest = $rdf:nil">
         <xsl:value-of select="'1'"/>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>


<xd:doc>
   <xd:short>Natural language of owl:unionOf or owl:intersectionOf.</xd:short>
   <xd:detail>Used by <a href="#d24e1741">list-string</a> and (by transitivity) <a href="#d24e1941">label-with-manchex-list</a>.
   </xd:detail>
   <xd:param name="predicate" type="xs:string">owl:unionOf or owl:intersectionOf</xd:param>
</xd:doc>
<xsl:function name="xfm:connective">
   <xsl:param name="predicate" as="xs:string"/>
   <xsl:choose>
      <xsl:when test="normalize-space($predicate) = $owl:unionOf">
         <xsl:value-of select="' or '"/>
      </xsl:when>
      <xsl:when test="normalize-space($predicate) = $owl:intersectionOf">
         <xsl:value-of select="' and '"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="', '"/>
      </xsl:otherwise>
   </xsl:choose>
</xsl:function>

</xsl:transform>
