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
   <xd:short></xd:short>
   <xd:detail>
   </xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- 
   - Arrive at resource
 -->
<xd:doc>
   <xd:short>Report that a template is processing a Resource (i.e., RDF Node).</xd:short>
   <xd:detail>
   </xd:detail>
   <xd:param name="actor">
      The URI of the XSL template that is processing the Resource.
   </xd:param>
   <xd:param name="resource" type="xs:string">
      The URI of the Resource being visited.
   </xd:param>
</xd:doc>
<xsl:function name="acv:arriveResource">
   <xsl:param name="actor"/>
   <xsl:param name="resource" as="xs:string"/>
   <xsl:param name="deferrer" as="xs:string"/>

   <xsl:value-of select="acv:arriveResource($actor,$resource,$deferrer,'')"/>
</xsl:function>


<!-- 
   - Arrive at resource
 -->
<xd:doc>
   <xd:short>Report that a template is processing a Resource (i.e., RDF Node).</xd:short>
   <xd:detail>
   </xd:detail>
   <xd:param name="actor">
      The URI of the XSL template that is processing the Resource.
   </xd:param>
   <xd:param name="resource" type="xs:string">
      The URI of the Resource being visited.
   </xd:param>
   <xd:param name="deferrer" type="xs:string">
      The handler that called this handler.
   </xd:param>
   <xd:param name="indent">
   </xd:param>
</xd:doc>
<xsl:function name="acv:arriveResource">
   <xsl:param name="actor"/>
   <xsl:param name="resource" as="xs:string"/>
   <xsl:param name="deferrer"/>
   <xsl:param name="indent"/>

   <xsl:variable name="visitToken">
      <xsl:choose>
         <xsl:when test="$log-visual-decisions">
            <xsl:value-of select="log:arriveResource($log,$actor,$resource,$deferrer)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="''"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:value-of select="concat($indent,pmm:tryQName($resource),' ( ® ',pmm:bestLocalName($actor),' o.b.o. ',pmm:bestLocalName($deferrer),') ',$visitToken)"/>
</xsl:function>


<!-- 
   - Arrive at triple
 -->
<xd:doc>
   <xd:short>Report that a template is processing a triple.</xd:short>
   <xd:detail>
   </xd:detail>
   <xd:param name="actor"     type="xs:string">
      The URI of the XSL template that is processing the Resource.
   </xd:param>
   <xd:param name="subject"   type="xs:string">
      The subject of the triple (URI)
   </xd:param>
   <xd:param name="predicate" type="xs:string">
      The predicate of the triple (URI).
   </xd:param>
   <xd:param name="object"    type="xs:string">
      The object of the triple (URI or literal).
   </xd:param>
</xd:doc>
<xsl:function name="acv:arriveTriple">
   <xsl:param name="actor"     as="xs:string"/>
   <xsl:param name="subject"   as="xs:string"/>
   <xsl:param name="predicate" as="xs:string"/>
   <xsl:param name="object"    as="xs:string"/>
   <xsl:param name="deferrer"  as="xs:string"/>

   <xsl:variable name="visitToken">
      <xsl:choose>
         <xsl:when test="$log-visual-decisions">
            <xsl:value-of select="log:arriveTriple($log,$actor,$subject,$predicate,$object,$deferrer)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="'[]'"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="space" select="concat($in,$in,$in,$in,$in,$in,$in,$in,$in,$in,$in,$in,$in,$in)"/>

   <xsl:value-of select="concat($in, pmm:tryQName($predicate), $in,pmm:tryQName($object),' . ',
                                '( ®~o ',pmm:bestLocalName($actor),' o.b.o. ',pmm:bestLocalName($deferrer),' ) ',$visitToken)"/>
</xsl:function>

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 100 -->

<!-- 
   - Arrive at triple with no object
 -->
<xd:doc>
   <xd:short>Report that a template is processing a triple (omit reporting the object).</xd:short>
   <xd:detail>
   </xd:detail>
   <xd:param name="actor"     type="xs:string">
      The URI of the XSL template that is processing the Resource.
   </xd:param>
   <xd:param name="subject"   type="xs:string">
      The subject of the triple (URI)
   </xd:param>
   <xd:param name="predicate" type="xs:string">
      The predicate of the triple (URI).
   </xd:param>
</xd:doc>
<xsl:function name="acv:arriveTriple">
   <xsl:param name="actor"     as="xs:string"/>
   <xsl:param name="subject"   as="xs:string"/>
   <xsl:param name="predicate" as="xs:string"/>
   <xsl:param name="deferrer"  as="xs:string"/>

   <xsl:variable name="decisionURI">
      <xsl:choose>
         <xsl:when test="$log-visual-decisions">
            <xsl:value-of select="log:arriveTriple($log,$actor,$subject,$predicate,$deferrer)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="'[]'"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="space" select="concat($in,$in,$in,$in,$in,$in,$in,$in,$in,$in,$in,$in,$in,$in)"/>

   <xsl:value-of select="concat($in,pmm:tryQName($predicate),$in,$DQ,$DQ,' . ',
                                '( ®~ ',pmm:bestLocalName($actor),')')"/>
</xsl:function>


<!-- 
   - Explain subject function 
 -->
<xd:doc>
   <xd:short>Report a justification for an actor performing a visual mapping decision for a domain resource.</xd:short>
   <xd:detail>
   </xd:detail>
   <xd:param name="subject"         type="xs:string">
      The domain form that is depicted by <span class="paramName">visual-form-uri</span>.
   </xd:param>
   <xd:param name="actor"           type="xs:string">
      The URI of the template that determined 
      <span class="paramName">property</span>=<span class="paramName">value</span> for 
      <span class="paramName">visual-form-uri</span>.
   </xd:param>
   <xd:param name="action"          type="xs:string">
      The action that <span class="paramName">actor</span> took when 
      deciding something about <span class="paramName">visual-form-uri</span>.
   </xd:param>
   <xd:param name="visual-form-uri" type="xs:string">
      The URI of the visual element depicting <span class="paramName">subject</span>.
   </xd:param>
   <xd:param name="justification"   type="xs:string">
      The reason that <span class="paramName">actor</span> took the <span class="paramName">action</span>.
   </xd:param>
</xd:doc>
<xsl:function name="acv:explainResource">
   <xsl:param name="subject"         as="xs:string"/>
   <xsl:param name="actor"           as="xs:string"/>
   <xsl:param name="action"          as="xs:string"/>
   <xsl:param name="visual-form-uri" as="xs:string"/>
   <xsl:param name="justification"   as="xs:string"/>

  <!--xsl:variable name="description" select="concat(pmm:tryQName($subject),$NL,$in,pmm:tryQName($actor),': ',
                                              pmm:tryQName($action),' b/c ',pmm:tryQName($justification))"/-->
   <xsl:variable name="description" select="concat(
      $in, pmm:tryQName($action),' [b/c ',pmm:tryQName($justification),'] ( x®A ',pmm:bestLocalName($actor),' )')"/>

   <xsl:variable name="decisionURI">
      <xsl:choose>
         <xsl:when test="$log-visual-decisions">
            <xsl:value-of select="log:explainResource($log,
                                    $subject,$actor,$action,$visual-form-uri,$justification,$description)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="'[]'"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:value-of select="concat($description,' (decision # ',pmm:bestLocalName($decisionURI),')')"/>
</xsl:function>

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 100 -->


<!-- 
   - Explain subject function  (should replace explainResource with action param, now broken into attr-val)
 -->
<xd:doc>
   <xd:short>Report a justification for deciding why a visual element has a certain visual property.</xd:short>
   <xd:detail>
      This could be considered a special case of 
      acv:explainResource(subject, actor, action, visual-form-uri, justification). 
      Note that the <b>property</b> and <b>value</b> parameters on this function are 
      analogous to the <b>action</b> parameter in the other.
   </xd:detail>
   <xd:param name="subject"         type="xs:string">
      The domain form that is depicted by <span class="paramName">visual-form-uri</span>.
   </xd:param>
   <xd:param name="actor"           type="xs:string">
      The URI of the template that determined <span class="paramName">property</span> 
      <span class="paramName">value</span> for <span class="paramName">visual-form-uri</span>.
   </xd:param>
   <xd:param name="property"        type="xs:string">
      The property of <span class="paramName">visual-form-uri</span> that 
      <span class="paramName">actor</span> decided.
   </xd:param>
   <xd:param name="value"           type="xs:string">
      The value of <span class="paramName">property</span> of the 
      <span class="paramName">visual-form-uri</span>.
   </xd:param>
   <xd:param name="visual-form-uri" type="xs:string">
      The URI of the visual element depicting <span class="paramName">subject</span>.
   </xd:param>
   <xd:param name="justification"   type="xs:string">
      The reason that <span class="paramName">actor</span> determined that 
      <span class="paramName">visual-form-uri</span> 
      should have <span class="paramName">property</span>=<span class="paramName">value</span>.
   </xd:param>
</xd:doc>
<xsl:function name="acv:explainResource">
   <xsl:param name="subject"         as="xs:string"/>
   <xsl:param name="actor"           as="xs:string"/>
   <xsl:param name="property"        as="xs:string"/>
   <xsl:param name="value"           as="xs:string"/>
   <xsl:param name="visual-form-uri" as="xs:string"/>
   <xsl:param name="justification"   as="xs:string"/>
   <xsl:param name="indent"          as="xs:string"/>

   <!--xsl:variable name="description" select="concat(pmm:tryQName($subject),$NL,$in,pmm:tryQName($actor),': ',
                                             pmm:tryQName($action),' b/c ',pmm:tryQName($justification))"/-->
   <xsl:variable name="description" select="concat(
      $in, pmm:tryQName($property),' = ',pmm:tryQName($value),' [b/c ',
      pmm:tryQName($justification),'] ( x®^_ ',pmm:bestLocalName($actor),' )')"/>
   <xsl:variable name="decisionURI">
      <xsl:choose>
         <xsl:when test="$log-visual-decisions">
            <xsl:value-of select="log:explainResource($log,$subject,$actor,$property,$value,
                                    $visual-form-uri,$justification,$description)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="'[]'"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <!--xsl:value-of select="concat($indent,$description,' (decision # ',pmm:tryQName($decisionURI),')')"/-->
   <xsl:value-of select="concat($indent,$description,' (decision # ',pmm:bestLocalName($decisionURI),')')"/>
</xsl:function>

<xsl:function name="acv:explainResource">
   <xsl:param name="subject"         as="xs:string"/>
   <xsl:param name="actor"           as="xs:string"/>
   <xsl:param name="property"        as="xs:string"/>
   <xsl:param name="value"           as="xs:string"/>
   <xsl:param name="visual-form-uri" as="xs:string"/>
   <xsl:param name="justification"   as="xs:string"/>

   <xsl:value-of select="acv:explainResource($subject,$actor,$property,$value,$visual-form-uri,$justification,'')"/>
</xsl:function>

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 100 -->


<!-- 
   - Explain triple function 
 -->
<xd:doc>
   <xd:short>Report a justification for an actor performing a visual mapping decision for a domain relation.</xd:short>
   <xd:detail></xd:detail>
   <xd:param name="subject"       type="xs:string">
      The subject of the relation whose visual mapping is being considered.
   </xd:param>
   <xd:param name="predicate"     type="xs:string">
      The predicate of the relation whose visual mapping is being considered.
   </xd:param>
   <xd:param name="object"        type="xs:string">
      The object of the relation whose visual mapping is being considered.
   </xd:param>
   <xd:param name="actor"         type="xs:string">
      The URI of the template that determined the visual mapping 
      <span class="paramName">action</span> for the domain relation.
   </xd:param>
   <xd:param name="action"        type="xs:string">
      The action that <span class="paramName">actor</span> took when 
      deciding the visual mapping of the domain relation.
   </xd:param>
   <xd:param name="justification" type="xs:string">
      The reason that <span class="paramName">actor</span> took the <span class="paramName">action</span>.
   </xd:param>
</xd:doc>
<xsl:function name="acv:explainTriple"> <!-- 6 -->
   <xsl:param name="subject"       as="xs:string"/>
   <xsl:param name="predicate"     as="xs:string"/>
   <xsl:param name="object"        as="xs:string"/>

   <xsl:param name="actor"         as="xs:string"/>

   <xsl:param name="action"        as="xs:string"/> <!-- += -->
   <xsl:param name="justification" as="xs:string"/> <!-- += -->

   <xsl:variable name="description" select="concat(
      $in,$in, pmm:tryQName($action),' [b/c ',
      pmm:tryQName($justification),'] ( x®~oA ',pmm:bestLocalName($actor),' )')"/>
   <xsl:variable name="decisionURI">
      <xsl:choose>
         <xsl:when test="$log-visual-decisions"> <!-- TODO: calling the 8 param with empties on 2 -->
            <xsl:value-of select="log:explainTriple($log,$subject,$predicate,$object,
                                                         $actor,
                                                         '',$action,'',
                                                         $justification,$description)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="'[]'"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:value-of select="concat($description,', decision # ',pmm:bestLocalName($decisionURI))"/>
</xsl:function>

<!-- 
   - Explain triple function (should replace explainTriple with action param, now broken into attr-val)
 -->
<xd:doc>
   <xd:short>Report a justification for an actor performing a visual mapping decision for a domain relation.</xd:short>
   <xd:detail><b></b></xd:detail>
   <xd:param name="subject" type="xs:string">
      The subject of the relation whose visual mapping is being considered.
   </xd:param>
   <xd:param name="predicate" type="xs:string">
      The predicate of the relation whose visual mapping is being considered.
   </xd:param>
   <xd:param name="object" type="xs:string">
      The object of the relation whose visual mapping is being considered.
   </xd:param>
   <xd:param name="actor" type="xs:string">
      The URI of the template that determined the visual mapping 
      <span class="paramName">action</span> for the domain relation.
   </xd:param>
   <xd:param name="property" type="xs:string">
      The visual property of the domain relation.
   </xd:param>
   <xd:param name="value" type="xs:string">
      The value of the visual <span class="paramName">property</span> of the domain relation.
   </xd:param>
   <xd:param name="justification" type="xs:string">
      The reason that <span class="paramName">actor</span> determined that the 
      domain relation should be shown with 
      visual <span class="paramName">property</span>=<span class="paramName">value</span>.
   </xd:param>
</xd:doc>
<xsl:function name="acv:explainTriple"> <!-- 8 -->
   <xsl:param name="subject"       as="xs:string"/>
   <xsl:param name="predicate"     as="xs:string"/>
   <xsl:param name="object"        as="xs:string"/>
   <xsl:param name="actor"         as="xs:string"/>
   <xsl:param name="visualForm"    as="xs:string"/> <!-- \            -->
   <xsl:param name="property"      as="xs:string"/> <!--  |> "action" -->
   <xsl:param name="value"         as="xs:string"/> <!-- /            -->
   <xsl:param name="justification" as="xs:string"/>

   <xsl:variable name="description" select="concat(
      $in,$in, pmm:tryQName($property),' = ',$value,' [b/c ',pmm:tryQName($justification),'] ',
      '( x®~o^_ ',pmm:bestLocalName($actor),' )')"/>

   <xsl:variable name="decisionURI">
      <xsl:choose>
         <xsl:when test="$log-visual-decisions">
            <xsl:value-of select="log:explainTriple($log,
                                                    $subject, $predicate, $object,
                                                    $actor, 
                                                    $visualForm, $property, $value,
                                                    $justification, $description)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="'[]'"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:value-of select="concat($description,', decision # ',pmm:bestLocalName($decisionURI))"/>
</xsl:function>

<xd:doc>
   <xd:short>Report a justification for an actor performing a visual mapping decision for a domain relation.</xd:short>
   <xd:detail><b></b></xd:detail>
   <xd:param name="subject" type="xs:string">
      The subject of the relation whose visual mapping is being considered.
   </xd:param>
   <xd:param name="predicate" type="xs:string">
      The predicate of the relation whose visual mapping is being considered.
   </xd:param>
   <xd:param name="object" type="xs:string">
      The object of the relation whose visual mapping is being considered.
   </xd:param>
   <xd:param name="actor" type="xs:string">
      The URI of the template that determined the visual mapping 
      <span class="paramName">action</span> for the domain relation.
   </xd:param>
   <xd:param name="visualForm" type="xs:string">
      The visual property of the domain relation.
   </xd:param>
   <xd:param name="from_domain" type="xs:string">
      ??? <span class="paramName">property</span>
   </xd:param>
   <xd:param name="to_domain" type="xs:string">
      ??? <span class="paramName">property</span>
   </xd:param>
   <xd:param name="from" type="xs:string">
      ??? <span class="paramName">property</span>
   </xd:param>
   <xd:param name="to" type="xs:string">
      ???? <span class="paramName">property</span>.
   </xd:param>
   <xd:param name="justification" type="xs:string">
      The reason that <span class="paramName">actor</span> determined that the 
      domain relation should be shown with 
      visual <span class="paramName">property</span>=<span class="paramName">value</span>.
   </xd:param>
</xd:doc>
<xsl:function name="acv:explainTriple"> <!-- 10 -->
   <xsl:param name="subject"       as="xs:string"/>
   <xsl:param name="predicate"     as="xs:string"/>
   <xsl:param name="object"        as="xs:string"/>

   <xsl:param name="actor"         as="xs:string"/>

   <xsl:param name="visualForm"    as="xs:string"/>
   <!--xsl:param name="property"      as="xs:string"/>
   <xsl:param name="value"         as="xs:string"/-->

   <xsl:param name="from_domain"   as="xs:string"/>
   <xsl:param name="to_domain"     as="xs:string"/>

   <xsl:param name="from"          as="xs:string"/>
   <xsl:param name="to"            as="xs:string"/>

   <xsl:param name="justification" as="xs:string"/>

   <xsl:variable name="description" select="concat(
      $in,$in,'from_domain = ',$from_domain,' (and) ',$NL,
      $in,$in,'from        = ',$from,' (and) ',$NL,
      $in,$in,'to_domain   = ',$to_domain,' (and) ',$NL,
      $in,$in,'to          = ',$to,
      ' [b/c ',pmm:tryQName($justification),'] ',
      '( x®~o^_ ',pmm:bestLocalName($actor),' )')"/>

   <xsl:variable name="decisionURI">
      <xsl:choose>
         <xsl:when test="$log-visual-decisions"> <!-- TODO: make the $from and $to be graphic URIs? -->
            <xsl:value-of select="log:explainTriple($log,
                                                    $subject, $predicate, $object,
                                                    $actor, 
                                                    $visualForm,
                                                    $from_domain, $to_domain,
                                                    $from, $to,
                                                    $justification, $description)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="'[]'"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:value-of select="concat($description,', decision # ',pmm:bestLocalName($decisionURI))"/>
</xsl:function>

</xsl:transform>
