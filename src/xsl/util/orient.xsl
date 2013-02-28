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

<xd:doc>
   <xd:short>Return the subject of the current RDF/XML predicate element.</xd:short>
   <xd:detail>This is a shorthand function because it is needed by every predicate element 
             (e.g., when at XPath <i>rdf:Description/rdf:type</i>)
              when "situating to the domain form".
              This should be called by every RDF/XML predicate element.</xd:detail>
   <xd:param name="predicateElement" type="node()">The RDF/XML predicate element.</xd:param>
</xd:doc>
<xsl:function name="vsr:getSubject">
   <xsl:param name="predicateElement" as="node()"/>
   <xsl:copy-of select="$predicateElement/../@rdf:about | $predicateElement/../@rdf:nodeID"/>
</xsl:function>

<xd:doc>
   <xd:short>Return the object of the current RDF/XML predicate element.</xd:short>
   <xd:detail>This is a shorthand function because it is needed by every predicate element 
             (e.g., when at XPath <i>rdf:Description/rdf:type</i>)
              when "situating to the domain form".
              This should be called by every RDF/XML predicate element.</xd:detail>
   <xd:param name="predicateElement" type="node()">The RDF/XML predicate element.</xd:param>
</xd:doc>
<xsl:function name="vsr:getObject">
   <xsl:param name="predicateElement" as="node()"/>
   <xsl:if test="count($predicateElement/text()) gt 1">
      <xsl:message select="'more than one text()'"/> 
   </xsl:if>
   <xsl:choose>
      <xsl:when test="$predicateElement/@rdf:resource | $predicateElement/@rdf:nodeID">
         <xsl:copy-of select="$predicateElement/@rdf:resource | $predicateElement/@rdf:nodeID"/>
      </xsl:when>
      <xsl:when test="count($predicateElement/text()) gt 1">
         <xsl:value-of select="concat($predicateElement/text()[1],'___DROPPED_CONTENT')"/>
      </xsl:when>
      <xsl:when test="$predicateElement/text()">
         <xsl:copy-of select="$predicateElement/text()"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:copy-of select="''"/>
      </xsl:otherwise>
   </xsl:choose>
</xsl:function>

</xsl:transform>
