<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:prov="http://www.w3.org/ns/prov#">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="prov"                select="'http://www.w3.org/ns/prov#'"/>

<!-- Terms within the namespace -->
<xsl:variable name="prov:Activity"    select="concat($prov,'Activity')"/>
<xsl:variable name="prov:ActivityInfluence"    select="concat($prov,'ActivityInfluence')"/>
<xsl:variable name="prov:Agent"    select="concat($prov,'Agent')"/>
<xsl:variable name="prov:AgentInfluence"    select="concat($prov,'AgentInfluence')"/>
<xsl:variable name="prov:Association"    select="concat($prov,'Association')"/>
<xsl:variable name="prov:Attribution"    select="concat($prov,'Attribution')"/>
<xsl:variable name="prov:Bundle"    select="concat($prov,'Bundle')"/>
<xsl:variable name="prov:Collection"    select="concat($prov,'Collection')"/>
<xsl:variable name="prov:Communication"    select="concat($prov,'Communication')"/>
<xsl:variable name="prov:Delegation"    select="concat($prov,'Delegation')"/>
<xsl:variable name="prov:Derivation"    select="concat($prov,'Derivation')"/>
<xsl:variable name="prov:EmptyCollection"    select="concat($prov,'EmptyCollection')"/>
<xsl:variable name="prov:End"    select="concat($prov,'End')"/>
<xsl:variable name="prov:Entity"    select="concat($prov,'Entity')"/>
<xsl:variable name="prov:EntityInfluence"    select="concat($prov,'EntityInfluence')"/>
<xsl:variable name="prov:Generation"    select="concat($prov,'Generation')"/>
<xsl:variable name="prov:Influence"    select="concat($prov,'Influence')"/>
<xsl:variable name="prov:InstantaneousEvent"    select="concat($prov,'InstantaneousEvent')"/>
<xsl:variable name="prov:Invalidation"    select="concat($prov,'Invalidation')"/>
<xsl:variable name="prov:Location"    select="concat($prov,'Location')"/>
<xsl:variable name="prov:Organization"    select="concat($prov,'Organization')"/>
<xsl:variable name="prov:Person"    select="concat($prov,'Person')"/>
<xsl:variable name="prov:Plan"    select="concat($prov,'Plan')"/>
<xsl:variable name="prov:PrimarySource"    select="concat($prov,'PrimarySource')"/>
<xsl:variable name="prov:Quotation"    select="concat($prov,'Quotation')"/>
<xsl:variable name="prov:Revision"    select="concat($prov,'Revision')"/>
<xsl:variable name="prov:Role"    select="concat($prov,'Role')"/>
<xsl:variable name="prov:SoftwareAgent"    select="concat($prov,'SoftwareAgent')"/>
<xsl:variable name="prov:Start"    select="concat($prov,'Start')"/>
<xsl:variable name="prov:Usage"    select="concat($prov,'Usage')"/>
<xsl:variable name="prov:actedOnBehalfOf"    select="concat($prov,'actedOnBehalfOf')"/>
<xsl:variable name="prov:activity"    select="concat($prov,'activity')"/>
<xsl:variable name="prov:agent"    select="concat($prov,'agent')"/>
<xsl:variable name="prov:alternateOf"    select="concat($prov,'alternateOf')"/>
<xsl:variable name="prov:atLocation"    select="concat($prov,'atLocation')"/>
<xsl:variable name="prov:atTime"    select="concat($prov,'atTime')"/>
<xsl:variable name="prov:endedAtTime"    select="concat($prov,'endedAtTime')"/>
<xsl:variable name="prov:entity"    select="concat($prov,'entity')"/>
<xsl:variable name="prov:generated"    select="concat($prov,'generated')"/>
<xsl:variable name="prov:generatedAtTime"    select="concat($prov,'generatedAtTime')"/>
<xsl:variable name="prov:hadActivity"    select="concat($prov,'hadActivity')"/>
<xsl:variable name="prov:hadGeneration"    select="concat($prov,'hadGeneration')"/>
<xsl:variable name="prov:hadMember"    select="concat($prov,'hadMember')"/>
<xsl:variable name="prov:hadPlan"    select="concat($prov,'hadPlan')"/>
<xsl:variable name="prov:hadPrimarySource"    select="concat($prov,'hadPrimarySource')"/>
<xsl:variable name="prov:hadRole"    select="concat($prov,'hadRole')"/>
<xsl:variable name="prov:hadUsage"    select="concat($prov,'hadUsage')"/>
<xsl:variable name="prov:influenced"    select="concat($prov,'influenced')"/>
<xsl:variable name="prov:influencer"    select="concat($prov,'influencer')"/>
<xsl:variable name="prov:invalidated"    select="concat($prov,'invalidated')"/>
<xsl:variable name="prov:invalidatedAtTime"    select="concat($prov,'invalidatedAtTime')"/>
<xsl:variable name="prov:qualifiedAssociation"    select="concat($prov,'qualifiedAssociation')"/>
<xsl:variable name="prov:qualifiedAttribution"    select="concat($prov,'qualifiedAttribution')"/>
<xsl:variable name="prov:qualifiedCommunication"    select="concat($prov,'qualifiedCommunication')"/>
<xsl:variable name="prov:qualifiedDelegation"    select="concat($prov,'qualifiedDelegation')"/>
<xsl:variable name="prov:qualifiedDerivation"    select="concat($prov,'qualifiedDerivation')"/>
<xsl:variable name="prov:qualifiedEnd"    select="concat($prov,'qualifiedEnd')"/>
<xsl:variable name="prov:qualifiedGeneration"    select="concat($prov,'qualifiedGeneration')"/>
<xsl:variable name="prov:qualifiedInfluence"    select="concat($prov,'qualifiedInfluence')"/>
<xsl:variable name="prov:qualifiedInvalidation"    select="concat($prov,'qualifiedInvalidation')"/>
<xsl:variable name="prov:qualifiedPrimarySource"    select="concat($prov,'qualifiedPrimarySource')"/>
<xsl:variable name="prov:qualifiedQuotation"    select="concat($prov,'qualifiedQuotation')"/>
<xsl:variable name="prov:qualifiedRevision"    select="concat($prov,'qualifiedRevision')"/>
<xsl:variable name="prov:qualifiedStart"    select="concat($prov,'qualifiedStart')"/>
<xsl:variable name="prov:qualifiedUsage"    select="concat($prov,'qualifiedUsage')"/>
<xsl:variable name="prov:specializationOf"    select="concat($prov,'specializationOf')"/>
<xsl:variable name="prov:startedAtTime"    select="concat($prov,'startedAtTime')"/>
<xsl:variable name="prov:used"    select="concat($prov,'used')"/>
<xsl:variable name="prov:value"    select="concat($prov,'value')"/>
<xsl:variable name="prov:wasAssociatedWith"    select="concat($prov,'wasAssociatedWith')"/>
<xsl:variable name="prov:wasAttributedTo"    select="concat($prov,'wasAttributedTo')"/>
<xsl:variable name="prov:wasDerivedFrom"    select="concat($prov,'wasDerivedFrom')"/>
<xsl:variable name="prov:wasEndedBy"    select="concat($prov,'wasEndedBy')"/>
<xsl:variable name="prov:wasGeneratedBy"    select="concat($prov,'wasGeneratedBy')"/>
<xsl:variable name="prov:wasInfluencedBy"    select="concat($prov,'wasInfluencedBy')"/>
<xsl:variable name="prov:wasInformedBy"    select="concat($prov,'wasInformedBy')"/>
<xsl:variable name="prov:wasInvalidatedBy"    select="concat($prov,'wasInvalidatedBy')"/>
<xsl:variable name="prov:wasQuotedFrom"    select="concat($prov,'wasQuotedFrom')"/>
<xsl:variable name="prov:wasRevisionOf"    select="concat($prov,'wasRevisionOf')"/>
<xsl:variable name="prov:wasStartedBy"    select="concat($prov,'wasStartedBy')"/>

<xsl:variable name="prov:ALL" select="(
   $prov:wasInformedBy,
   $prov:qualifiedUsage,
   $prov:PrimarySource,
   $prov:Derivation,
   $prov:qualifiedQuotation,
   $prov:hadPrimarySource,
   $prov:wasInvalidatedBy,
   $prov:invalidated,
   $prov:qualifiedStart,
   $prov:hadUsage,
   $prov:Generation,
   $prov:EntityInfluence,
   $prov:Communication,
   $prov:wasQuotedFrom,
   $prov:Entity,
   $prov:InstantaneousEvent,
   $prov:qualifiedEnd,
   $prov:actedOnBehalfOf,
   $prov:atLocation,
   $prov:Collection,
   $prov:wasAssociatedWith,
   $prov:invalidatedAtTime,
   $prov:Usage,
   $prov:Revision,
   $prov:EmptyCollection,
   $prov:atTime,
   $prov:Activity,
   $prov:startedAtTime,
   $prov:Location,
   $prov:wasDerivedFrom,
   $prov:Start,
   $prov:generatedAtTime,
   $prov:wasStartedBy,
   $prov:generated,
   $prov:End,
   $prov:value,
   $prov:specializationOf,
   $prov:ActivityInfluence,
   $prov:qualifiedInvalidation,
   $prov:Agent,
   $prov:qualifiedDelegation,
   $prov:Organization,
   $prov:qualifiedAttribution,
   $prov:hadActivity,
   $prov:Role,
   $prov:Bundle,
   $prov:influenced,
   $prov:Invalidation,
   $prov:wasInfluencedBy,
   $prov:wasGeneratedBy,
   $prov:qualifiedRevision,
   $prov:qualifiedPrimarySource,
   $prov:activity,
   $prov:Plan,
   $prov:wasEndedBy,
   $prov:wasAttributedTo,
   $prov:Delegation,
   $prov:qualifiedDerivation,
   $prov:qualifiedAssociation,
   $prov:hadGeneration,
   $prov:Attribution,
   $prov:entity,
   $prov:Influence,
   $prov:SoftwareAgent,
   $prov:AgentInfluence,
   $prov:hadRole,
   $prov:Person,
   $prov:qualifiedGeneration,
   $prov:used,
   $prov:alternateOf,
   $prov:Association,
   $prov:qualifiedCommunication,
   $prov:hadPlan,
   $prov:endedAtTime,
   $prov:qualifiedInfluence,
   $prov:Quotation,
   $prov:influencer,
   $prov:hadMember,
   $prov:agent,
   $prov:wasRevisionOf
)"/>

</xsl:transform>
