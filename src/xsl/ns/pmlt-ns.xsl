<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:pmlt="http://inference-web.org/2.0/pml-trust.owl#">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="pmlt"                select="'http://inference-web.org/2.0/pml-trust.owl#'"/>

<!-- Terms within the namespace -->
<xsl:variable name="pmlt:java"    select="concat($pmlt,'java')"/>
<xsl:variable name="pmlt:BeliefElement"    select="concat($pmlt,'BeliefElement')"/>
<xsl:variable name="pmlt:FloatBelief"    select="concat($pmlt,'FloatBelief')"/>
<xsl:variable name="pmlt:FloatMetric"    select="concat($pmlt,'FloatMetric')"/>
<xsl:variable name="pmlt:FloatTrust"    select="concat($pmlt,'FloatTrust')"/>
<xsl:variable name="pmlt:TrustElement"    select="concat($pmlt,'TrustElement')"/>
<xsl:variable name="pmlt:hasBelievedInformation"    select="concat($pmlt,'hasBelievedInformation')"/>
<xsl:variable name="pmlt:hasBelievingAgent"    select="concat($pmlt,'hasBelievingAgent')"/>
<xsl:variable name="pmlt:hasFloatValue"    select="concat($pmlt,'hasFloatValue')"/>
<xsl:variable name="pmlt:hasTrustee"    select="concat($pmlt,'hasTrustee')"/>
<xsl:variable name="pmlt:hasTrustor"    select="concat($pmlt,'hasTrustor')"/>

<xsl:variable name="pmlt:ALL" select="(
   $pmlt:hasBelievingAgent,
   $pmlt:FloatBelief,
   $pmlt:hasTrustee,
   $pmlt:FloatMetric,
   $pmlt:java,
   $pmlt:TrustElement,
   $pmlt:FloatTrust,
   $pmlt:hasBelievedInformation,
   $pmlt:hasFloatValue,
   $pmlt:BeliefElement,
   $pmlt:hasTrustor
)"/>

</xsl:transform>
