<!-- 
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/blob/master/src/xsl/to/2vsr.xsl> .
-->
<xsl:transform version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:g="https://raw.github.com/timrdf/vsr/master/src/xsl/grddl/graffle.xsl#"
   xmlns:msg20090200215="http://www.oxygenxml.com/archives/xsl-list/200902/msg00215.html"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xfm="transform namespace"
   xmlns:vsr="http://purl.org/twc/vocab/vsr#"
   exclude-result-prefixes="vsr xfm xs xd xsl g msg20090200215">

<!--xsl:output method="text"/-->
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

<xd:doc type="stylesheet">
   <xd:short>VSR</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<xsl:include href="../util/atoid.xsl"/>
<xsl:include href="../util/rtf-function.xsl"/>

<xd:doc>
   <xd:short>Graffle-friendly alternate identifiers.</xd:short>
   <xd:detail>Graffle ids must be signed 64 bit integer (-9,223,372,036,854,775,808 to +9,223,372,036,854,775,807).
              Counting starts at 1,000 to avoid initial elements in the document boilerplate.
              Calls <a href="../util/atoid.xsl.xd.html#d92e55">atoid.xsl's atoid-smaller(id)</a>.
   </xd:detail>
   <xd:param name="id">A client-side string that uniquely identifies some thing.</xd:param>
</xd:doc>
<xsl:function name="vsr:view-id">
   <xsl:param name="id"/>
   <!-- xsl:value-of select="if (false()) then xfm:atoid($id) else $id"/-->
   <xsl:variable name="value" select="1000 + xfm:atoid-smaller($id)"/>
   <xsl:message select="concat('               vsr:view-id ',$value,' from ',$id,' (@ graffle.xsl)')"/>
   <xsl:value-of select="$value"/>
</xsl:function>

<xsl:variable name="prefixes">
<xsl:text><![CDATA[@prefix rdfs:    <http://www.w3.org/2000/01/rdf-schema#>.
@prefix dcterms: <http://purl.org/dc/terms/> .
@prefix foaf:    <http://xmlns.com/foaf/0.1/> .
@prefix prov:    <http://www.w3.org/ns/prov#> .
@prefix pext:    <http://www.ontotext.com/proton/protonext#> .

]]></xsl:text>
</xsl:variable>

<xsl:template match="/">
   <xsl:value-of select="$prefixes"/>
   <xsl:apply-templates select="*"/>
</xsl:template>

<xd:doc>
   <xd:short>Create a new V(node).</xd:short>
   <xd:detail>
   </xd:detail>
   <xd:param name="visual-artifact-uri">URI of the :Visual_artifact that comprises the :Visual_form created 
                                        by calling this template. The invocation of a :Visualization_process
                                        creates a single (and only one) :Visual_artifact.
   </xd:param>
   <xd:param name="depicts">The URI of the thing depicted by that will be created (<tt>visual-artifact-uri</tt>).
                            URI of :Domain_Form that this :Visual_Form will :depict when :Rendered. 
                            TODO: what happens if it is depicting a bnode? 
   </xd:param>
   <xd:param name="context">The URI of an [optional] context in which the visual node is being created. 
                            For example, a new visual node for an OWL property is created within the context of the class that is forming a restriction on the property.
                            For example, a person X as the friend of one (A) may be rendered in a different context of another visual node (person B).
                            URI of context in which :Domain_form should be depicted. 
                            '' ==> $visual-artifact-uri
                            A context of $visual-artifact-uri indicates "global", but if more than one
                            :Visual_form should depict the same :Domain_form, subsequent contexts should be 
                            distinct URIs within the scope of $visual-artifact-uri. "Relaxing" a visual node is done by 
                            depicting the same :Domain_form in multiple distinct contexts. 
                            Original need for this was multiple visual forms depicting the same OWL
                            property when it was mentioned by multiple local restrictions.
   </xd:param>
   <xd:param name="id">Unique string within this current Visualization process that identifies the :Visual_form
                       created by calling this template. 
                       URI of the :Visual_form created will be ~ concat($visual-artifact-uri,'...',hash($id).
                       This parameter is provided for a :Visual_strategy author that does not care about
                       naming the :Visual_forms with URIs but can provide strings unique enough to identify them. 
                       For example, concatenating the sorted URIs of a list into a single string can be an identifier
                       for a bnode list of classes.
                       Deprecated? Client-side?
   </xd:param>
   <xd:param name="uri">URI of this :Visual_form. TODO: deprecate in favor of 'context' and 'id'.</xd:param>
   <xd:param name="isDefinedBy">rdfs:isDefinedBy of the <tt>depicts</tt> -- if the latter is a vocabulary term. (A bit special case at this generic level...).</xd:param>
   <xd:param name="rdfTypes">The rdf:types of <tt>depicts</tt>.</xd:param>
   <xd:param name="shape">The shape of the visual node to create. 'Rectangle', 'Circle', 'Cross'.</xd:param>
   <xd:param name="x">The position of the visual node, from upper left 0,0.</xd:param>
   <xd:param name="y">The position of the visual node, from upper left 0,0.</xd:param>
   <xd:param name="lock">Lock the position and sizing of the shape.</xd:param>
   <xd:param name="rotation">Angle to rotate the visual node. Degrees; -90 = 270.</xd:param>
   <xd:param name="width">If undefined, fits to text label</xd:param>
   <xd:param name="height"></xd:param>
   <xd:param name="magnets">Add magnets (i.e. 'visual edge ports') to the visual node. 'sides' or '' for no magnets.</xd:param>
   <xd:param name="draw-stroke">YES, NO</xd:param>
   <xd:param name="stroke-color">space-delimited rgb [0,1] e.g. ".98 1 .98"</xd:param>
   <xd:param name="stroke-style"></xd:param>
   <xd:param name="stroke-width"></xd:param>
   <xd:param name="draw-shadow">YES, NO</xd:param>
   <xd:param name="draw-fill">YES, NO</xd:param>
   <xd:param name="fill-color">space-delimited rgb [0,1] e.g. ".98 .98 .98" alpha optional: ".5 .25 0 .17"</xd:param>
   <xd:param name="font-color">space-delimited rgb [0,1] e.g. ".98 .98 .98"</xd:param>

   <xd:param name="label"></xd:param>
   <xd:param name="label-rtf"></xd:param>
   <xd:param name="fit-text">'', 'Clip', or 'Vertical' (Resize-to-fit, Clip, Vertical) GUI:("Overflow","Clip","Resize to fit")</xd:param>
   <xd:param name="wrap-text">'true' or 'false'</xd:param>
   <xd:param name="h-align-text">0, '', 2, or 3 (left, center, right, justify)</xd:param>
   <xd:param name="v-align-text">0, '', 2, or 3 (top, middle, bottom)</xd:param>
   <xd:param name="h-text-pad"></xd:param>
   <xd:param name="v-text-pad"></xd:param>
   <xd:param name="url"></xd:param>
   <xd:param name="notes"></xd:param>
   <xd:param name="a-root"></xd:param>
   <xd:param name="ignore">This value is ignored; it is here just to let caller evaluate an expression</xd:param>
</xd:doc>
<xsl:template name="node">

   <xsl:param name="visual-artifact-uri" required="yes"/>

   <xsl:param name="depicts"/>
   <xsl:param name="context"/>

   <xsl:param name="id"                  required="yes"/>

   <xsl:param name="uri"/>

   <xsl:param name="isDefinedBy"/>
   <xsl:param name="rdfTypes"/>

   <!-- NOTE: these defaults do not work if they are passed in empty -->

   <xsl:param name="shape" select="'Rectangle'"/>
   <xsl:param name="x"     select="'50'"/>
   <xsl:param name="y"     select="'50'"/>
   <xsl:param name="rotation"/>
   <xsl:param name="width"/>
   <xsl:param name="height"/>
   <xsl:param name="lock" select="false()"/>

   <xsl:param name="magnets"/>

   <xsl:param name="draw-stroke"/>
   <xsl:param name="stroke-color"/>
   <xsl:param name="stroke-style"/>
   <xsl:param name="stroke-width"/>
   <xsl:param name="draw-shadow"/>
   <xsl:param name="draw-fill"/>
   <xsl:param name="fill-color"/>
   <xsl:param name="font-color"/>

   <xsl:param name="label"/>
   <xsl:param name="label-rtf"/>
   <xsl:param name="fit-text"/>
   <xsl:param name="wrap-text"/>
   <xsl:param name="h-align-text"/>
   <xsl:param name="v-align-text"/>
   <xsl:param name="h-text-pad"/>
   <xsl:param name="v-text-pad"/>
   <xsl:param name="url"/>
   <xsl:param name="notes"/>
   <xsl:param name="tooltip"/>
   <xsl:param name="a-root"/>
   <xsl:param name="ignore"/>

   <xsl:message select="concat('                    2y:node vid ',$id)"/>

   <xsl:variable name="new_width"  select="if ($width)  then $width  else xfm:graffle-width-of-text( $label,$shape)"/>
   <xsl:variable name="new_height" select="if ($height) then $height else xfm:graffle-height-of-text($label,$shape)"/>

   <xsl:message select="concat('                    2y:node height=',$height, ' width=', $width,' -- new_height=',$new_height,' new_width=',$new_width)"/>

   <xsl:variable name="local-path" select="'/graphic/'"/>

   <xsl:variable name="vid">
       <xsl:choose>
          <!--xsl:when test="string-length($depicts) and string-length($context)">
             <xsl:value-of select="vsr:view-id(concat($depicts,$context))"/> 
          </xsl:when-->
          <xsl:when test="string-length($uri)">
             <xsl:value-of select="vsr:view-id($uri)"/> 
          </xsl:when>
          <xsl:when test="string-length($id)">
             <xsl:value-of select="vsr:view-id($id)"/> 
          </xsl:when>
          <xsl:otherwise>
             <xsl:value-of select="vsr:view-id('__no id giveN!')"/> 
          </xsl:otherwise>
       </xsl:choose>
   </xsl:variable>

   <xsl:variable name="local-name" select="concat($local-path,$vid)"/>

   <xsl:variable name="map">
      <shape graffle="Rectangle" vsr="http://purl.org/twc/vocab/vsr#Rectangle"/>
      <shape graffle="Rectangle" vsr="Rectangle"/>
      <shape graffle="Circle"    vsr="http://purl.org/twc/vocab/vsr#Circle"/>
      <shape graffle="Circle"    vsr="Circle"/>
      <shape graffle="Cross"     vsr="Cross"/>
   </xsl:variable>

   <xsl:variable name="node-uri" select="if ($uri) then $uri else concat($visual-artifact-uri,$local-name)"/>
   <xsl:value-of select="concat($NL,$LT,$node-uri,$GT,$NL,
                                '   a vsr:Graphic, vsr:',if ($map[shape[@vsr = $shape]]) then $map/shape[@vsr = $shape]/@graffle else 'Rectangle',';',$NL,
                                '   vsr:vid_given        ',$DQ,$id,$DQ,';',$NL,
                                if( string-length($context) = 0 ) then concat('   ',
                                   'vsr:visualContext ',$LT,$visual-artifact-uri,$GT,';',$NL) else '',
                                if( string-length($context) ) then concat('   ',
                                   'vsr:visualContext ',$LT,$context,$GT,';',$NL) else '',
                                '   vsr:vid              ',$DQ,$vid,$DQ,';',$NL,
                                '   vsr:vid_local_name   ',$DQ,$local-name,$DQ,';',$NL,
                                if( string-length($label) ) then concat('   ',
                                   'rdfs:label         ',$DQ,$DQ,$DQ,$label,$DQ,$DQ,$DQ,';',$NL) else '',
                                if( contains($depicts,':') ) then concat('   ',
                                   'vsr:depicts       ',$LT,$depicts,$GT,';',$NL) else '',
                                if( starts-with($url,'http') or starts-with($url,'file') or starts-with($url,'mailto:') ) then concat('   ',
                                   'rdfs:seeAlso      ',$LT,$url,$GT,';',$NL) else '',
                                if( $lock ) then concat('   ',
                                   'a vsr:Locked;',$NL) else '',
                                if( string-length(string($x)) ) then concat('   ',
                                   'vsr:x             ',$x,';',$NL) else '',
                                if( string-length(string($y)) ) then concat('   ',
                                   'vsr:y             ',$y,';',$NL) else '',
                                if( string-length(string($new_height)) ) then concat('   ',
                                   'vsr:height        ',$new_height,';',$NL) else '',
                                if( string-length(string($new_width)) ) then concat('   ',
                                   'vsr:width         ',$new_width,';',$NL) else '',
                                if( string-length($notes) ) then concat('   ',
                                   'dcterms:description    ',$DQ,$DQ,$DQ,$notes,$DQ,$DQ,$DQ,';',$NL) else '',
                                if( count(tokenize($fill-color,'\s')) = (3,4) or $draw-fill = ('YES', 'NO') ) then concat('   ',
                                   'vsr:fill    ',$LT,'http://purl.org/colors/rgb/',
                                                      if( count(tokenize($fill-color,'\s')) = (3,4) ) 
                                                      then 
                                                          concat( g:percentRGB2hex(tokenize($fill-color,'\s')[1]),
                                                                  g:percentRGB2hex(tokenize($fill-color,'\s')[2]),
                                                                  g:percentRGB2hex(tokenize($fill-color,'\s')[3]),
                                                                  if (count(tokenize($fill-color,'\s')) = 4) then 
                                                                     g:percentRGB2hex(tokenize($fill-color,'\s')[4]) 
                                                                  else '' )
                                                      else 
                                                         '000000'
                                                 ,$GT,';',$NL) else '',
                                if( count(tokenize($stroke-color,'\s')) = 3 or $stroke-style or $stroke-width or $draw-stroke='YES' ) then concat('  ',
                                   'vsr:stroke ',$LT,$node-uri,'/stroke',$GT,';',$NL) else '',
                                if( string-length($visual-artifact-uri) ) then concat('   ',
                                   'vsr:originatingVisualArtifact ',$LT,$visual-artifact-uri,$GT,';',$NL) else '',
                                '.',$NL
                                 )"/> 
   <!-- TODO: merge id and uri -->
     <!--(: vsr:originatingVisualForm is not necessary when done as a concrete graphical target :)
     (: TODO: curieTypeList:)
-->

   <!--dict-->
      <!-- CONVERTED key>ID</key>
      <integer> <xsl:value-of select="vsr:view-id($id)"/> </integer-->

      <!-- CONVERTED xsl:if test="$lock">
         <key>IsLocked</key>
         <string>YES</string>
      </xsl:if-->

      <!-- CONVERTED key>Class</key>
      <string>ShapedGraphic</string-->

      <!-- 
         2013 Jan
         GUI('Overflow')      exhibits no FitText      /     Flow          attributes
         GUI('Clip')          exhibits    FitText='Clip'     Flow='Clip'   attributes
         GUI('Resize to fit') exhibits    FitText='Vertical' Flow='Resize' attributes
      -->
      <!-- TODO NOT CONVERTED xsl:choose>
         <xsl:when test="$fit-text = 'Overflow'">
         </xsl:when>
         <xsl:when test="$fit-text = ('Clip', 'Vertical')">
            <key>FitText</key>
            <string> <xsl:value-of select="$fit-text"/> </string>
            <key>Flow</key>
            <string> <xsl:value-of select="if ($fit-text = 'Vertical') then 'Resize' else $fit-text"/> </string>
         </xsl:when>
         <xsl:otherwise>
            <key>FitText</key>
            <string>Vertical</string>
            <key>Flow</key>
            <string>Resize</string>
         </xsl:otherwise>
      </xsl:choose-->

      <!-- 
         GUI('Wrap to shape') checkbox   checked exhibits no Wrap      attribute 
         GUI('Wrap to shape') checkbox UNchecked exhibits    Wrap='NO' attribute 
      -->
      <!-- TODO NOT CONVERTED xsl:if test="$wrap-text != 'true'">
         <key>Wrap</key>
         <string>NO</string>
      </xsl:if-->

      <!--xsl:message select="concat($rotation,'  ',string-length($rotation))"/-->
      <!-- TODO: NOT CONVERTED xsl:if test="string-length($rotation)">
      <key>Rotation</key>
      <string> <xsl:value-of select="$rotation"/> </string>
      </xsl:if-->

      <!-- CONVERTED key>Shape</key>
      <xsl:message select="concat('               node shape=',$shape,' - ',if ($map/shape[@vsr = $shape]) then $map/shape[@vsr = $shape]/@graffle else 'Rectangle')"/>
      <string> <xsl:value-of select="if ($map[shape[@vsr = $shape]]) then $map/shape[@vsr = $shape]/@graffle else 'Rectangle'"/> </string-->

      <!--xsl:message select="concat($depicts,' height ',$height,' new_height ',$new_height)"/-->
      <!-- CONVERTED key>Bounds</key> <!- {{upper-left's X, upper-left's Y}, {{width, height}} ->
      <string> <xsl:value-of select="concat('{{',     if (string-length(string($x)))          then $x          else '50',
                                               ', ',  if (string-length(string($y)))          then $y          else '50',
                                               '}, {',if (string-length(string($new_width)))  then $new_width  else '3',
                                                ', ', if (string-length(string($new_height))) then $new_height else '3',
                                            '}}')"/> </string-->

      <!--key>Style</key>
      <dict-->
         <!-- CONVERTED xsl:if test="count(tokenize($fill-color,'\s'))= (3,4) or $draw-fill = ('YES', 'NO')">
         <key>fill</key>
         <dict>
            <xsl:if test="count(tokenize($fill-color,'\s'))= (3,4)">
            <key>Color</key>
            <dict>
               <key>r</key>
               <string><xsl:value-of select="tokenize($fill-color,'\s')[1]"/></string>
               <key>g</key>
               <string><xsl:value-of select="tokenize($fill-color,'\s')[2]"/></string>
               <key>b</key>
               <string><xsl:value-of select="tokenize($fill-color,'\s')[3]"/></string>
               <xsl:if test="count(tokenize($fill-color,'\s'))= 4">
                  <key>a</key>
                  <string><xsl:value-of select="tokenize($fill-color,'\s')[4]"/></string>
               </xsl:if>
            </dict>
            </xsl:if>
            <xsl:if test="$draw-fill = ('YES', 'NO')">
               <key>Draws</key>
               <string> <xsl:value-of select="$draw-fill"/> </string>
            </xsl:if>
         </dict>
         </xsl:if-->

         <!-- NO NEED TO CONVERT key>shadow</key>
         <dict>
            <key>Draws</key>
            <string>NO</string>
            <!-string> <xsl:value-of select="$draw-shadow"/> </string it's too much drain on omnigraffle... ->
         </dict-->

         <xsl:if test="count(tokenize($stroke-color,'\s')) = 3 or $stroke-style or $stroke-width or $draw-stroke='YES'">
            <xsl:value-of select="concat($NL,$LT,$node-uri,'/stroke',$GT,$NL,
                                         '   a vsr:Graphic;',$NL,
                                         '   a vsr:',if ($draw-stroke='YES' or string-length($stroke-color) gt 0 or string-length($label) = 0) then 'V' else 'Inv','isible;',$NL,
                                         if( count(tokenize($stroke-color,'\s')) = (3,4) or $draw-fill = ('YES', 'NO') ) then concat(
                                         '   vsr:fill    ',$LT,'http://purl.org/colors/rgb/',
                                                               if( count(tokenize($stroke-color,'\s')) = (3,4) ) 
                                                               then 
                                                                   concat( g:percentRGB2hex(tokenize($stroke-color,'\s')[1]),
                                                                           g:percentRGB2hex(tokenize($stroke-color,'\s')[2]),
                                                                           g:percentRGB2hex(tokenize($stroke-color,'\s')[3]),
                                                                           if (count(tokenize($stroke-color,'\s')) = 4) then 
                                                                              g:percentRGB2hex(tokenize($stroke-color,'\s')[4]) 
                                                                           else '' )
                                                               else 
                                                                  '000000'
                                                          ,$GT,';',$NL) else '',
                                         if( $stroke-style ) then concat(
                                         '   vsr:stipple   vsr:stipple_todo_',$stroke-style,';',$NL) else '',
                                         if( $stroke-width ) then concat(
                                         '   vsr:width   ',$stroke-width,';',$NL) else '',
                                         '.',$NL)"/>
           <!-- CONVERTED key>stroke</key>
           <dict>
              <!- CONVERTED xsl:if test="count(tokenize($stroke-color,'\s')) = 3">
                 <key>Color</key>
                 <dict>
                    <key>r</key>
                    <string> <xsl:value-of select="tokenize($stroke-color,'\s')[1]"/> </string>
                    <key>g</key>
                    <string> <xsl:value-of select="tokenize($stroke-color,'\s')[2]"/> </string>
                    <key>b</key>
                    <string> <xsl:value-of select="tokenize($stroke-color,'\s')[3]"/> </string>
                  </dict>
               </xsl:if->

               <xsl:if test="$stroke-style and number($stroke-style) = 1 to 24">
                 <key>Pattern</key>
                 <integer> <xsl:value-of select="$stroke-style"/> </integer>
               </xsl:if>

               <xsl:if test="$stroke-width and number($stroke-width) = 1 to 5">
                 <key>Width</key>
                 <real> <xsl:value-of select="$stroke-width"/> </real>
               </xsl:if>

               <key>Draws</key>
               <string> <xsl:value-of select="if ($draw-stroke='YES' or string-length($stroke-color) gt 0 
                                                  or string-length($label) = 0) then 'YES' else 'NO'"/> </string>
            </dict-->
         </xsl:if>
      <!--/dict-->

      <xsl:if test="$label or $label-rtf">
         <!-- TODO: NOT CONVERTED xsl:if test="$font-color and not(string-length($label-rtf))">
            <key>FontInfo</key>
            <dict>
               <key>Color</key>
               <dict>
                  <key>r</key>
                  <string> <xsl:value-of select="tokenize($font-color,'\s')[1]"/> </string>
                  <key>g</key>
                  <string> <xsl:value-of select="tokenize($font-color,'\s')[2]"/> </string>
                  <key>b</key>
                  <string> <xsl:value-of select="tokenize($font-color,'\s')[3]"/> </string>
               </dict>
            </dict>
         </xsl:if-->

         <!-- CONVERTED, but TODO: un-pack RTF into pure label and assert. key>Text</key>
         <dict>
            <xsl:if test="number($h-align-text) = (0,2,3)">
               <key>Align</key>
               <integer><xsl:value-of select="$h-align-text"/></integer>
            </xsl:if>
            <key>Pad</key>
            <integer><xsl:value-of select="if ($h-text-pad and number($h-text-pad)) then $h-text-pad else 2"/></integer>
            <key>Text</key>
            <string><xsl:value-of select="if (string-length($label-rtf)) then $label-rtf else xfm:rtf($label,$font-color)"/></string>
            <key>VerticalPad</key>
            <integer><xsl:value-of select="if ($v-text-pad and number($v-text-pad)) then $v-text-pad else 2"/></integer>
         </dict-->
      </xsl:if>

      <!-- CONVERTED xsl:if test="$notes">
         <key>Notes</key>
         <string>
           <xsl:value-of select="xfm:rtf($notes)"/>
         </string>
      </xsl:if-->

      <!-- CONVERTED xsl:if test="$url">
         <key>Link</key>
         <dict>
            <key>url</key>
            <string> <xsl:value-of select="$url"/> </string>
         </dict>
      </xsl:if-->

      <!-- TODO: NOT CONVERTED xsl:if test="$magnets = 'sides'">
         <key>Magnets</key>
         <array>
            <string>{1, 0}</string>
            <string>{-1, 0}</string>
         </array>
      </xsl:if-->

      <!-- TODO: NOT CONVERTED xsl:if test="number($v-align-text) = (0,2)">
         <key>TextPlacement</key>
         <integer> <xsl:value-of select="$v-align-text"/> </integer>
      </xsl:if-->

      <!-- CONVERTED key>UserInfo</key>
      <dict>
         <xsl:if test="string-length($visual-artifact-uri)">
            <key>http://open.vocab.org/terms/originatingVisualArtifact</key>
            <string> <xsl:value-of select="$visual-artifact-uri"/> </string>
            <xsl:if test="string-length($context) = 0">
               <key>http://open.vocab.org/terms/visualContext</key>
               <string> <xsl:value-of select="$visual-artifact-uri"/> </string>
            </xsl:if>
         </xsl:if>

         <key>http://open.vocab.org/terms/vid_local_name</key>
         <string> <xsl:value-of select="$local-name"/> </string>

         <key>http://open.vocab.org/terms/originatingVisualForm</key>
         <string> <xsl:value-of select="if ($uri) then $uri else concat($visual-artifact-uri,$local-name)"/> </string>   <!- TODO: merge id and uri ->

         <xsl:if test="string-length($depicts)"><!- and not($depicts = ('[]','bnode','blank node'))"->
            <xsl:choose>
               <xsl:when test="contains($depicts,':')">                          <!- URI ->
                  <key>http://purl.org/twc/vocab/vsr#depicts</key>            
                  <string> <xsl:value-of select="$depicts"/> </string>
               </xsl:when>
               <xsl:otherwise>
                  <key>http://open.vocab.org/terms/depictsBlank</key> <!- i.e. dc:identifier ->
                  <string> <xsl:value-of select="$depicts"/> </string>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:if>

         <xsl:if test="string-length($context)">
            <!- NOTE: if empty, defaults to $visual-artifact-uri above.
                 NONE should be asserted if both are empty. ->
            <key>http://open.vocab.org/terms/visualContext</key>
            <string> <xsl:value-of select="$context"/> </string>
         </xsl:if>

         <xsl:if test="string-length($rdfTypes)">
            <key>http://open.vocab.org/terms/curieTypeList</key>
            <string> <xsl:value-of select="$rdfTypes"/> </string>
         </xsl:if>

         <xsl:if test="string-length($id)">
            <key>http://open.vocab.org/terms/vid_given</key>
            <string> <xsl:value-of select="$id"/> </string>
         </xsl:if>

         <key>http://open.vocab.org/terms/vid</key>
         <string> <xsl:value-of select="$vid"/> </string>

         <!-xsl:if test="string-length($isDefinedBy)">
            <key>http://www.w3.org/2000/01/rdf-schema#isDefinedBy</key>
            <string> <xsl:value-of select="$isDefinedBy"/> </string>
         </xsl:if->
      </dict-->

   <!--/dict-->
</xsl:template>

<xd:doc>
<xd:short>Render a visual edge from visual node <tt>from</tt> to visual node <tt>to</tt>.</xd:short>
<xd:detail>
</xd:detail>
<xd:param name="id">A client-side string that uniquely identifies this visual edge. Value will be transformed into identifier appropriate for OmniGraffle.</xd:param>
<xd:param name="from">The visual node <b>from</b> which to draw this visual edge.</xd:param>
<xd:param name="to">The visual node <b>to</b> which to draw this visual edge.</xd:param>
<xd:param name="uri">The Uniform Resource Identifier (URI) of this visual edge.</xd:param>
<xd:param name="depicts">The rdf:Predicate whose relation is being depicted by this visual edge.</xd:param>
<xd:param name="label">The graphical label to place on this visual edge.</xd:param>
<xd:param name="font-color">The color of the font to use for <tt>label</tt>.</xd:param>
<xd:param name="notes">Text to associate with this visual edge.</xd:param>
<xd:param name="url"></xd:param>
<xd:param name="draw-shadow">Draw this visual edge with a shadow? ('YES' or 'NO'; default 'NO')</xd:param>
<xd:param name="head-style">The arrow style of this visual edge's head. "FilledArrow" is default, "NonNavigable" is an X on end.</xd:param>
<xd:param name="tail-style">The arrow style of this visual edge's tail. "FilledArrow" is default, "NonNavigable" is an X on end.</xd:param>
<xd:param name="line-width">The width of this visual edge. "2" for slightly larger than default.</xd:param>
<xd:param name="line-style">The stipple pattern of the visual edge (1 to 24, 1 solid, 2 dashed, 3 dotted).</xd:param>
<xd:param name="stroke-color">The color of this visual edge. Single value to duplicate for RGB (TODO: handle one or 3)</xd:param>
</xd:doc>
<xsl:template name="edge"> <!-- this was named graffle-edge. Making a generic "edge" that maps to graffle-edge would help interoperability. -->
   <xsl:param name="id"   required="yes"/>
   <xsl:param name="from" required="yes"/>
   <xsl:param name="to"   required="yes"/>

   <xsl:param name="uri"/>
   <xsl:param name="depicts"/>

   <xsl:param name="label"/>
   <xsl:param name="font-color"/>

   <xsl:param name="notes"/>
   <xsl:param name="url"/>

   <xsl:param name="draw-shadow" select="'NO'"/>
   <xsl:param name="head-style"  select="'FilledArrow'"/>
   <xsl:param name="tail-style"  select="'0'"/>
   <xsl:param name="line-width"/>
   <xsl:param name="line-style"/>
   <xsl:param name="stroke-color">0.701961</xsl:param>

   <xsl:message select="concat('               2y:edge given id       ',$id)"/>
   <xsl:message select="concat('               2y:edge given depicts  ',$depicts)"/>
   <xsl:message select="concat('               2y:edge given from vid ',$from)"/>
   <xsl:message select="concat('               2y:edge given to   vid ',$to)"/>

   <xsl:value-of select="concat($NL,$LT,$uri,$GT,$NL,
                                '   a vsr:Graphic, vsr:Connection;',$NL,
                                '   vsr:vid              ',$DQ,vsr:view-id($id),$DQ,';',$NL,
                                if( string-length($label) ) then concat('   ',
                                   'rdfs:label         ',$DQ,$DQ,$DQ,$label,$DQ,$DQ,$DQ,';',$NL) else '',
                                if( contains($depicts,':') ) then concat('   ',
                                   'vsr:depicts       ',$LT,$depicts,$GT,';',$NL) else '',
                                if( starts-with($url,'http') or starts-with($url,'file') or starts-with($url,'mailto:') ) then concat('   ',
                                   'rdfs:seeAlso      ',$LT,$url,$GT,';',$NL) else '',
                                if( string-length(string($line-width)) ) then concat('   ',
                                   'vsr:width         ',$line-width,';',$NL) else '',
                                if( string-length($notes) ) then concat('   ',
                                   'dcterms:description    ',$DQ,$DQ,$DQ,$notes,$DQ,$DQ,$DQ,';',$NL) else '',
                                if( $stroke-color ) then concat('   ',
                                   'vsr:fill    ',$LT,'http://purl.org/colors/rgb/',
                                                          g:percentRGB2hex($stroke-color),
                                                          g:percentRGB2hex($stroke-color),
                                                          g:percentRGB2hex($stroke-color)
                                                 ,$GT,';',$NL) else '',
                                '.',$NL
                                 )"/> 
<dict>
   <key>ID</key>
   <integer> <xsl:value-of select="vsr:view-id($id)"/> </integer>

   <key>UserInfo</key>
   <dict>
         <xsl:if test="string-length($uri)">
            <key>http://www.w3.org/2002/07/owl#sameAs</key>
            <string> <xsl:value-of select="$uri"/> </string>
         </xsl:if>
         <xsl:if test="string-length($depicts)">
            <key>http://purl.org/twc/vocab/vsr#depicts</key>
            <string> <xsl:value-of select="$depicts"/> </string>
         </xsl:if>
   </dict>

   <key>AllowLabelDrop</key>
   <false/>

      <key>Class</key>
      <string>LineGraphic</string>

      <key>Tail</key>
      <dict>
         <key>ID</key>
         <integer> <xsl:value-of select="vsr:view-id($from)"/> </integer>
      </dict>

      <key>Head</key>
      <dict>
         <key>ID</key>
         <integer> <xsl:value-of select="vsr:view-id($to)"/> </integer>
      </dict>

      <xsl:if test="$notes">
         <key>Notes</key>
         <string>
           <xsl:value-of select="xfm:rtf($notes)"/>
         </string>
      </xsl:if>

      <xsl:if test="$url">
         <key>Link</key>
         <dict>
            <key>url</key>
            <string> <xsl:value-of select="$url"/> </string>
         </dict>
      </xsl:if>

      <key>Style</key>
      <dict>
         <xsl:if test="$draw-shadow = 'YES-NO-IT-IS-TOO-SLOW'">
            <key>shadow</key>
            <dict>
               <key>Draws</key>
               <string>YES</string>
            </dict>
         </xsl:if>

         <key>stroke</key>
         <dict>

            <xsl:if test="count(tokenize(xs:string($stroke-color),'\s')) = (1,3)">
               <key>Color</key>
               <dict>
                  <key>r</key>
                  <string> <xsl:value-of select="tokenize(xs:string($stroke-color),'\s')[1]"/> </string>
                  <key>g</key>
                  <string> <xsl:value-of select="if (count(tokenize(xs:string($stroke-color),'\s')) = 3) 
                                                 then tokenize(xs:string($stroke-color),'\s')[2] 
                                                 else tokenize(xs:string($stroke-color),'\s')[1]"/> </string>
                  <key>b</key>
                  <string> <xsl:value-of select="if (count(tokenize(xs:string($stroke-color),'\s')) = 3) 
                                                 then tokenize(xs:string($stroke-color),'\s')[3] 
                                                 else tokenize(xs:string($stroke-color),'\s')[1]"/> </string>
               </dict>
            </xsl:if>

            <key>HeadArrow</key>
            <string> <xsl:value-of select="$head-style"/> </string>

            <key>LineType</key>
            <integer>1</integer>

            <xsl:if test="number($line-style) = (1 to 24)">
               <key>Pattern</key>
               <integer> <xsl:value-of select="$line-style"/> </integer>
            </xsl:if>

            <xsl:if test="number($line-width) > 0">
               <key>Width</key>
               <integer> <xsl:value-of select="$line-width"/> </integer>
            </xsl:if>

            <key>TailArrow</key>
            <string> <xsl:value-of select="$tail-style"/> </string>
         </dict>
      </dict>
   </dict>

   <xsl:if test="$label">
      <!-- add an entire new dict entry for the label object that points to the linegraphic made above -->
      <dict>
         <key>Bounds</key>
         <string>{{201.388, 124.248}, {75, 14}}</string>

         <key>Class</key>
         <string>ShapedGraphic</string>

         <key>FitText</key>
         <string>YES</string>

         <key>FontInfo</key>
         <dict>
            <key>Color</key>
            <dict>
               <key>w</key>
               <string>0</string>
            </dict>
            <key>Font</key>
            <string>Courier</string>
            <key>Size</key>
            <real>12</real>
         </dict>

         <key>ID</key>
         <integer> 
            <xsl:value-of select="vsr:view-id(concat($id,'s_AUTO_LABEL'))"/> <!-- This is a new ID for the text graphic --> 
         </integer> 

         <key>Line</key>
         <dict>
            <key>ID</key>
            <integer>
               <xsl:value-of select="vsr:view-id($id)"/> <!-- This is where the text graphic points to the line it is on -->
            </integer> 

            <key>Position</key>
            <real>0.43251731991767883</real>

            <key>RotationType</key>
            <integer>0</integer>
         </dict>

         <key>Shape</key>
         <string>Rectangle</string>

         <key>Style</key>
         <dict>
            <key>shadow</key>
            <dict>
               <key>Draws</key>
               <string>NO</string>
            </dict>
            <key>stroke</key>
            <dict>
               <key>Draws</key>
               <string>NO</string>
            </dict>
         </dict>

         <key>Text</key>
         <dict>
            <key>Pad</key>
            <integer>2</integer>
            <key>Text</key>
            <string> <xsl:value-of select="xfm:rtf($label,$font-color)"/> </string>
            <key>VerticalPad</key>
            <integer>2</integer>
         </dict>
      </dict>
   </xsl:if>

</xsl:template>

<xd:doc>
   <xd:short>Colloquial terms for OmniGraffle's line stipple pattern codes.</xd:short>
   <xd:detail>
   </xd:detail>
</xd:doc>
<xsl:variable name="line-styles">
   <!-- how to use: integer> <xsl:value-of select="$line-styles/line-style[@canonical=$line-style]/@graffle-code"/> </integer-->
  <line-style canonical="solid"  letter-label="a" graffle-code=""/>
  <line-style canonical="dashed" letter-label="b" graffle-code="2"/>
  <line-style canonical="dotted" letter-label="c" graffle-code="3"/>
  <line-style canonical="" letter-label="d" graffle-code="4"/>
  <line-style canonical="" letter-label="e" graffle-code="5"/>
  <line-style canonical="" letter-label="f" graffle-code="6"/>
  <line-style canonical="" letter-label="g" graffle-code="7"/>
  <line-style canonical="" letter-label="h" graffle-code="8"/>
  <line-style canonical="" letter-label="i" graffle-code="9"/>
  <line-style canonical="" letter-label="j" graffle-code="10"/>
  <line-style canonical="" letter-label="k" graffle-code="11"/>
  <line-style canonical="" letter-label="l" graffle-code="12"/>
  <line-style canonical="" letter-label="m" graffle-code="13"/>
  <line-style canonical="" letter-label="n" graffle-code="14"/>
  <line-style canonical="" letter-label="o" graffle-code="15"/>
  <line-style canonical="" letter-label="p" graffle-code="16"/>
  <line-style canonical="" letter-label="q" graffle-code="17"/>
  <line-style canonical="" letter-label="r" graffle-code="18"/>
  <line-style canonical="" letter-label="s" graffle-code="19"/>
  <line-style canonical="" letter-label="t" graffle-code="20"/>
  <line-style canonical="" letter-label="u" graffle-code="21"/>
  <line-style canonical="" letter-label="v" graffle-code="22"/>
  <line-style canonical="" letter-label="w" graffle-code="23"/>
  <line-style canonical="" letter-label="x" graffle-code="24"/>
</xsl:variable>

<xd:doc>
   <xd:short>Orphaned?</xd:short>
   <xd:detail>This template does not appear to be called by anything. It could be an unfinished stub, or an outdated orphan.
   </xd:detail>
   <xd:param name="id">The client-side identifier for this visual node.</xd:param>
</xd:doc>
<xsl:template name="graffle-polygon">
   <xsl:param name="id" required="yes"/>

   <dict>
      <key>Bounds</key>
      <string>{{115, 98}, {200, 184}}</string>
      <key>Class</key>
      <string>ShapedGraphic</string>
      <key>ID</key>
      <integer> <xsl:value-of select="vsr:view-id($id)"/> </integer>
      <key>Shape</key>
      <string>Bezier</string>
      <key>ShapeData</key>
      <dict>
         <key>UnitPoints</key>
         <array>
            <string>{-0.185, -0.5}</string>
            <string>{-0.185, -0.5}</string>
            <string>{0.5, -0.402174}</string>
            <string>{0.5, -0.402174}</string>
            <string>{0.5, -0.402174}</string>
            <string>{0.41, 0.353261}</string>
            <string>{0.41, 0.353261}</string>
            <string>{0.41, 0.353261}</string>
            <string>{-0.5, 0.5}</string>
            <string>{-0.5, 0.5}</string>
            <string>{-0.5, 0.5}</string>
            <string>{-0.255, 0.141304}</string>
            <string>{-0.255, 0.141304}</string>
            <string>{-0.255, 0.141304}</string>
            <string>{-0.44, -0.00543475}</string>
            <string>{-0.44, -0.00543475}</string>
            <string>{-0.44, -0.00543475}</string>
            <string>{-0.185, -0.5}</string>
         </array>
      </dict>
      <key>Style</key>
      <dict>
         <key>fill</key>
         <dict>
            <key>Color</key>
            <dict>
               <key>a</key>
               <string>0.5</string>
               <key>b</key>
               <string>0</string>
               <key>g</key>
               <string>0</string>
               <key>r</key>
               <string>1</string>
            </dict>
            <key>GradientColor</key>
            <dict>
               <key>w</key>
               <string>0.666667</string>
            </dict>
         </dict>
      </dict>
   </dict>
</xsl:template>

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>
   </xd:detail>
   <xd:param name="text"></xd:param>
</xd:doc>
<xsl:function name="xfm:width-of-text">
   <xsl:param name="text"/>
   <xsl:value-of select="xfm:graffle-width-of-text($text,'Rectangle')"/>
</xsl:function>

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>
   </xd:detail>
   <xd:param name="text"></xd:param>
   <xd:param name="shape"></xd:param>
</xd:doc>
<xsl:function name="xfm:graffle-width-of-text">
  <xsl:param name="text"/>
  <xsl:param name="shape"/>
   <xsl:choose>
     <xsl:when test="$shape = 'Rectangle'">
         <!--xsl:message select="concat(string-length($text),' ',7 * string-length($text) + 10,' ',$text)"/-->
         <xsl:value-of select="7 * string-length($text) + 30"/>
      </xsl:when>
     <xsl:when test="$shape = 'Circle'">
         <xsl:value-of select="9 * string-length($text) + 25"/>
      </xsl:when>
     <xsl:otherwise>
      </xsl:otherwise>
   </xsl:choose>
</xsl:function>

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>
   </xd:detail>
   <xd:param name="text"></xd:param>
   <xd:param name="shape"></xd:param>
</xd:doc>
<xsl:function name="xfm:graffle-height-of-text">
  <xsl:param name="text"/>
  <xsl:param name="shape"/>
   <xsl:choose>
     <xsl:when test="$shape = 'Rectangle'">
         <xsl:value-of select="36"/>
      </xsl:when>
     <xsl:when test="$shape = 'Circle'">
         <xsl:value-of select="30"/>
      </xsl:when>
     <xsl:otherwise>
      </xsl:otherwise>
   </xsl:choose>
</xsl:function>

<xd:doc>
   <xd:short></xd:short>
   <xd:detail>Constant for heuristic calculations.
   </xd:detail>
</xd:doc>
<xsl:variable name="xfm:graffle-height-of-rectangle-text" select='36'/>
<xd:doc>
   <xd:short></xd:short>
   <xd:detail>Constant for heuristic calculations.
   </xd:detail>
</xd:doc>
<xsl:variable name="xfm:graffle-height-of-circle-text"    select='30'/>

<xsl:function name="g:percentRGB2hex" as="xs:string">
   <xsl:param name="percentage"/> <!-- as="xs:double"/-->
   <xsl:variable name="hex" select="msg20090200215:int-to-hex(xs:integer(floor(xs:decimal($percentage) * 255)))"/>
   <xsl:value-of select="if( string-length($hex) lt 2 ) then concat('0',$hex) else $hex"/>
</xsl:function>

<xsl:function name="g:percent2_0_255" as="xs:string">
   <xsl:param name="percentage"/> <!-- as="xs:double"/-->
   <xsl:variable name="dec" select="xs:integer(floor($percentage * 255))"/>
   <xsl:value-of select="$dec"/>
</xsl:function>

<!--
#3> <> prov:wasDerivedFrom <https://github.com/timrdf/vsr/blob/master/src/xsl/grddl/graffle.xsl>,
#3>      [ prov:wasQuotedFrom <http://www.oxygenxml.com/archives/xsl-list/200902/msg00215.html> ] .
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
