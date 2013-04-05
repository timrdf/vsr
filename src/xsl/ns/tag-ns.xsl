<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:tag="http://www.holygoat.co.uk/owl/redwood/0.1/tags/">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="tag"                select="'http://www.holygoat.co.uk/owl/redwood/0.1/tags/'"/>

<!-- Terms within the namespace -->
<xsl:variable name="tag:RestrictedTagging"    select="concat($tag,'RestrictedTagging')"/>
<xsl:variable name="tag:Tag"    select="concat($tag,'Tag')"/>
<xsl:variable name="tag:Tagging"    select="concat($tag,'Tagging')"/>
<xsl:variable name="tag:associatedTag"    select="concat($tag,'associatedTag')"/>
<xsl:variable name="tag:equivalentTag"    select="concat($tag,'equivalentTag')"/>
<xsl:variable name="tag:isTagOf"    select="concat($tag,'isTagOf')"/>
<xsl:variable name="tag:name"    select="concat($tag,'name')"/>
<xsl:variable name="tag:relatedTag"    select="concat($tag,'relatedTag')"/>
<xsl:variable name="tag:tag"    select="concat($tag,'tag')"/>
<xsl:variable name="tag:tagName"    select="concat($tag,'tagName')"/>
<xsl:variable name="tag:taggedBy"    select="concat($tag,'taggedBy')"/>
<xsl:variable name="tag:taggedOn"    select="concat($tag,'taggedOn')"/>
<xsl:variable name="tag:taggedResource"    select="concat($tag,'taggedResource')"/>
<xsl:variable name="tag:taggedWithTag"    select="concat($tag,'taggedWithTag')"/>

<xsl:variable name="tag:ALL" select="(
   $tag:taggedOn,
   $tag:isTagOf,
   $tag:name,
   $tag:tag,
   $tag:associatedTag,
   $tag:relatedTag,
   $tag:taggedResource,
   $tag:tagName,
   $tag:equivalentTag,
   $tag:Tagging,
   $tag:RestrictedTagging,
   $tag:taggedBy,
   $tag:Tag,
   $tag:taggedWithTag
)"/>

</xsl:transform>
