<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:dcterms="http://purl.org/dc/terms/">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="dcterms"                select="'http://purl.org/dc/terms/'"/>

<!-- Terms within the namespace -->
<xsl:variable name="dcterms:Agent"    select="concat($dcterms,'Agent')"/>
<xsl:variable name="dcterms:AgentClass"    select="concat($dcterms,'AgentClass')"/>
<xsl:variable name="dcterms:BibliographicResource"    select="concat($dcterms,'BibliographicResource')"/>
<xsl:variable name="dcterms:FileFormat"    select="concat($dcterms,'FileFormat')"/>
<xsl:variable name="dcterms:Frequency"    select="concat($dcterms,'Frequency')"/>
<xsl:variable name="dcterms:Jurisdiction"    select="concat($dcterms,'Jurisdiction')"/>
<xsl:variable name="dcterms:LicenseDocument"    select="concat($dcterms,'LicenseDocument')"/>
<xsl:variable name="dcterms:LinguisticSystem"    select="concat($dcterms,'LinguisticSystem')"/>
<xsl:variable name="dcterms:Location"    select="concat($dcterms,'Location')"/>
<xsl:variable name="dcterms:LocationPeriodOrJurisdiction"    select="concat($dcterms,'LocationPeriodOrJurisdiction')"/>
<xsl:variable name="dcterms:MediaType"    select="concat($dcterms,'MediaType')"/>
<xsl:variable name="dcterms:MediaTypeOrExtent"    select="concat($dcterms,'MediaTypeOrExtent')"/>
<xsl:variable name="dcterms:MethodOfAccrual"    select="concat($dcterms,'MethodOfAccrual')"/>
<xsl:variable name="dcterms:MethodOfInstruction"    select="concat($dcterms,'MethodOfInstruction')"/>
<xsl:variable name="dcterms:PeriodOfTime"    select="concat($dcterms,'PeriodOfTime')"/>
<xsl:variable name="dcterms:PhysicalMedium"    select="concat($dcterms,'PhysicalMedium')"/>
<xsl:variable name="dcterms:PhysicalResource"    select="concat($dcterms,'PhysicalResource')"/>
<xsl:variable name="dcterms:Policy"    select="concat($dcterms,'Policy')"/>
<xsl:variable name="dcterms:ProvenanceStatement"    select="concat($dcterms,'ProvenanceStatement')"/>
<xsl:variable name="dcterms:RightsStatement"    select="concat($dcterms,'RightsStatement')"/>
<xsl:variable name="dcterms:SizeOrDuration"    select="concat($dcterms,'SizeOrDuration')"/>
<xsl:variable name="dcterms:Standard"    select="concat($dcterms,'Standard')"/>
<xsl:variable name="dcterms:abstract"    select="concat($dcterms,'abstract')"/>
<xsl:variable name="dcterms:accessRights"    select="concat($dcterms,'accessRights')"/>
<xsl:variable name="dcterms:accrualMethod"    select="concat($dcterms,'accrualMethod')"/>
<xsl:variable name="dcterms:accrualPeriodicity"    select="concat($dcterms,'accrualPeriodicity')"/>
<xsl:variable name="dcterms:accrualPolicy"    select="concat($dcterms,'accrualPolicy')"/>
<xsl:variable name="dcterms:alternative"    select="concat($dcterms,'alternative')"/>
<xsl:variable name="dcterms:audience"    select="concat($dcterms,'audience')"/>
<xsl:variable name="dcterms:available"    select="concat($dcterms,'available')"/>
<xsl:variable name="dcterms:bibliographicCitation"    select="concat($dcterms,'bibliographicCitation')"/>
<xsl:variable name="dcterms:conformsTo"    select="concat($dcterms,'conformsTo')"/>
<xsl:variable name="dcterms:contributor"    select="concat($dcterms,'contributor')"/>
<xsl:variable name="dcterms:coverage"    select="concat($dcterms,'coverage')"/>
<xsl:variable name="dcterms:created"    select="concat($dcterms,'created')"/>
<xsl:variable name="dcterms:creator"    select="concat($dcterms,'creator')"/>
<xsl:variable name="dcterms:date"    select="concat($dcterms,'date')"/>
<xsl:variable name="dcterms:dateAccepted"    select="concat($dcterms,'dateAccepted')"/>
<xsl:variable name="dcterms:dateCopyrighted"    select="concat($dcterms,'dateCopyrighted')"/>
<xsl:variable name="dcterms:dateSubmitted"    select="concat($dcterms,'dateSubmitted')"/>
<xsl:variable name="dcterms:description"    select="concat($dcterms,'description')"/>
<xsl:variable name="dcterms:educationLevel"    select="concat($dcterms,'educationLevel')"/>
<xsl:variable name="dcterms:extent"    select="concat($dcterms,'extent')"/>
<xsl:variable name="dcterms:format"    select="concat($dcterms,'format')"/>
<xsl:variable name="dcterms:hasFormat"    select="concat($dcterms,'hasFormat')"/>
<xsl:variable name="dcterms:hasPart"    select="concat($dcterms,'hasPart')"/>
<xsl:variable name="dcterms:hasVersion"    select="concat($dcterms,'hasVersion')"/>
<xsl:variable name="dcterms:identifier"    select="concat($dcterms,'identifier')"/>
<xsl:variable name="dcterms:instructionalMethod"    select="concat($dcterms,'instructionalMethod')"/>
<xsl:variable name="dcterms:isFormatOf"    select="concat($dcterms,'isFormatOf')"/>
<xsl:variable name="dcterms:isPartOf"    select="concat($dcterms,'isPartOf')"/>
<xsl:variable name="dcterms:isReferencedBy"    select="concat($dcterms,'isReferencedBy')"/>
<xsl:variable name="dcterms:isReplacedBy"    select="concat($dcterms,'isReplacedBy')"/>
<xsl:variable name="dcterms:isRequiredBy"    select="concat($dcterms,'isRequiredBy')"/>
<xsl:variable name="dcterms:isVersionOf"    select="concat($dcterms,'isVersionOf')"/>
<xsl:variable name="dcterms:issued"    select="concat($dcterms,'issued')"/>
<xsl:variable name="dcterms:language"    select="concat($dcterms,'language')"/>
<xsl:variable name="dcterms:license"    select="concat($dcterms,'license')"/>
<xsl:variable name="dcterms:mediator"    select="concat($dcterms,'mediator')"/>
<xsl:variable name="dcterms:medium"    select="concat($dcterms,'medium')"/>
<xsl:variable name="dcterms:modified"    select="concat($dcterms,'modified')"/>
<xsl:variable name="dcterms:provenance"    select="concat($dcterms,'provenance')"/>
<xsl:variable name="dcterms:publisher"    select="concat($dcterms,'publisher')"/>
<xsl:variable name="dcterms:references"    select="concat($dcterms,'references')"/>
<xsl:variable name="dcterms:relation"    select="concat($dcterms,'relation')"/>
<xsl:variable name="dcterms:replaces"    select="concat($dcterms,'replaces')"/>
<xsl:variable name="dcterms:requires"    select="concat($dcterms,'requires')"/>
<xsl:variable name="dcterms:rights"    select="concat($dcterms,'rights')"/>
<xsl:variable name="dcterms:rightsHolder"    select="concat($dcterms,'rightsHolder')"/>
<xsl:variable name="dcterms:source"    select="concat($dcterms,'source')"/>
<xsl:variable name="dcterms:spatial"    select="concat($dcterms,'spatial')"/>
<xsl:variable name="dcterms:subject"    select="concat($dcterms,'subject')"/>
<xsl:variable name="dcterms:tableOfContents"    select="concat($dcterms,'tableOfContents')"/>
<xsl:variable name="dcterms:temporal"    select="concat($dcterms,'temporal')"/>
<xsl:variable name="dcterms:title"    select="concat($dcterms,'title')"/>
<xsl:variable name="dcterms:type"    select="concat($dcterms,'type')"/>
<xsl:variable name="dcterms:valid"    select="concat($dcterms,'valid')"/>

<xsl:variable name="dcterms:ALL" select="(
   $dcterms:accrualMethod,
   $dcterms:abstract,
   $dcterms:ProvenanceStatement,
   $dcterms:AgentClass,
   $dcterms:hasVersion,
   $dcterms:issued,
   $dcterms:isReferencedBy,
   $dcterms:audience,
   $dcterms:accrualPeriodicity,
   $dcterms:MediaTypeOrExtent,
   $dcterms:references,
   $dcterms:type,
   $dcterms:available,
   $dcterms:FileFormat,
   $dcterms:LicenseDocument,
   $dcterms:PhysicalResource,
   $dcterms:requires,
   $dcterms:extent,
   $dcterms:date,
   $dcterms:PeriodOfTime,
   $dcterms:Location,
   $dcterms:title,
   $dcterms:instructionalMethod,
   $dcterms:source,
   $dcterms:mediator,
   $dcterms:MethodOfAccrual,
   $dcterms:isFormatOf,
   $dcterms:dateCopyrighted,
   $dcterms:LinguisticSystem,
   $dcterms:medium,
   $dcterms:hasPart,
   $dcterms:contributor,
   $dcterms:isPartOf,
   $dcterms:created,
   $dcterms:SizeOrDuration,
   $dcterms:PhysicalMedium,
   $dcterms:Jurisdiction,
   $dcterms:language,
   $dcterms:Frequency,
   $dcterms:Agent,
   $dcterms:subject,
   $dcterms:publisher,
   $dcterms:isVersionOf,
   $dcterms:format,
   $dcterms:dateSubmitted,
   $dcterms:replaces,
   $dcterms:hasFormat,
   $dcterms:coverage,
   $dcterms:LocationPeriodOrJurisdiction,
   $dcterms:rightsHolder,
   $dcterms:Policy,
   $dcterms:spatial,
   $dcterms:provenance,
   $dcterms:educationLevel,
   $dcterms:conformsTo,
   $dcterms:accessRights,
   $dcterms:MediaType,
   $dcterms:license,
   $dcterms:identifier,
   $dcterms:Standard,
   $dcterms:isRequiredBy,
   $dcterms:temporal,
   $dcterms:description,
   $dcterms:bibliographicCitation,
   $dcterms:RightsStatement,
   $dcterms:dateAccepted,
   $dcterms:alternative,
   $dcterms:accrualPolicy,
   $dcterms:relation,
   $dcterms:creator,
   $dcterms:MethodOfInstruction,
   $dcterms:tableOfContents,
   $dcterms:rights,
   $dcterms:modified,
   $dcterms:isReplacedBy,
   $dcterms:BibliographicResource,
   $dcterms:valid
)"/>

</xsl:transform>
