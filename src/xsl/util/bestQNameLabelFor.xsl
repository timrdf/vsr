<xsl:transform version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:xfm="transform namespace"
   xmlns:pmm="edu.rpi.tw.string.pmm"
   xmlns:javapmap="java:edu.rpi.tw.string.pmm.DefaultPrefixMappings"
   exclude-result-prefixes="xs xfm">

<xd:doc type="stylesheet">
   <xd:short>Functions to shorten URIs to CURIE, label, etc.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<xd:doc>The Java instance of edu.rpi.tw.string.pmm.DefaultPrefixMappings.
</xd:doc>
<xsl:variable name="PMM_prefix_manager" select="javapmap:new()"/>

<xd:doc>
   Return true if the given URI can be abbreviated. Implemented by edu.rpi.tw.string.pmm.DefaultPrefixMappings#canAbbreviate
  <xd:param type="string">The URI that one is trying to abbreviate.</xd:param>
</xd:doc>
<xsl:function name="pmm:canAbbreviate">
   <xsl:param name="string_id" as="xs:string"/>
   <!-- Call DefaultPrefixMappings.canAbbreviate(String uri) on the instance PMM_prefix_manager -->
   <xsl:value-of select="javapmap:canAbbreviate($PMM_prefix_manager,$string_id)"/>
</xsl:function>

<xsl:function name="pmm:bestNamespace">
   <xsl:param name="string_id" as="xs:string"/>
   <xsl:value-of select="javapmap:bestNamespaceFor($PMM_prefix_manager,$string_id)"/>
</xsl:function>

<xsl:function name="pmm:bestPrefix">
   <xsl:param name="string_id" as="xs:string"/>
   <!-- Call DefaultPrefixMappings.bestPrefixFor(String uri) on the instance PMM_prefix_manager -->
   <xsl:value-of select="javapmap:bestPrefixFor($PMM_prefix_manager,$string_id)"/>
</xsl:function>

<xsl:function name="pmm:bestLocalName">
   <xsl:param name="string_id" as="xs:string"/>
   <!-- Call DefaultPrefixMappings.bestPrefixFor(String uri) on the instance PMM_prefix_manager -->
   <xsl:value-of select="javapmap:bestLocalNameFor($PMM_prefix_manager,$string_id)"/>
</xsl:function>

<xsl:function name="pmm:bestQName">
   <xsl:param name="string_id" as="xs:string"/>
   <!-- Call DefaultPrefixMappings.bestQNameFor(String uri) on the instance PMM_prefix_manager -->
   <xsl:value-of select="javapmap:bestQNameFor($PMM_prefix_manager,$string_id)"/>
</xsl:function>

<xsl:function name="pmm:bestQNameFor">
   <xsl:param name="string_id" as="xs:string"/>
   <!-- Call DefaultPrefixMappings.bestQNameFor(String uri) on the instance PMM_prefix_manager -->
   <xsl:value-of select="javapmap:bestQNameFor($PMM_prefix_manager,$string_id)"/>
</xsl:function>

<xsl:function name="pmm:tryQName">
   <xsl:param name="string_id" as="xs:string"/>
   <!-- Call DefaultPrefixMappings.bestQNameFor(String uri) on the instance PMM_prefix_manager -->
   <xsl:value-of select="javapmap:tryQName($PMM_prefix_manager,$string_id)"/>
</xsl:function>

<xsl:function name="pmm:bestLabelFor">
   <xsl:param name="string_id" as="xs:string"/>
   <!-- Call DefaultPrefixMappings.bestQNameFor(String uri) on the instance PMM_prefix_manager -->
   <xsl:value-of select="javapmap:bestLabelFor($PMM_prefix_manager,$string_id)"/>
</xsl:function>

<xsl:function name="pmm:bestLabel">
   <xsl:param name="string_id" as="xs:string"/>
   <!-- Call DefaultPrefixMappings.bestQNameFor(String uri) on the instance PMM_prefix_manager -->
   <xsl:value-of select="javapmap:bestLabelFor($PMM_prefix_manager,$string_id)"/>
</xsl:function>

</xsl:transform>
