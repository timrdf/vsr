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
   xmlns:prov="http://www.w3.org/ns/prov#"

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
   <xd:short>Visual strategy that naively maps RDF triples to visual node-links.</xd:short>
   <xd:detail><p>This transform works on the 'foundational' rdf/xml syntax and NOT the abbreviated form.
                 use `java jena.rdfcopy your.rdf RDF/XML RDF/XML` to get the unabbreviated form.
                 'foundational' uses rdf:Description and not the type shorthand.</p></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- Actual params -->

<xd:doc>named graph of visualization artifact</xd:doc>
<xsl:param name="visual-artifact-uri"  select="concat('http://logd.tw.rpi.edu/source/lebot-rpi-edu/dataset/visualizations/version/',nmf:getMillisecondToMinuteName(''))"/>

<xd:doc>conferred in rdf:RDF and acv:explain()</xd:doc>
<xsl:param name="log-visual-decisions" select="false()"/>

<xd:doc>URL of sesame server to log visualization artifact</xd:doc>
<xsl:param name="log-serverURL"        select="'http://localhost:8080/openrdf-sesame'"/>

<xd:doc>repository at sesame server to log visualization artifact</xd:doc>
<xsl:param name="log-repositoryID"     select="'visual'"/>



<!-- Should be moved to implementing visual strategy template -->
<xd:doc>horizontal and vertical separation between node columns: 1) sinks 2) resources 3) bnodes 4) literals</xd:doc>
<xsl:param    name="separation"                select="300,50"/>
<xd:doc>Refrain from ALL visual abbreviations (except QNames for URIs and gray edges)</xd:doc>
<xsl:param    name="draw-literal-rdf"          select="false()"/> <!-- TODO MOVE -->
<!-- Relaxation parameters that should be tweaked -->
<xd:doc>Include the rdf:type into the label of the instance? was conferred in DEFAULT, now NOT conferred at all.</xd:doc>
<xsl:variable name="relax-classes-into-instances"         select="false()"/>
<xd:doc>was conferred in DEFAULT, now NOT conferred at all.</xd:doc>
<xsl:variable name="literals-to-relax"                    select="()"/>

<xsl:variable name="rdf2-plan" select="'http://github.com/timrdf/vsr/blob/master/src/xsl/from/rdf2.xsl'"/>

<!-- Setup stuff (no need to tweak as params) -->
<xsl:include  href="../ns/wgs-ns.xsl"/>
<xsl:include  href="../ns/rl-ns.xsl"/>
<xsl:include  href="../ns/dc-ns.xsl"/>
<xsl:include  href="../ns/ov-ns.xsl"/>
<xsl:include  href="../ns/owl-ns.xsl"/>
<xsl:include  href="../ns/vsr-ns.xsl"/>
<xsl:include  href="../util/string-variables.xsl"/>
<xsl:include  href="../util/uri.xsl"/>
<xsl:include  href="../util/nameFactory.xsl"/>
<xsl:include  href="../util/bestQNameLabelFor.xsl"/>
<xsl:include  href="../util/ns-precedence.xsl"/>
<xsl:include  href="../util/xsd-datatype-abbreviations.xsl"/>
<xsl:include  href="../util/string-if-true.xsl"/>
<xsl:include  href="../util/orient.xsl"/>
<xsl:include  href="../util/explain.xsl"/>

<xd:doc>Returns all rdf:Description elements according to their rdf:about or rdf:nodeID.</xd:doc>
<xsl:key      name="descriptions-by-subject"   match="rdf:Description" use="@rdf:about | @rdf:nodeID | @rdf:ID"/>

<xd:doc>Returns all rdf:Description elements according to their children's @rdf:resource or @rdf:nodeID.</xd:doc>
<xsl:key      name="descriptions-by-object"    match="rdf:Description" use="*/(@rdf:resource | @rdf:nodeID) | */*/@rdf:about"/>

<xd:doc>Return the URIs of the superclasses of the given URI.</xd:doc>
<xsl:key      name="subClassesOf"  match="rdf:Description/@rdf:about     | rdf:Description/@rdf:nodeID"
                                   use="../rdfs:subClassOf/@rdf:resource | ../rdfs:subClassOf/@rdf:nodeID"/>

<xd:doc>
   <xd:short>Prefix mappings</xd:short>
   <xd:detail>An instance of a Java object.</xd:detail>
</xd:doc>
<xsl:variable name="pmap"                      select="pmap:getInstance()"/>
<!--xd:doc></xd:doc>
<xsl:variable name="literal-value-hash" select="idm:new()"/-->
<xd:doc>
   <xd:short>Alternate identities.</xd:short>
   <xd:detail>An instance of a Java object.</xd:detail>
</xd:doc>
<xsl:variable name="visual-element-hash"       select="idm:new()"/>

<xd:doc>
   <xd:short>Logger</xd:short>
   <xd:detail>An instance of a Java object. Commits RDF triples to a Sesame repository.</xd:detail>
</xd:doc>
<xsl:variable name="log"                       select="if ($log-serverURL = '.')
                                                       then log:new($visual-artifact-uri)
                                                       else log:new($log-serverURL, $log-repositoryID, $visual-artifact-uri)"/>

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 100 -->
<xd:doc></xd:doc>
<xsl:variable name="class-uris"                select="$owl:Class, $rdfs:Class"/>
<xd:doc></xd:doc>
<xsl:variable name="property-uris"             select="$rdf:Property, $owl:ObjectProperty, $owl:DatatypeProperty, $owl:AnnotationProperty"/>

<xd:doc>
   <xd:short>Entry point from "2y.xsl".</xd:short>
   <xd:detail>
      Perform these calls:
      <ul>
         <li>Mint the prefix mappings node.</li>
         <li>Apply <a href="#d24e518">@rdf:resource template</a> <tt>mode="visual-element"</tt> for (first occurrence of) all sink nodes. (in no defined order)</li>
         <li>Apply <a href="#d24e597">rdf:Description[@rdf:about|rdf:nodeID] template</a> <tt>mode="visual-element"</tt> for (first occurrence of) all non-sink nodes. (in a very defined order)</li>
         <li>Apply template <tt>mode="default"</tt> for all nodes' properties. (in namespace precedence order)</li>
         <li>Record the number of triples to the logger.</li>
      </ul>
   </xd:detail>
</xd:doc>
<xsl:template match="rdf:RDF">

   <xsl:message select="concat('# log ',$log-visual-decisions,' url ',$log-serverURL)"/>
   <xsl:variable name="owl:sameAs" select="concat($rdf2-plan,'#RDF_2y_entry_137')"/>

   <!-- Summary of input -->
   <xsl:message select="'# ',count(//rdf:Description[@rdf:about]) ,' subject uris of ',  count(//@rdf:resource),' uri references'"/>
   <xsl:message select="'# ',count(//rdf:Description[@rdf:nodeID]),' subject bnodes of ',count(//@rdf:nodeID),  ' bnode references'"/>
   <xsl:message select="'# ',count(//rdf:Description),' descriptions, with ',(  count(//rdf:Description[@rdf:about])
                                                                             + count(//rdf:Description[@rdf:nodeID]))
                                                                             - count(//rdf:Description),
                        '# having something other than rdf:about or @rdf:nodeID'"/> <!-- ^^ numNodesWithoutAboutOrID -->

   <!-- Walk through all namespaces, get their best prefix, and print abbreviations into a single node -->
   <xsl:variable name="prefix-mappings">
      <xsl:for-each-group select="//@rdf:about | //@rdf:resource" group-by="pmm:bestNamespace(.)">
         <xsl:sort select="xutil:ns-precedence-string(pmm:bestNamespace(.))"/>
         <xsl:if test="pmap:canAbbreviate($pmap,.)">
            <!-- TODO: use prefix.cc, construct URL of the prefixes that it has for $url below -->
            <xsl:value-of select="concat('(',count(current-group()),')   ',pmap:bestPrefixFor($pmap,.),':   ',current-grouping-key(),$NL)"/>
         </xsl:if>
      </xsl:for-each-group>
   </xsl:variable>
   <xsl:if test="string-length($prefix-mappings)">
      <xsl:call-template name="node">
         <xsl:with-param name="id"                  select="'--PREFIX MAPPINGS USED--'"/>
         <xsl:with-param name="depicts"             select="concat($visual-artifact-uri,'/prefix-mappings')"/>
         <xsl:with-param name="context"             select="''"/>
         <xsl:with-param name="visual-artifact-uri" select="$visual-artifact-uri"/>
         <xsl:with-param name="label"               select="$prefix-mappings"/>
         <xsl:with-param name="url"                 select="concat($visual-artifact-uri,'/prefix-mappings')"/>
         <!--xsl:with-param name="x"                   select="$separation[1]"/>
         <xsl:with-param name="y"                   select="$separation[2]"/-->
         <xsl:with-param name="x"                   select="0"/>
         <xsl:with-param name="y"                   select="0"/>
         <xsl:with-param name="lock"                select="true()"/>
         <xsl:with-param name="h-align-text"        select="'0'"/>  <!-- left (TODO: $graffle.h-align-text.left and ont modeling of it.) -->
         <xsl:with-param name="fit-text"            select="'Vertical'"/>
      </xsl:call-template>
   </xsl:if>

   <xsl:choose>
      <xsl:when test="true()">
      </xsl:when>
      <xsl:when test="true() or clean-visual-element-minting"> <!-- was $clean-vis... -->
         <xsl:for-each-group select="//(@rdf:about | @rdf:resource | @rdf:nodeID | @rdf:ID)" group-by=".">
            <xsl:apply-templates select="current-group()[1]">
               <xsl:sort select="."/>
               <xsl:with-param name="deferrer" select="$owl:sameAs"/>
               <!-- TODO: pass down visual-artifact-uri as context. -->
            </xsl:apply-templates>
         </xsl:for-each-group>
      </xsl:when>
      <xsl:otherwise>
         <!-- Create nodes for RESOURCES that are /NOT/ described in this file ("sinks") -->
         <!-- Consider making visual forms for each reference to a rdfs:Resource. -->
         <xsl:for-each-group select="//@rdf:resource" group-by=".">
            <xsl:if test="not(key('descriptions-by-subject',.))">
               <xsl:apply-templates select="current-group()[1]" mode="visual-element"/> <!-- TODO: this should just be a condition in the main style template -->
            </xsl:if>
         </xsl:for-each-group>

         <!-- Create nodes for RESOURCES that /ARE/ described in this file ("non-sinks") -->
         <xsl:for-each-group select="//rdf:Description[@rdf:about | @rdf:nodeID]" group-by="@rdf:about | @rdf:nodeID">
            <xsl:sort select="count(current-group()/@rdf:nodeID)"/>                                                     <!-- resources, then bnodes      -->
            <xsl:sort select="count(current-group()/rdf:type/@rdf:resource[. = $property-uris])"   order="descending"/> <!-- properties                  -->
            <xsl:sort select="count(current-group()/rdf:type/@rdf:resource[. = $class-uris])"      order="descending"/> <!-- classes                     -->
            <xsl:sort select="count(current-group()/rdf:type/@rdf:resource[. = $owl:Restriction])" order="descending"/> <!-- restrictions                -->
            <xsl:sort select="key('subClassesOf',current-grouping-key())[1]"/>                                          <!-- sort by first subclass (b1) -->
            <!-- TODO: FIX FEB 2010 yuck xsl:sort select="current-group()/rdf:type[1]/@rdf:resource"                           order="descending"/--> <!-- rdf:type (b3)               -->
            <xsl:sort select="current-group()[1]/rdf:type[1]/@rdf:resource"                           order="descending"/> <!-- rdf:type (b3)               -->
            <!--xsl:sort select="current-grouping-key()"/-->                                                               <!-- sort by name (b4)           -->
            <!-- TODO: for-each-group group-by="subclasses" (b2) -->
            <xsl:sort select="count(current-group()/owl:minCardinality)" order="descending"/>                           <!-- (b5) -->
            <xsl:sort select="count(current-group()/owl:maxCardinality)" order="descending"/>                           <!-- (b6) -->
            <xsl:sort select="count(current-group()/owl:cardinality)"    order="descending"/>                           <!-- (b7) -->
            <xsl:sort select="count(current-group()/owl:someValuesFrom)" order="descending"/>                           <!-- (b8) -->
            <xsl:sort select="count(current-group()/owl:allValuesFrom)"  order="descending"/>                           <!-- (b9) -->
            <xsl:sort select="count(current-group()/owl:hasValue)"       order="descending"/>                           <!-- (b10) -->
            <!--xsl:sort select="key('descriptions-by-subject',current-grouping-key())/rdf:type[1]/@rdf:resource"/-->      <!-- sort by type (r1) -->
            <!--xsl:sort select="current-grouping-key()"/-->                                                               <!-- sort by name (r2) -->

            <xsl:apply-templates select="current-group()[1]" mode="visual-element"/> <!-- TODO why would there be multiple values?
                                                logd.tw.rpi.edu/source/whitehouse-gov/dataset/visitor-records/version/2011-Aug-26 -->
         </xsl:for-each-group>
      </xsl:otherwise>
   </xsl:choose>

   <!-- Process all of the property/value pairs describing this subject -->
   <xsl:for-each-group select="//rdf:Description[@rdf:about | @rdf:nodeID]" group-by="@rdf:about | @rdf:nodeID">
      <xsl:sort select="count(current-group()/@rdf:nodeID)"/>                                                     <!-- resources, then bnodes      -->
      <xsl:sort select="count(current-group()/rdf:type/@rdf:resource[. = $property-uris])"   order="descending"/> <!-- properties                  -->
      <xsl:sort select="count(current-group()/rdf:type/@rdf:resource[. = $class-uris])"      order="descending"/> <!-- classes                     -->
      <xsl:sort select="count(current-group()/rdf:type/@rdf:resource[. = $owl:Restriction])" order="descending"/> <!-- restrictions                -->
      <xsl:sort select="key('subClassesOf',current-grouping-key())[1]"/>                                          <!-- sort by first subclass (b1) -->
      <!--xsl:sort select="current-group()/rdf:type[1]/@rdf:resource"                        order="descending"/--> <!-- rdf:type (b3)               -->
      <xsl:sort select="current-group()[1]/rdf:type[1]/@rdf:resource"                        order="descending"/> <!-- rdf:type (b3)               -->
      <!--xsl:sort select="current-grouping-key()"/-->                                                               <!-- sort by name (b4)           -->
      <!-- TODO: for-each-group group-by="subclasses" (b2) -->
      <xsl:sort select="count(current-group()/owl:minCardinality)" order="descending"/>                           <!-- (b5) -->
      <xsl:sort select="count(current-group()/owl:maxCardinality)" order="descending"/>                           <!-- (b6) -->
      <xsl:sort select="count(current-group()/owl:cardinality)"    order="descending"/>                           <!-- (b7) -->
      <xsl:sort select="count(current-group()/owl:someValuesFrom)" order="descending"/>                           <!-- (b8) -->
      <xsl:sort select="count(current-group()/owl:allValuesFrom)"  order="descending"/>                           <!-- (b9) -->
      <xsl:sort select="count(current-group()/owl:hasValue)"       order="descending"/>                           <!-- (b10) -->
      <!--xsl:sort select="key('descriptions-by-subject',current-grouping-key())/rdf:type[1]/@rdf:resource"/-->      <!-- sort by type (r1) -->
      <!--xsl:sort select="current-grouping-key()"/-->                                                               <!-- sort by name (r2) -->

      <!-- Print the subject once, and let each triple handler print the PO -->
      <xsl:message select="pmm:tryQName(current-grouping-key())"/>

      <!--xsl:choose>
         <xsl:when test="$draw-literal-rdf"> <- - - - draw literal logic should be done by the visual strategy, not in the core.
            <xsl:apply-templates select="current-group()" mode="default">
               <xsl:sort select="xutil:ns-precedence(.)"/>
            </xsl:apply-templates>
         </xsl:when>
         <xsl:otherwise-->

      <xsl:apply-templates select="current-group()">
         <xsl:sort select="xutil:ns-precedence(.)"/>
         <xsl:with-param name="deferrer" select="$owl:sameAs"/>
      </xsl:apply-templates>

         <!--/xsl:otherwise>
      </xsl:choose-->
   </xsl:for-each-group>

   <xsl:if test="$log-visual-decisions">
      <xsl:message select="'# Begin provenance dump.'"/>
      <xsl:variable name="numTriples" select="log:export($log)"/>
      <xsl:message select="concat('#',$in,$numTriples,' in vislog')"/>
   </xsl:if>

</xsl:template>

<xd:doc>
   <xd:short><tt>mode="visual-element"</tt> for [sink] objects.</xd:short>
   <xd:detail>
      Called from x2.xsl's <a href="#d24e237">rdf:RDF root node</a>.
      TODO: @rdf:resource should be a condition in the main template.


@@@ DEPRECATED: use match="@rdf:about | @rdf:resource | @rdf:nodeID | @rdf:ID"


   </xd:detail>
   <xd:param name="namespaces-to-relax">Mint new visual nodes for the occurrence of every URI in these namespaces.</xd:param>
</xd:doc>
<xsl:template match="@rdf:resource" mode="visual-element" priority="-.75">
   <xsl:param name="namespaces-to-relax"             select="()"/>
   <xsl:param name="deferrer"                        select="''"/>

   <xsl:variable name="owl:sameAs" select="concat($rdf2-plan,'#RDF_resource_object_visual_form_factory_275')"/>
   <xsl:variable name="rdf:type"   select="$vsr:VisualElementFactory"/>

   <!-- Orient with domain form -->
   <xsl:variable name="resource"           select="."/>
   <xsl:message select="acv:arriveResource($owl:sameAs,$resource,$deferrer)"/>

   <!-- Gather certain properties -->
   <xsl:variable name="sink"               select="count(key('descriptions-by-subject',$resource)) gt 0"/>
   <xsl:variable name="already-created"    select="idm:hasIdentified($visual-element-hash,$resource)"/>
   <xsl:variable name="should-relax-by-ns" select="pmm:bestNamespace($resource) = $namespaces-to-relax"/>
   <xsl:variable name="position"           select="position()"/>

   <!--xsl:message select="concat($resource,' sink: ',$sink,' already-created: ',$already-created,' should-relax-by-ns: ',$should-relax-by-ns,' position: ',$position)"/-->

   <xsl:choose>
      <xsl:when test="$already-created">
         <xsl:message select="acv:explainResource($resource,$owl:sameAs,'vsr:NotRenderVisualElement','$visual-form-uri','$already-created and !$should-relax-by-ns')"/>
      </xsl:when>
      <!--xsl:when test="$should-relax-by-ns">
         <xsl:message select="acv:explainResource($resource,$owl:sameAs,'vsr:NotRenderVisualElement',$visual-form-uri,'$should-relax-by-ns')"/>
      </xsl:when>
      <xsl:when test="$sink">
         <xsl:message select="acv:explainResource($resource,$owl:sameAs,'vsr:NotRenderVisualElement',$visual-form-uri,'$sink and !should-relax-by-ns')"/>
      </xsl:when-->
      <xsl:otherwise>
         <xsl:message select="acv:explainResource($resource,$owl:sameAs,'vsr:RenderVisualElement','$visual-form-uri','otherwise')"/>
         <!--xsl:message select="concat('FOUND',$resource,$NL,$in,'(non-subject resource ',position(),') ',
                              idm:hasIdentified($visual-element-hash,$resource),' ',
                              idm:getIdentifier($visual-element-hash,$resource),$NL)"/-->
         <xsl:call-template name="node">
            <xsl:with-param name="depicts"             select="$resource"/>
            <xsl:with-param name="context"             select="$visual-artifact-uri"/> <!-- the "global" context -->
            <xsl:with-param name="visual-artifact-uri" select="$visual-artifact-uri"/>
            <xsl:with-param name="id"                  select="$resource"/> <!-- DEPRECATE -->
            <xsl:with-param name="label"               select="pmm:tryQName($resource)"/>
            <xsl:with-param name="url"                 select="$resource"/>
            <xsl:with-param name="x"                   select="$separation[1]"/>
            <xsl:with-param name="y"                   select="$separation[2] * (1 + position())"/>
            <xsl:with-param name="draw-shadow"         select="if ($draw-literal-rdf) then 'NO' else 'YES'"/>
            <xsl:with-param name="ignore"              select="idm:getIdentifier($visual-element-hash,$resource)"/>
         </xsl:call-template>
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xd:doc>
   <xd:short><tt>mode="visual-element"</tt> for subjects.</xd:short>
   <xd:detail>Called from "x2.xsl"'s root node.



@@@ DEPRECATED: use match="@rdf:about | @rdf:resource | @rdf:nodeID | @rdf:ID"




   </xd:detail>
</xd:doc>
<xsl:template match="rdf:Description[@rdf:about | @rdf:nodeID]" mode="visual-element" priority="-.75">
   <xsl:param    name="deferrer"   select="''"/>
   <xsl:variable name="owl:sameAs" select="concat($rdf2-plan,'#RDF_subject_visual_form_factory_ve_298')"/>
   <xsl:variable name="rdf:type"   select="$vsr:VisualElementFactory"/>
   <!-- Orient with domain form -->
   <xsl:variable name="subject"          select="@rdf:about | @rdf:nodeID"/><!--current-grouping-key()"/-->
   <xsl:message select="acv:arriveResource($owl:sameAs,$subject,$deferrer)"/>
   <xsl:apply-templates select="." mode="default">
      <xsl:with-param name="deferrer" select="$owl:sameAs"/>
   </xsl:apply-templates>
</xsl:template>

<xd:doc>
   <xd:short>Stub for Visual Strategies, or, the Default Visual Strategy.</xd:short>
   <xd:detail>Called from "x2.xsl"'s root node.
   </xd:detail>
</xd:doc>
<xsl:template match="@rdf:about | @rdf:resource | @rdf:nodeID | @rdf:ID" priority="-.75">
   <xsl:param name="deferrer"                      select="''"/>
   <xsl:param name="namespaces-to-relax"           select="()"     tunnel="yes"/>

   <xsl:variable name="owl:sameAs" select="concat($rdf2-plan,'#RDF_stub-visual_form_factory_362')"/>
   <xsl:variable name="rdf:type"   select="$vsr:VisualElementFactory"/>

   <xsl:message select="acv:arriveResource($owl:sameAs, ., $deferrer)"/>

   <xsl:apply-templates select="." mode="default">
      <xsl:with-param name="deferrer" select="$owl:sameAs"/>
   </xsl:apply-templates>
</xsl:template>

<xd:doc>
   <xd:short>Clean context-free visual element rendering.</xd:short>
   <xd:detail>
   </xd:detail>
   <xd:param name="deferrer">The URI of the template that called this one.</xd:param>

   <xd:param name="blacklisted-subject-classes">The classes whose instances should not render a visual element.</xd:param>
   <xd:param name="anonymous-instance-classes">Do not render the URI of instances in these classes in their labels (but include their type).</xd:param>
   <xd:param name="label-predicates">?? something about priorities.</xd:param>
   <xd:param name="in-label-predicates">Properties whose values should be rendered in the label of the visual element (as "attribute-value" pairs).</xd:param>
   <xd:param name="notes-predicates">Predicates whose values should appear in the V(subject)'s notes
                                     (and not appear as a visual edge/visual node).
   </xd:param>
   <xd:param name="class-strategy">Fill colors for a given set of classes.</xd:param>
   <xd:param name="namespace-strategy">Fill colors for instances of a given set of namespaces.</xd:param>
   <xd:param name="notes-predicates"></xd:param>
   <xd:param name="tooltip-predicates"></xd:param>
   <xd:param name="rooted-classes"></xd:param>
   <xd:param name="namespaces-to-relax">Mint new visual nodes for the occurrence of every URI in these namespaces.</xd:param>
   <xd:param name="namespaces-to-relax-in-ranges">Mint new visual nodes for the occurrence of every URI in these namespaces, IF they occur as objects of rdfs:range.</xd:param>
   <xd:param name="show-bnode-IDs">Include the serailized identifier for a bnode in its visual node's label.</xd:param>

   <xd:param name="shape"></xd:param>
   <xd:param name="label">The label to give the V(subject)</xd:param>
   <xd:param name="fill-color">Fill color of the V(subject) -- OVERRIDES the <tt>class-strategy</tt> and <tt>namespace-strategy</tt>.</xd:param>
   <xd:param name="stroke-color2">The color of the V(subject)'s border.</xd:param>
   <xd:param name="height">The height of the V(subject)'s node.</xd:param>
   <xd:param name="fit-text"></xd:param>
   <xd:param name="draw-stroke"></xd:param>
</xd:doc>
<xsl:template match="@rdf:about | @rdf:resource | @rdf:nodeID | @rdf:ID" mode="default" priority="-.75">
   <xsl:param name="deferrer"                              />

   <xsl:param name="label"         select="()" tunnel="yes"/>
   <xsl:param name="fill-color"                tunnel="yes"/>
   <xsl:param name="stroke-color2"             tunnel="yes"/>
   <xsl:param name="shape"                     tunnel="yes"/>
   <xsl:param name="height"                    tunnel="yes"/>
   <xsl:param name="width"                     tunnel="yes"/>
   <xsl:param name="fit-text"                  tunnel="yes"/>
   <xsl:param name="draw-stroke"               tunnel="yes"/>

   <xsl:variable name="owl:sameAs" select="concat($rdf2-plan,'#RDF_resource_visual_form_factory_406')"/>
   <xsl:variable name="rdf:type"   select="$vsr:VisualElementFactory"/>

   <xsl:variable name="defin" select="if (matches($deferrer,'RDF-ABBREV_Default_statement_handler')) then '          ' else ''"/>

   <!-- Orient with domain form -->
   <xsl:variable name="resource"           select="."/>
   <xsl:message select="acv:arriveResource($owl:sameAs,$resource,$deferrer,$defin)"/>

   <!-- Gather certain properties -->
   <xsl:variable name="already-created"    select="idm:hasIdentified($visual-element-hash,$resource)"/>

   <!--xsl:message select="('relaxed namespaces: ',count(namespaces-to-relax))"/-->

   <!-- Elements for all property/value pairs describing this subject -->
   <xsl:variable name="s"                select="key('descriptions-by-subject',$resource)"/> <!-- Elements for all property/value pairs describing this subject -->

   <!-- Gather certain properties -->
   <xsl:variable name="already-created"  select="idm:hasIdentified($visual-element-hash,$resource)"/>
   <xsl:variable name="is-bnode"                      select="xfm:uri(.) = $rdf:nodeID"/>
   <xsl:variable name="is-resource"                   select="xfm:uri(.) = ($rdf:about, $rdf:resource)"/>

   <!-- Classify domain form -->

   <!-- identity -->

   <xsl:variable name="id">
      <xsl:variable name="value" select="$resource"/>
      <xsl:message select="acv:explainResource($resource,$owl:sameAs,
                                               'vnode id',$resource,
                                               $value,
                                               'otherwise',$defin)"/>
      <xsl:value-of select="$value"/>
   </xsl:variable>

   <xsl:variable name="visualFormURI" select="concat($visual-artifact-uri,'/graphic/',vsr:view-id($id))"/>

   <!-- Sub-surfacing variables -->

   <xsl:variable name="should-depict">
      <xsl:choose>
         <xsl:when test="idm:hasIdentified($visual-element-hash,$id)">
            <xsl:copy-of select="'false'"/>
            <xsl:message select="acv:explainResource($resource,$owl:sameAs,'should-depict','false','',concat('already created ',''),$defin)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="'true'"/>
            <xsl:message select="acv:explainResource($resource,$owl:sameAs,'should-depict','true','','not already-created)',$defin)"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <!-- Elevation variables, to be ordered by visual dominance. -->

   <xsl:variable name="fill-color">
            <xsl:variable name="value" select="'1 1 1'"/> <!-- white -->
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$vsr:fill,$value,$visualFormURI,'otherwise',$defin)"/>
            <xsl:value-of select="$value"/>
   </xsl:variable>
   <xsl:variable name="shape">
      <xsl:choose>
         <xsl:when test="$shape">
            <xsl:value-of select="$shape"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'shape',$shape,$visualFormURI,$vsr:determined_by_deferrer,$defin)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="''"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'shape','',$visualFormURI,'otherwise',$defin)"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="rotation">
      <xsl:choose>
      <xsl:when test="$draw-literal-rdf"></xsl:when>
      <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="draw-stroke">
      <xsl:choose>
         <xsl:when test="string-length($draw-stroke)">
            <xsl:variable name="value" select="$draw-stroke"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'draw-stroke',$value,$visualFormURI,$vsr:determined_by_deferrer,$defin)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$draw-literal-rdf">NO</xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="'NO'"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'draw-stroke',$value,$visualFormURI,'otherwise',$defin)"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="stroke-color">
      <xsl:choose>
         <xsl:when test="string-length($stroke-color2)">
            <xsl:variable name="value" select="$stroke-color2"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$vsr:stroke,$value,$visualFormURI,$vsr:determined_by_deferrer,$defin)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
      <xsl:when test="$draw-literal-rdf"></xsl:when>          <!-- white                 -->
      <xsl:otherwise>
          <!-- white -->
      </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="label">
      <xsl:choose>
         <!--xsl:when test="true()">
            <xsl:value-of select="$resource"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$resource,$visualFormURI,'debug',$defin)"/>
         </xsl:when-->
         <xsl:when test="count($label) gt 1">
            <xsl:value-of select="$label[1]"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$label[1],$visualFormURI,$vsr:determined_by_deferrer,$defin)"/>
         </xsl:when>
         <xsl:when test="string-length($label)">
            <xsl:value-of select="$label"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$label,$visualFormURI,$vsr:determined_by_deferrer,$defin)"/>
         </xsl:when>
         <xsl:when test="$is-bnode">
            <xsl:value-of select="'[  ]'"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,'[  ]',$visualFormURI,'$is-bnode',$defin)"/>
         </xsl:when>
         <xsl:when test="$is-resource">
            <xsl:value-of select="pmm:tryQName($resource)"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,pmm:tryQName($resource),$visualFormURI,'$is-resource',$defin)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$resource"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$resource,$visualFormURI,'otherwise',$defin)"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="fit-text">
      <xsl:choose>
         <xsl:when test="$fit-text">
            <xsl:value-of select="$fit-text"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'fit-text',$fit-text,$visualFormURI,$vsr:determined_by_deferrer,$defin)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="''"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'fit-text','',$visualFormURI,'otherwise',$defin)"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="h-text-pad">
      <xsl:choose>
         <xsl:when test="$is-bnode">
            <xsl:variable name="value" select="'5'"/>
            <xsl:message select="acv:explainResource($resource,$owl:sameAs,'h-text-pad',$value,$visualFormURI,'$is-bnode',$defin)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="'5'"/>
            <xsl:message select="acv:explainResource($resource,$owl:sameAs,'h-text-pad',$value,$visualFormURI,'otherwise',$defin)"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="h-align-text"> <!-- 0, '', 2, or 3 (left, center, right, justify) -->
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:variable name="value" select="'0'"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'h-align-text',string($value),$visualFormURI,'$draw-literal-rdf',$defin)"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="''"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'h-align-text',string($value),$visualFormURI,'otherwise',$defin)"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="v-align-text">
      <xsl:choose>
      <xsl:when test="$draw-literal-rdf"></xsl:when>
      <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="tooltip">
      <xsl:variable name="value" select="''"/>
      <xsl:message select="acv:explainResource($resource,$owl:sameAs,$vsr:tooltip,$value,$visualFormURI,'otherwise',$defin)"/>
      <xsl:value-of select="$value"/>
   </xsl:variable>

   <xsl:variable name="url">
      <xsl:choose>
         <xsl:when test="$is-resource">
            <xsl:value-of select="$resource"/>
         </xsl:when>
         <xsl:otherwise>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <!--xsl:message select="concat('rdf2.xsl before creating: hasIdentified: ',idm:hasIdentified($visual-element-hash,$resource),' should emit; ',$should-depict)"/-->
   <xsl:if test="$should-depict = 'true'"> <!-- unclean, but doesn't work with true() and false() above...  >:-{   -->
      <!--xsl:message select="concat('rdf2.xsl CREATING. hasIdentified: ',idm:hasIdentified($visual-element-hash,$resource),' should emit; ',$should-depict)"/-->
      <!--xsl:message select="concat($defin,$in,'calling node for vnode id ::',$id,'::')"/-->
      <xsl:call-template name="node">
         <xsl:with-param name="visual-artifact-uri" select="$visual-artifact-uri"/>
         <xsl:with-param name="context"             select="''"/>
         <xsl:with-param name="depicts"             select="$resource"/>
         <xsl:with-param name="id"                  select="$id"/>

         <xsl:with-param name="fill-color"          select="$fill-color"/>
         <xsl:with-param name="shape"               select="$shape"/>
         <xsl:with-param name="height"              select="$height"/>
         <xsl:with-param name="width"               select="$height"/>
         <xsl:with-param name="rotation"            select="$rotation"/>
         <xsl:with-param name="draw-stroke"         select="$draw-stroke"/>
         <xsl:with-param name="stroke-color"        select="$stroke-color"/>

         <xsl:with-param name="label"               select="$label"/>
         <xsl:with-param name="fit-text"            select="$fit-text"/>
         <xsl:with-param name="h-text-pad"          select="$h-text-pad"/>
         <xsl:with-param name="h-align-text"        select="$h-align-text"/>
         <xsl:with-param name="v-align-text"        select="$v-align-text"/>

         <xsl:with-param name="url"                 select="$url"/>
         <xsl:with-param name="tooltip"             select="$tooltip"/>

         <xsl:with-param name="ignore"              select="idm:getIdentifier($visual-element-hash,$id)"/>
      </xsl:call-template>
      <!--xsl:message select="concat('rdf2.xsl JUST CREATED. hasIdentified: ',idm:hasIdentified($visual-element-hash,$resource))"/-->
   </xsl:if>
</xsl:template>

<xd:doc>
   <xd:short>Core handling of predicates -- with minimal guidance.</xd:short>
   <xd:detail>Provide a default handling for predicates.
              Called by upsteam templates in the visual strategy.
   </xd:detail>
   <xd:param name="deferrer">The URI of the calling template (from the visual strategy).</xd:param>
   <xd:param name="namespaces-to-relax">Mint new visual nodes for the occurrence of every URI in these namespaces.</xd:param>
   <xd:param name="relax-identical-literals">If true, mint a new V(node,*) for the literal;
                                             else, reuse same V(node) if the literal is the same value.
   </xd:param>
   <xd:param name="objects-to-relax">Mint a new visual node for every resource in this list.</xd:param>
</xd:doc>
<xsl:template match="rdf:Description/*" priority="-.75">
   <xsl:param name="deferrer"                                                                         />
   <xsl:param name="namespaces-to-relax"      select="()"                                             />
   <xsl:param name="relax-identical-literals" select="true()"                             tunnel="yes"/>
   <xsl:param name="objects-to-relax"         select="($rdf:nil,$owl:FunctionalProperty)"             />

   <xsl:variable name="owl:sameAs" select="concat($rdf2-plan,'#RDF_Default_statement_handler_660')"/>
   <xsl:variable name="rdf:type"   select="$vsr:Relaxer"/>

   <!-- Orient with domain form -->
   <xsl:variable name="subject"   select="../@rdf:about | ../@rdf:nodeID"/>
   <xsl:variable name="predicate" select="xfm:uri(.)"/>
   <xsl:variable name="object"    select="if (@rdf:resource | @rdf:nodeID) then @rdf:resource | @rdf:nodeID else text()"/>
   <xsl:message                   select="if ($object) then acv:arriveTriple($owl:sameAs,$subject,$predicate,$object,$deferrer)
                                                       else acv:arriveTriple($owl:sameAs,$subject,$predicate,$deferrer)"/>
   <!--xsl:variable name="at-or-carat">
      <xsl:choose> <!- a typed literal ->
         <xsl:when test="$draw-literal-rdf"></xsl:when>
         <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:message select="concat($in,pmm:tryQName($predicate),$in,concat(pmm:tryQName($object),$at-or-carat,@rdf:datatype,@xml:lang))"/-->

   <!-- Gather necessary properties -->
   <xsl:variable name="rdf-rest"  select="key('descriptions-by-subject',$subject)/rdf:rest"/>

   <!-- Classify domain form -->
   <xsl:variable name="object-is-subject"                 select="key('descriptions-by-subject',$object)/*"/>
   <xsl:variable name="is-reification"                    select="key('descriptions-by-subject',$subject)/rdf:subject"/>
   <xsl:variable name="subject-has-same-domain-and-range" select="$predicate = $rdfs:domain and key('descriptions-by-subject',$subject)/rdfs:range[@rdf:resource = $object]"/>
   <xsl:variable name="subject-has-same-range-and-domain" select="$predicate = $rdfs:range and key('descriptions-by-subject',$subject)/rdfs:domain[@rdf:resource = $object]"/>
   <xsl:variable name="part-of-a-reification-quad"        select="$predicate = ($rdf:subject, $rdf:predicate, $rdf:object, $ps, $pp, $po)"/> <!-- TODO: rm this, is-reification does it-->
   <xsl:variable name="swap-directionality-predicates"    select="$rdf:type, $rdfs:domain, $rdfs:subClassOf, $rdf:subject, $owl:complementOf, $time:hasBeginning"/>

   <xsl:variable name="object-is-resource"   select="@rdf:resource or @rdf:nodeID"/>
   <xsl:variable name="object-is-literal"    select="@rdf:datatype or @xml:lang or text()"/>
   <xsl:variable name="object-is-bnode"      select="@rdf:nodeID"/>
   <xsl:variable name="literal-has-datatype" select="@rdf:datatype"/>
   <xsl:variable name="literal-has-lang"     select="@xml:lang"/> <!-- triple's object is a literal with language encoding -->
   <xsl:variable name="resource-is-relaxed"  select="pmm:bestNamespace($object) = $namespaces-to-relax or $object = $objects-to-relax"/>

   <!-- Determine visual properties based on classifications -->
   <xsl:variable name="unique-literal-gnode" select="concat($subject,'_',$predicate,'_',$object,'_',@rdf:datatype,@xml:lang,if ($object-is-literal) then '_value' else '')"/>
   <xsl:variable name="object-gnode">
      <xsl:choose>
         <xsl:when test="$object-is-resource and $resource-is-relaxed">
            <xsl:value-of select="nmf:getUUIDName($object)"/> <!-- TODO reconcile unique-literal and newUUID -->
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','object-gnode',nmf:getUUIDName($object),'$object-is-resource and $resource-is-relaxed')"/>
         </xsl:when>
         <xsl:when test="$object-is-resource">
            <xsl:value-of select="$object"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','object-gnode',$object,'$object-is-resource')"/>
         </xsl:when>
         <xsl:when test="$object-is-literal and $relax-identical-literals">
            <xsl:value-of select="$unique-literal-gnode"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','object-gnode',$unique-literal-gnode,'$object-is-literal and $relax-identical-literals')"/>
         </xsl:when>
         <xsl:when test="$object-is-literal">
            <xsl:variable name="value" select="concat($object,'_',@rdf:datatype,@xml:lang)"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','object-gnode',$value,'$object-is-literal and not($relax-identical-literals)')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$unique-literal-gnode"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','object-gnode',$unique-literal-gnode,'otherwise')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <!--xsl:variable name="id" select="nmf:getUUIDName('gedge')"/-->
   <xsl:variable name="id" select="concat($subject,' ',$predicate,' ',$object)"/>

   <xsl:variable name="edge-label">
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:variable name="value" select="pmm:tryQName($predicate)"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','edge-label',$value,'draw-literal-rdf')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="pmm:tryQName($predicate)"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','edge-label',$value,'otherwise')"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="object-label">
      <xsl:choose>
         <xsl:when test="$object-is-bnode">
            <xsl:value-of select="'[  ]'"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','object-label','[  ]','$object-is-bnode')"/>
         </xsl:when>
         <xsl:when test="$object-is-resource">
            <xsl:value-of select="pmm:tryQName($object)"/>
            <xsl:message  select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','object-label',pmm:tryQName($object),'$object-is-resource')"/>
         </xsl:when>
         <xsl:when test="$draw-literal-rdf">
            <xsl:value-of select="$object"/>
         </xsl:when>
         <xsl:otherwise> <!-- - - - - - - - - - - - - - - - - - - - -->
            <xsl:value-of select="$object"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="from"> <!-- TODO: paramaterize which predicates to swap. -->
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:variable name="value" select="$subject"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','from',$value,'draw-literal-rdf')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="$subject"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','from',$value,'otherwise')"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="to"> <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:variable name="value" select="$object-gnode"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','to',$value,'draw-literal-rdf')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="$object-gnode"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','to',$value,'otherwise')"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="line-style"> <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:variable name="value" select="'0'"/> <!-- solid -->
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','line-style',$value,'draw-literal-rdf')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>      
         <xsl:otherwise>
            <xsl:variable name="value" select="'0'"/> <!-- dotted -->
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','line-style',$value,'otherwise')"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise> 
      </xsl:choose>
   </xsl:variable>
      <xsl:variable name="line-width">
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:variable name="value" select="''"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','line-width',$value,'draw-literal-rdf')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="''"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','line-width',$value,'otherwise')"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="stroke-color">
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:variable name="value" select="'0.701961'"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','stroke-color',$value,'draw-literal-rdf')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="'0.701961'"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','stroke-color',$value,'otherwise')"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>                                                                  <!-- gray -->
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="draw-shadow">
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:variable name="value" select="'NO'"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','draw-shadow',$value,'draw-literal-rdf')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="'NO'"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','draw-shadow',$value,'otherwise')"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="head-style">
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:variable name="value" select="'FilledArrow'"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','head-style',$value,'draw-literal-rdf')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="'FilledArrow'"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','head-style',$value,'otherwise')"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise><!-- classic arrow head -->
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="tail-style">
      <xsl:choose>
         <xsl:when test="$draw-literal-rdf">
            <xsl:variable name="value" select="'0'"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','tail-style',$value,'otherwise')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="value" select="'0'"/>
            <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','tail-style',$value,'otherwise')"/>
            <xsl:value-of select="$value"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="edge-font-color">
      <xsl:choose>
      <xsl:when test="true()">
         <xsl:value-of select="'.5 .5 .5'"/>
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','edge-font-color','.5 .5 .5','true()')"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="'.5 .5 .5'"/>
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','edge-font-color','.5 .5 .5','otherwise')"/>
      </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="object-font-color">
      <xsl:choose>
      <xsl:when test="true()">
         <xsl:value-of select="'0 0 0'"/>
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','object-font-color','0 0 0','true()')"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="'0 0 0'"/>
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','object-font-color','0 0 0','otherwise')"/>
      </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="draw-fill">
      <xsl:choose>
      <xsl:when test="$draw-literal-rdf">
         <xsl:value-of select="'YES'"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="'YES'"/>
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,'visual-form-uri','draw-fill','YES','otherwise')"/>
      </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="action">
      <xsl:choose>
         <xsl:when test="$object-is-resource">
            <xsl:value-of select="concat($rl,'Draw_resource_statement_literally')"/>
         </xsl:when>
         <xsl:when test="$object-is-literal">
            <xsl:value-of select="concat($rl,'Draw_literal_statement_literally')"/>
         </xsl:when>
         <xsl:otherwise>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="justification" select="concat($deferrer,' ',pmm:tryQName($rlDeferred))"/>

   <xsl:if test="not(idm:hasIdentified($visual-element-hash,$subject))">
      <xsl:message select="concat('          ( = = Drawing subject ',$subject,' )')"/>
      <!-- A bit of a hack to provide a context node for the template's key -->
      <!--xsl:for-each-group select="key('descriptions-by-subject',$subject)
                                   /(@rdf:about | @rdf:resource | @rdf:nodeID | @rdf:ID)" group-by="."-->
      <xsl:apply-templates select="$subject" mode="default">
         <xsl:with-param name="deferrer"     select="$owl:sameAs"/>
         <!--xsl:with-param name="view-context" select="$subject-view-context"/-->
      </xsl:apply-templates>
      <!--/xsl:for-each-group-->
   </xsl:if>

   <xsl:choose>
      <xsl:when test="@rdf:resource | @rdf:nodeID | @rdf:datatype | @xml:lang | text()">
         <xsl:call-template name="edge"> <!-- Make the edge from the resource to the object-gnode -->
            <xsl:with-param name="id"           select="$id"/>
            <xsl:with-param name="from"         select="$from"/>
            <xsl:with-param name="to"           select="$to"/>
            <xsl:with-param name="depicts"      select="$predicate"/>
            <xsl:with-param name="label"        select="$edge-label"/>
            <xsl:with-param name="font-color"   select="$edge-font-color"/>
            <xsl:with-param name="notes"        select="pmm:tryQName($predicate)"/>
            <xsl:with-param name="url"          select="$predicate"/>
            <xsl:with-param name="line-style"   select="$line-style"/>
            <xsl:with-param name="line-width"   select="$line-width"/>
            <xsl:with-param name="stroke-color" select="$stroke-color"/>
            <xsl:with-param name="head-style"   select="$head-style"/>
            <xsl:with-param name="tail-style"   select="$tail-style"/>
            <xsl:with-param name="draw-shadow"  select="$draw-shadow"/>
         </xsl:call-template>
         <xsl:if test="not(idm:hasIdentified($visual-element-hash,$object-gnode))">
            <xsl:call-template name="node"> <!-- Mint the node for the literal -->
               <xsl:with-param name="id"                  select="$object-gnode"/>
               <xsl:with-param name="depicts"             select="$object"/>
               <xsl:with-param name="visual-artifact-uri" select="$visual-artifact-uri"/>
               <xsl:with-param name="label"               select="concat(' ',$object-label)"/>
               <xsl:with-param name="x"                   select="5 * $separation[1]"/>
               <xsl:with-param name="y"                   select="5 * $separation[2]"/>
               <xsl:with-param name="font-color"          select="$object-font-color"/>
               <xsl:with-param name="draw-fill"           select="$draw-fill"/>
               <xsl:with-param name="ignore"              select="idm:getIdentifier($visual-element-hash, $object-gnode)"/>
            </xsl:call-template>
            <!--xsl:message select="concat('making new literal node','')"/-->
         </xsl:if>
         <xsl:if test="$literal-has-datatype or $literal-has-lang">
            <!-- TODO: make the node for the datatype, link from the triple's object to the datatype node -->
         </xsl:if>
      </xsl:when>
      <xsl:otherwise>
         <xsl:message select="concat($in,'WARNING: hit unhandled description: ',name(),' (could be empty text())',' attributes:')"/>
         <xsl:for-each select="@*">
            <xsl:message select="concat($in,name())"/>
         </xsl:for-each>
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xd:doc>
   <xd:short>Core handling for subjects and predicates -- with exceptional guidance.</xd:short>
   <xd:detail>
      Provide a default handling for subjects and predicates.
      Called by upsteam templates in the visual strategy.
      TODO: why was this switched from a call to a match?
   </xd:detail>
   <xd:param name="blacklisted-subjects">
      By default, an empty list.
   </xd:param>
   <xd:param name="blacklisted-subject-namespaces">
      By default, an empty list.
   </xd:param>
   <xd:param name="qualifying-predicates">
      By default, an empty list. e.g. sio:has-attribute, prov:qualifiedUsage
   </xd:param>
   <xd:param name="qualified-object-predicates">
      By default, an empty list. e.g. sio:refers-to, prov:entity
   </xd:param>
   <xd:param name="qualification-pairs">
      By default, an empty list. e.g. prov:Usage,prov:used 
   </xd:param>
   <xd:param name="blacklisted-predicates">
      By default, an empty list.
   </xd:param>
   <xd:param name="preferred-inverses">
      By default, an empty list. A list of pairs of 'undesireable inverse' -> 'preferred inverse'. If the latter appears, omit the former.
   </xd:param>
   <xd:param name="in-label-predicates">
      By default, an empty list.
   </xd:param>
   <xd:param name="blacklisted-predicate-namespaces">
      By default, an empty list.
   </xd:param>
   <xd:param name="blacklisted-objects">
      By default, an empty list.
   </xd:param>
   <xd:param name="blacklisted-object-classes">
      By default, an empty list.
   </xd:param>
   <xd:param name="blacklisted-object-namespaces">
      By default, an empty list.
   </xd:param>
   <xd:param name="notes-predicates">
      The list of predicates whose values are expressed in V(node)'s notes.
      If the given RDF predicate is in this list, its V(edge) is not rendered.
      By default, an empty list.
   </xd:param>
   <xd:param name="class-strategy">
      The coloring strategy for a list of <tt>rdfs:Class</tt>es.
      If the given RDF subject is mentioned in this coloring strategy, its V(edge) is not rendered.
      By default, an empty list.
   </xd:param>
</xd:doc>
<xsl:template match="*" mode="blacklist_checker">
   <xsl:param name="deferrer"                         select="''"             />

   <xsl:param name="blacklisted-subjects"             select="()"             />
   <xsl:param name="blacklisted-subject-classes"      select="()"             />
   <xsl:param name="blacklisted-subject-namespaces"   select="()"             />

   <xsl:param name="qualifying-predicates"            select="()" tunnel="yes"/>
   <xsl:param name="qualified-object-predicates"      select="()" tunnel="yes"/>
   <xsl:param name="qualification-pairs"              select="()" tunnel="yes"/>

   <xsl:param name="blacklisted-predicates"           select="()"             />
   <xsl:param name="blacklisted-predicate-namespaces" select="()"             />

   <xsl:param name="preferred-inverses"               select="()"             />

   <xsl:param name="class-strategy"                   select="()" tunnel="yes"/>

   <xsl:param name="anonymous-instance-classes"       select="()" tunnel="yes"/>
   <xsl:param name="label-predicates"                 select="()" tunnel="yes"/>
   <xsl:param name="in-label-predicates"              select="()" tunnel="yes"/>

   <xsl:param name="blacklisted-objects"              select="()"             />
   <xsl:param name="blacklisted-object-classes"       select="()"             />
   <xsl:param name="blacklisted-object-namespaces"    select="()"             />

   <xsl:param name="notes-predicates"                 select="()"             />

   <!--xsl:param name="swap-directionality-predicates"   select="()"/ TUNNEL it-->

   <xsl:variable name="owl:sameAs" select="concat($rdf2-plan,'#RDF_blacklist_checker_1033')"/>
   <xsl:variable name="type"   select="($vsr:Relaxer, $vsr:BlacklistChecker)"/>

   <xsl:variable name="subject"   select="../@rdf:about | ../@rdf:nodeID"/>
   <xsl:variable name="predicate" select="xfm:uri(.)"/>
   <xsl:variable name="object"    select="vsr:getObject(.)"/>
   <xsl:message                   select="acv:arriveTriple($owl:sameAs,$subject,$predicate,$object,$deferrer)"/>

   <xsl:variable name="s"         select="key('descriptions-by-subject',$subject)"/>
   <xsl:variable name="o"         select="key('descriptions-by-subject',$object)"/>

   <xsl:variable name="object-is-blacklisted-by-type">
      <xsl:for-each select="$o/rdf:type">
         <xsl:if test="vsr:getObject(.) = $blacklisted-object-classes">
            <!--xsl:message select="concat($object,' is blacklisted type ',vsr:getObject(.))"/-->
            <xsl:value-of select="vsr:getObject(.)"/>
         </xsl:if>
      </xsl:for-each>
   </xsl:variable>

   <!--xsl:for-each-group select="$o/rdf:type/@rdf:resource" group-by=".">
      <xsl:message select="concat('typed ',.)"/>
   </xsl:for-each-group>

   <xsl:for-each select="$preferred-inverses/undesirable-inverse">
      <xsl:message select="concat(preferred-inverse/@resource,' should be used instead of ',@about)"/>
   </xsl:for-each>

   <!- ?p=sio:attribute ?o=[a:IGeneration; sio:refers-to ?direct-o] ->
   <xsl:message select="concat('= ',$o/rdf:type/@rdf:resource = $preferred-inverses/undesirable-inverse/@about)"/>

   <xsl:variable name="preferred-inverse-is-asserted">
      <xsl:if test="$predicate = $preferred-inverses/undesirable-inverse/@about or $predicate = $o/rdf:type/@rdf:resource">
         <xsl:message select="concat('preferred inverse is asserted of ',$predicate,' ',$preferred-inverses/undesireable-inverse[@about = $predicate]/preferred-inverse/@resource)"/>
      </xsl:if>
   </xsl:variable-->

   <!--xsl:message select="concat(count($blacklisted-subject-classes),' blacklisted-subject-classes')"/-->

   <xsl:choose>

      <!-- Blacklisting by subject-->
      <xsl:when test="$subject = $blacklisted-subjects">
         <xsl:variable name="action"        select="$vsr:Prevent_default_processing"/>
         <xsl:variable name="justification" select="concat($rl,'Subject_is_blacklisted')"/>
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$action,$justification)"/>
      </xsl:when>
      <xsl:when test="pmap:bestNamespaceFor($pmap,$subject) = $blacklisted-subject-namespaces">
         <xsl:variable name="action"        select="$vsr:Prevent_default_processing"/>
         <xsl:variable name="justification" select="concat($rl,'Subject_namespace_is_blacklisted')"/>
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$action,$justification)"/>
      </xsl:when>
      <xsl:when test="$s/rdf:type[1]/@rdf:resource = $blacklisted-subject-classes">
         <xsl:variable name="action"        select="$vsr:Prevent_default_processing"/>
         <xsl:variable name="justification" select="concat($rl,'Subject_type_is_blacklisted')"/>
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$action,$justification)"/>
      </xsl:when>

      <!-- Blacklisting by predicate -->
      <!-- TODO: check that rdf:type of sio:Attribute is not in blacklisted predicates -->
      <xsl:when test="$predicate = $blacklisted-predicates">
         <xsl:variable name="action"        select="$vsr:Prevent_default_processing"/>
         <xsl:variable name="justification" select="concat($rl,'Predicate_is_blacklisted')"/>
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$action,$justification)"/>
      </xsl:when>
      <xsl:when test="$o/rdf:type/@rdf:resource = $blacklisted-predicates">
         <xsl:variable name="action"        select="$vsr:Prevent_default_processing"/>
         <xsl:variable name="justification" select="concat($rl,'Qualified_Predicate_is_blacklisted')"/>
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$action,$justification)"/>
      </xsl:when>
      <xsl:when test="$o/rdf:type/@rdf:resource = $preferred-inverses/undesirable-inverse/@about">
         <xsl:variable name="action"        select="$vsr:Prevent_default_processing"/>
         <xsl:variable name="justification" select="concat($rl,'Preferred_inverse_is_also_asserted')"/>
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$action,$justification)"/>
      </xsl:when>
      <xsl:when test="$predicate = $in-label-predicates or $predicate = $label-predicates">
         <xsl:variable name="action"        select="$vsr:Prevent_default_processing"/>
         <xsl:variable name="justification" select="concat($rl,'Predicate_is_rendered_in_subjects_visual_element')"/>
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$action,$justification)"/>
      </xsl:when>
      <xsl:when test="$predicate = $notes-predicates">                      <!-- += filter if rendered in notes -->
         <xsl:variable name="action"        select="$vsr:Prevent_default_processing"/>
         <xsl:variable name="justification" select="concat($rl,'Predicate_placed_in_notes')"/>
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$action,$justification)"/>
      </xsl:when>
      <xsl:when test="pmap:bestNamespaceFor($pmap,$predicate) = $blacklisted-predicate-namespaces">
         <xsl:variable name="action"        select="$vsr:Prevent_default_processing"/>
         <xsl:variable name="justification" select="concat($rl,'Predicate_namespace_is_blacklisted')"/>
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$action,$justification)"/>
      </xsl:when>
      <xsl:when test="$predicate = $rdf:type and $class-strategy/visual-form/class[.=$object]"> <!-- += colored -->
         <xsl:variable name="action"        select="$vsr:Prevent_default_processing"/>
         <xsl:variable name="justification" select="concat($rl,'rdf-typed-to-a-colored-class')"/>
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$action,$justification)"/>
      </xsl:when>

      <!-- Blacklisting by predicate/object -->
      <xsl:when test="$predicate = concat($rdf,'type') and $s/rdf:type/@rdf:resource = $anonymous-instance-classes">
         <xsl:variable name="action"        select="$vsr:Prevent_default_processing"/>
         <xsl:variable name="justification" select="concat($vsr,'Type-shown-in-label')"/>
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$action,$justification)"/>
      </xsl:when>

      <!-- Blacklisting by object -->
      <xsl:when test="$object = $blacklisted-objects">
         <xsl:variable name="action"        select="$vsr:Prevent_default_processing"/>
         <xsl:variable name="justification" select="concat($rl,'Object_is_blacklisted')"/>
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$action,$justification)"/>
      </xsl:when>
      <xsl:when test="string-length($object-is-blacklisted-by-type)">
         <xsl:variable name="action"        select="$vsr:Prevent_default_processing"/>
         <xsl:variable name="justification" select="concat($rl,'Object_is_blacklisted_by_type')"/>
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$action,$justification)"/>
      </xsl:when>
      <xsl:when test="pmap:bestNamespaceFor($pmap,$object) = $blacklisted-object-namespaces">
         <xsl:variable name="action"        select="$vsr:Prevent_default_processing"/>
         <xsl:variable name="justification" select="concat($rl,'Object_namespace_is_blacklisted')"/>
         <xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$action,$justification)"/>
      </xsl:when>

      <!-- Triple wasn't blacklisted based on its subject,predicate,object value or namespace -->
      <xsl:otherwise>
         <xsl:variable name="action"        select="$rlDefer_to_default_processing"/>
         <xsl:variable name="justification" select="concat($rl,'Subject_nor_predicate_nor_object_nor_their_namespaces_blacklisted')"/>
         <!--xsl:message select="acv:explainTriple($subject,$predicate,$object,$owl:sameAs,$action,$justification)"/-->
         <xsl:apply-templates select="." mode="default">
            <xsl:with-param name="deferrer"                       select="$owl:sameAs"/> <!-- DEFER -->
            <!--xsl:with-param name="swap-directionality-predicates" select="$swap-directionality-predicates"/--> <!-- TODO look into tunneling it. -->
         </xsl:apply-templates>
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xd:doc>
   <xd:short>Core handling for RDF subjects -- with exceptional handling.</xd:short>
   <xd:detail>Provide default handling of RDF subjects.
              Called by upsteam templates in the visual strategy.




DEPRECATED in favor of @rdf:about | @rdf:resource | @rdf:nodeID | @rdf:ID




   </xd:detail>
</xd:doc>
<xsl:template match="rdf:Description[@rdf:about | @rdf:nodeID]" mode="default" priority="-.75">
   <xsl:param name="deferrer"                                                  />

   <xsl:param name="class-strategy"                select="()"                 />
   <xsl:param name="namespace-strategy"            select="()"     tunnel="yes"/>
   <xsl:param name="blacklisted-subject-classes"                               />
   <xsl:param name="show-bnode-IDs"                select="false()"            />
   <xsl:param name="label-predicates"                                          />
   <xsl:param name="in-label-predicates"                                       />
   <xsl:param name="notes-predicates"              select="()"                 />
   <xsl:param name="anonymous-instance-classes"    select="()"     tunnel="yes"/>
   <xsl:param name="namespaces-to-relax"           select="()"     tunnel="yes"/>
   <xsl:param name="namespaces-to-relax-in-ranges" select="($xs)"              />

   <xsl:param name="label"                         select="()"     tunnel="yes"/>
   <xsl:param name="fill-color"                                    tunnel="yes"/>
   <xsl:param name="stroke-color2"                                 tunnel="yes"/>
   <xsl:param name="shape"                                         tunnel="yes"/>
   <xsl:param name="height"                                        tunnel="yes"/>
   <xsl:param name="fit-text"                                      tunnel="yes"/>
   <xsl:param name="draw-stroke"                                   tunnel="yes"/>

   <!-- The URI for _this_ template, and its type. -->
   <xsl:variable name="owl:sameAs" select="concat($rdf2-plan,'#RDF_subject_visual_form_factory_default_742')"/>
   <xsl:variable name="rdf:type"   select="$vsr:VisualElementFactory"/>

   <!-- Orient with the resource that we're considering to render, and log it. -->
   <xsl:variable name="resource"          select="@rdf:about | @rdf:nodeID"/>
   <xsl:message select="acv:arriveResource($owl:sameAs,$resource,$deferrer)"/>

   <!--xsl:message select="('relaxed namespaces: ',count(namespaces-to-relax))"/-->

   <!-- Elements for all property/value pairs describing this subject -->
   <xsl:variable name="s"                select="key('descriptions-by-subject',$resource)"/> <!-- Elements for all property/value pairs describing this subject -->

   <!-- Gather certain properties -->
   <xsl:variable name="already-created"  select="idm:hasIdentified($visual-element-hash,$resource)"/>
   <xsl:variable name="rdf-types"        select="$s/rdf:type/@rdf:resource"/>
   <xsl:variable name="rdfs-labels"      select="$s/rdfs:label"/>
   <xsl:variable name="rdfs-comments"    select="$s/rdfs:comment"/>
   <xsl:variable name="rdfs-isDefinedBy" select="$s/rdfs:isDefinedBy"/>
   <xsl:variable name="rdfs-range"       select="$s/rdfs:range/@rdf:resource"/>
   <xsl:variable name="rdfs-domain"      select="$s/rdfs:domain/@rdf:resource"/>
   <xsl:variable name="priority-label-descriptions">
      <!-- TODO: this functionality was copied to owl2.xsl; consolidate. -->
      <xsl:for-each select="$label-predicates"> <!-- O( subjects X label-predicates X |p(s)| ) -->
         <xsl:variable name="label-pred" select="."/>
         <xsl:for-each select="$s/*">
            <xsl:variable name="predicate" select="xfm:uri(.)"/>
            <!--xsl:message select="concat($label-pred,'(',string-length(text()),') vs ',$predicate)"/-->
            <xsl:if test="xfm:uri(.) = $label-pred and string-length(text())">
               <!--xsl:message select="'HIT'"/-->
               <xsl:copy-of select="."/>
            </xsl:if>
         </xsl:for-each>
      </xsl:for-each>
   </xsl:variable>
   <!--xsl:message select="concat('numP: ',count($priority-label-descriptions/*),' of ',count($s/*),' are ',
                                  count($label-predicates),' label predicates.')"/-->

   <!--xsl:message select="('anonymous class check ',count($anonymous-instance-classes),$anonymous-instance-classes = $rdf-types)"/>
   <xsl:for-each select="$anonymous-instance-classes">
      <xsl:message select="('anonymous class check ',.,' ',. = $rdf-types)"/>
   </xsl:for-each-->

   <!-- Classify domain form -->
   <xsl:variable name="is-resource"                   select="current-group()/@rdf:about"/> <!--current-group()/@rdf:about"/-->
   <xsl:variable name="is-bnode"                      select="current-group()/@rdf:nodeID"/><!--current-group()/@rdf:nodeID"/-->
   <xsl:variable name="is-list"                       select="$s/rdf:rest"/>
   <xsl:variable name="is-reification"                select="$s/rdf:subject"/> <!-- TODO: make stroke gray -->
   <xsl:variable name="is-class"                      select="$rdf-types[.=$class-uris]"/>
   <xsl:variable name="is-property"                   select="$rdf-types[.=$property-uris]"/>
   <xsl:variable name="has-same-domain-and-range"     select="count($rdfs-range) = 1 and count($rdfs-domain) = 1 and $rdfs-domain = $rdfs-range"/>
   <xsl:variable name="is-restriction"                select="$s/owl:onProperty"/>
   <xsl:variable name="is-cardinality-restriction"    select="$is-restriction and ($s/owl:minCardinality or $s/owl:maxCardinality or $s/owl:cardinality)"/>
   <xsl:variable name="is-value-restriction"          select="$is-restriction and ($s/owl:allValuesFrom  or $s/owl:someValuesFrom or $s/owl:hasValue)"/>
   <xsl:variable name="is-set-operation"              select="$s/owl:unionOf | $s/owl:intersectionOf | $s/owl:complementOf"/>

   <!-- variables for when this is a restriction node -->
   <xsl:variable name="cardinality-restriction-types" select="$s/owl:minCardinality | $s/owl:maxCardinality | $s/owl:cardinality"/>
   <xsl:variable name="value-restriction-type"        select="$s/owl:someValuesFrom | $s/owl:allValuesFrom  | $s/owl:hasValue"/>
   <xsl:variable name="restrictionType"               select="$s/owl:minCardinality | $s/owl:maxCardinality | $s/owl:cardinality |
                                                              $s/owl:someValuesFrom | $s/owl:allValuesFrom  | $s/owl:hasValue"/> <!-- TODO: just | prev two -->
   <xsl:variable name="restrictionTypePs"             select="key('descriptions-by-subject',$restrictionType/@rdf:resource |
                                                                                            $restrictionType/@rdf:nodeID  )"/>
   <xsl:variable name="vRp"                           select="$restrictionTypePs/owl:unionOf | $restrictionTypePs/owl:intersectionOf |
                                                              $restrictionTypePs/owl:complementOf"/>

   <!-- variables for when this is a node with owl:unionOf, owl:intersectionOf, or owl:complementOf -->
   <xsl:variable name="cardinality-string" select="concat(if ($s/owl:minCardinality) then concat('minHHHHH ',      $s/owl:minCardinality) else '',
                                                         if ($s/owl:cardinality)    then concat(', exactlyHHHHH ',$s/owl:cardinality)    else '',
                                                         if ($s/owl:maxCardinality) then concat(', maxHHHHH ',    $s/owl:maxCardinality) else '')"/>

   <xsl:variable name="should-relax-rdfs-domain"  select="count($rdfs-range) = 1 and pmap:canAbbreviate($pmap,$rdfs-range)
                                                          and pmm:bestNamespace($rdfs-range) = $namespaces-to-relax-in-ranges"/> <!--  -->

   <xsl:variable name="instance-should-assume-label-of-class" select="count($rdfs-range) = 1 and pmap:canAbbreviate($pmap,$rdfs-range)
                                                          and pmm:bestNamespace($rdfs-range) = $namespaces-to-relax-in-ranges"/> <!--  -->

   <xsl:variable name="rdf-types-as-string"> <!-- string of QNames for this subject's types -->
      <xsl:for-each select="$rdf-types">
         <!--xsl:message select="concat('TYPES: ',.,' ',pmm:tryQName(.))"/-->
         <xsl:value-of select="concat(pmm:tryQName(.),if (position() != last()) then ', ' else '')"/>
      </xsl:for-each>
   </xsl:variable>
                                                      <!--xsl:for-each select="$class-strategy/visual-form/class">
                                                         <xsl:if test="text() = $rdf-types">
                                                            <xsl:message select="concat(../@fill-color,' ',text())"/>
                                                         </xsl:if>
                                                      </xsl:for-each-->
                                                      <!--xsl:for-each select="$class-fill">
                                                         <xsl:message select="concat('class-fill: ',.)"/>
                                                      </xsl:for-each-->
   <!--xsl:message select="concat('CC: ',$rdf-types-as-string,' ',$class-fill)"/-->


   <xsl:variable name="visualFormURI" select="concat('http://todo.org/visualformURI',idm:getIdentifier($visual-element-hash,$resource))"/>

   <!-- determine the visual properties based on descriptions gathered -->
   <xsl:variable name="should-depict">
      <xsl:choose>
         <xsl:when test="$rdf-types = $blacklisted-subject-classes">
            <xsl:copy-of select="'false'"/>
            <xsl:message select="acv:explainResource($resource,$owl:sameAs,concat('should-depict = false',''),$visualFormURI,'instance of blacklisted class')"/>
         </xsl:when>
         <xsl:when test="not($already-created)">
            <xsl:copy-of select="'true'"/>
            <xsl:message select="acv:explainResource($resource,$owl:sameAs,concat('should-depict = true',''),$visualFormURI,'not($already-created)')"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="'false'"/>
            <xsl:message select="acv:explainResource($resource,$owl:sameAs,concat('should-depict = false',''),$visualFormURI,'otherwise')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="shape">
      <xsl:choose>
         <xsl:when test="$shape">
            <xsl:value-of select="$shape"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'shape',$shape,$visualFormURI,$vsr:determined_by_deferrer)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="''"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'shape','',$visualFormURI,'otherwise')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="label">
      <!--xsl:message select="concat('num in label preds: ',count($in-label-predicates))"/-->
      <xsl:variable name="in-label-predicates-label">
         <xsl:for-each select="$in-label-predicates">
            <xsl:variable name="label-pred" select="."/>
            <xsl:for-each select="$s/*">
               <xsl:variable name="predicate" select="xfm:uri(.)"/>
               <!--xsl:message select="concat($label-pred,'(',string-length(text()),') vs ',$predicate)"/-->
               <xsl:if test="xfm:uri(.) = $label-pred and string-length(text())">
                  <!--xsl:message select="'HIT'"/-->
                  <xsl:value-of select="concat($NL,pmm:bestLocalName($predicate),' : ',text())"/>
               </xsl:if>
            </xsl:for-each>
         </xsl:for-each>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="count($label) gt 1">
            <xsl:value-of select="$label[1]"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$label[1],$visualFormURI,$vsr:determined_by_deferrer)"/>
         </xsl:when>
         <xsl:when test="string-length($label)">
            <xsl:value-of select="$label"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$label,$visualFormURI,$vsr:determined_by_deferrer)"/>
         </xsl:when>
         <xsl:when test="$anonymous-instance-classes = $rdf-types">
            <xsl:variable name="value" select="concat('a ',pmm:tryQName($rdf-types[1]),
                                                      if (string-length($in-label-predicates-label)) then $NL else '',$in-label-predicates-label)"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$value,$visualFormURI,'instance should be anonymous.')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$priority-label-descriptions/*">
            <xsl:variable name="value" select="$priority-label-descriptions/*[1]/text()"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$value,$visualFormURI,'$priority-label-descriptions')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$rdf-types[.=$rdf:Statement]">
            <xsl:variable name="value" select="concat('a',$NL,pmm:tryQName($s/rdf:predicate/@rdf:resource),$NL,'rdf:Statement')"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$value,$visualFormURI,'rdf:Statement = $rdf-types')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$is-bnode and $rdf-types">
            <xsl:variable name="value" select="concat('a ',pmm:tryQName($rdf-types[1]))"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$value,$visualFormURI,'$is-bnode and $rdf-types')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$is-bnode and $show-bnode-IDs">
            <xsl:value-of select="@rdf:nodeID"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,@rdf:nodeID,$visualFormURI,'$is-bnode and $show-bnode-IDs')"/>
         </xsl:when>
         <xsl:when test="$is-bnode">
            <xsl:value-of select="'[  ]'"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,'[  ]',$visualFormURI,'$is-bnode')"/>
         </xsl:when>
         <xsl:when test="$is-resource">
            <xsl:value-of select="pmm:tryQName($resource)"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,pmm:tryQName($resource),$visualFormURI,'$is-resource')"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$resource"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$rdfs:label,$resource,$visualFormURI,'otherwise')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="fit-text">
      <xsl:choose>
         <xsl:when test="$fit-text">
            <xsl:value-of select="$fit-text"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'fit-text',$fit-text,$visualFormURI,$vsr:determined_by_deferrer)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="''"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'fit-text','',$visualFormURI,'otherwise')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
  <xsl:variable name="fill-color">
      <xsl:variable name="class-fill"     select="$class-strategy/visual-form[class[.=$rdf-types]]/@fill-color"/>
      <xsl:variable name="namespace-fill" select="$namespace-strategy/visual-form[namespace[starts-with($resource,.)]]/@fill-color"/>
      <xsl:choose>
         <xsl:when test="string-length($fill-color)">
            <xsl:value-of select="$fill-color"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$vsr:fill,$fill-color,$visualFormURI,$vsr:determined_by_deferrer)"/>
         </xsl:when>
         <xsl:when test="$draw-literal-rdf">
            <xsl:value-of select="'1 1 1'"/> <!-- white        -->
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$vsr:fill,'1 1 1',$visualFormURI,'$draw-lieral-rdf')"/>
         </xsl:when>
         <xsl:when test="$class-fill">
            <xsl:value-of select="$class-fill[1]"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$vsr:fill,$class-fill[1],$visualFormURI,'$class-fill')"/>
         </xsl:when>
         <xsl:when test="$namespace-fill">
            <xsl:value-of select="$namespace-fill"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,vsr:fill,$namespace-fill,$visualFormURI,'$namespace-strategy')"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="'1 1 1'"/> <!-- white        -->
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,vsr:fill,'',$visualFormURI,'otherwise')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="draw-stroke">
      <xsl:choose>
         <xsl:when test="string-length($draw-stroke)">
            <xsl:value-of select="'YES'"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'draw-stroke','YES',$visualFormURI,$vsr:determined_by_deferrer)"/>
         </xsl:when>
         <xsl:when test="$is-bnode and $rdf-types">
            <xsl:value-of select="'YES'"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,'draw-stroke','YES',$visualFormURI,'$is-bnode and $rdf-types')"/>
         </xsl:when>
         <xsl:when test="$draw-literal-rdf">NO</xsl:when>
         <xsl:otherwise>NO</xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="stroke-color">
      <xsl:choose>
         <xsl:when test="string-length($stroke-color2)">
            <xsl:value-of select="$stroke-color2"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$vsr:stroke,$stroke-color2,$visualFormURI,$vsr:determined_by_deferrer)"/>
         </xsl:when>
         <xsl:when test="$is-bnode and $rdf-types">
            <xsl:value-of select="'.7 .7 .7'"/>
            <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$vsr:stroke,'.7 .7 .7',$visualFormURI,'$is-bnode and $rdf-types')"/>
         </xsl:when>
      <xsl:when test="$draw-literal-rdf">
      </xsl:when>          <!-- white                 -->
      <xsl:otherwise>
         <xsl:variable name="value" select="'.7 .7 .7'"/>
         <xsl:message  select="acv:explainResource($resource,$owl:sameAs,$vsr:stroke,$value,$visualFormURI,'otherwise')"/>
         <xsl:value-of select="$value"/>
      </xsl:otherwise>                         <!-- white                 -->
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="h-text-pad">
      <xsl:choose>
         <xsl:when test="$is-bnode">
            <xsl:value-of select="'5'"/>
            <xsl:message select="acv:explainResource($resource,$owl:sameAs,'h-text-pad = 5',$visualFormURI,'$is-bnode')"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="'5'"/>
            <xsl:message select="acv:explainResource($resource,$owl:sameAs,'h-text-pad = 5',$visualFormURI,'otherwise')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="h-align-text">
      <xsl:choose>
      <xsl:when test="$draw-literal-rdf">
      </xsl:when>
      <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="v-align-text">
      <xsl:choose>
      <xsl:when test="$draw-literal-rdf"></xsl:when>
      <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="rotation">
      <xsl:choose>
      <xsl:when test="$draw-literal-rdf"></xsl:when>
      <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="x">
      <xsl:choose>
      <xsl:when test="$draw-literal-rdf"></xsl:when>
      <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="url">
      <xsl:choose>
      <xsl:when test="$is-resource"> <xsl:value-of select="$resource"/> </xsl:when>
      <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="notes">
      <xsl:choose> <!-- TODO: handle more than one comment triple. -->
         <xsl:when test="$s/*[xfm:uri(.)=$notes-predicates]">
            <xsl:variable name="value">
               <xsl:for-each select="$s/*[xfm:uri(.)=$notes-predicates]">
                  <xsl:value-of select="vsr:getObject(.)"/>
                  <xsl:if test="true or position != last()"><xsl:value-of select="$NL"/></xsl:if>
               </xsl:for-each>
            </xsl:variable>
            <xsl:message select="acv:explainResource($resource,$owl:sameAs,'notes',$value,$visualFormURI,'$notes-predicates')"/>
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="count($rdfs-comments) gt 1">
            <xsl:value-of select="'TODO:func($rdfs-comments)'"/>
            <xsl:message select="acv:explainResource($resource,$owl:sameAs,concat('notes = ',''),$visualFormURI,'more than one comment')"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$rdfs-comments"/>
            <xsl:message select="acv:explainResource($resource,$owl:sameAs,concat('notes = ',$rdfs-comments),$visualFormURI,'otherwise')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <!--xsl:message select="concat('rdf2.xsl before creating: hasIdentified: ',idm:hasIdentified($visual-element-hash,$resource),' should emit; ',$should-depict)"/-->
   <xsl:if test="$should-depict = 'true'"> <!-- unclean, but doesn't work with true() and false() above...  >:-{   -->
      <!--xsl:message select="concat('rdf2.xsl CREATING. hasIdentified: ',idm:hasIdentified($visual-element-hash,$resource),' should emit; ',$should-depict)"/-->
      <xsl:call-template name="node">
         <xsl:with-param name="depicts"             select="$resource"/>
         <xsl:with-param name="context"             select="$visual-artifact-uri"/>
         <xsl:with-param name="visual-artifact-uri" select="$visual-artifact-uri"/>

         <xsl:with-param name="id"                  select="$resource"/>
         <xsl:with-param name="label"               select="$label"/>
         <xsl:with-param name="isDefinedBy"         select="$rdfs-isDefinedBy"/>
         <xsl:with-param name="rdfTypes"            select="$rdf-types-as-string"/>
         <xsl:with-param name="notes"               select="$notes"/>
         <xsl:with-param name="shape"               select="$shape"/>
         <xsl:with-param name="fit-text"            select="$fit-text"/>
         <xsl:with-param name="x"                   select="$x"/>
         <xsl:with-param name="y"                   select="$separation[2] * (1 + position())"/>
         <xsl:with-param name="height"              select="$height"/>
         <xsl:with-param name="fill-color"          select="$fill-color"/>
         <xsl:with-param name="draw-stroke"         select="$draw-stroke"/>
         <xsl:with-param name="stroke-color"        select="$stroke-color"/>
         <xsl:with-param name="rotation"            select="$rotation"/>
         <xsl:with-param name="url"                 select="$url"/>
         <xsl:with-param name="h-text-pad"          select="$h-text-pad"/>
         <xsl:with-param name="h-align-text"        select="$h-align-text"/>
         <xsl:with-param name="v-align-text"        select="$v-align-text"/>
         <xsl:with-param name="ignore"              select="idm:getIdentifier($visual-element-hash,$resource)"/>
      </xsl:call-template>
      <!--xsl:message select="concat('rdf2.xsl JUST CREATED. hasIdentified: ',idm:hasIdentified($visual-element-hash,$resource))"/-->
   </xsl:if>
</xsl:template>


<!-- TODO: move these to a utils file -->

<xd:doc>Pretty print</xd:doc>
<xsl:variable name="in" select="'     '"/>

</xsl:transform>
