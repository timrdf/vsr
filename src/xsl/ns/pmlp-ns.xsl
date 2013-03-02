<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:pmlp="http://inference-web.org/2.0/pml-provenance.owl#">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="pmlp"                select="'http://inference-web.org/2.0/pml-provenance.owl#'"/>

<!-- Terms within the namespace -->
<xsl:variable name="pmlp:java"    select="concat($pmlp,'java')"/>
<xsl:variable name="pmlp:Agent"    select="concat($pmlp,'Agent')"/>
<xsl:variable name="pmlp:AgentList"    select="concat($pmlp,'AgentList')"/>
<xsl:variable name="pmlp:Dataset"    select="concat($pmlp,'Dataset')"/>
<xsl:variable name="pmlp:DeclarativeRule"    select="concat($pmlp,'DeclarativeRule')"/>
<xsl:variable name="pmlp:Document"    select="concat($pmlp,'Document')"/>
<xsl:variable name="pmlp:DocumentFragment"    select="concat($pmlp,'DocumentFragment')"/>
<xsl:variable name="pmlp:DocumentFragmentByOffset"    select="concat($pmlp,'DocumentFragmentByOffset')"/>
<xsl:variable name="pmlp:DocumentFragmentByRowCol"    select="concat($pmlp,'DocumentFragmentByRowCol')"/>
<xsl:variable name="pmlp:EmptyInformation"    select="concat($pmlp,'EmptyInformation')"/>
<xsl:variable name="pmlp:Format"    select="concat($pmlp,'Format')"/>
<xsl:variable name="pmlp:IdentifiedThing"    select="concat($pmlp,'IdentifiedThing')"/>
<xsl:variable name="pmlp:InferenceEngine"    select="concat($pmlp,'InferenceEngine')"/>
<xsl:variable name="pmlp:InferenceRule"    select="concat($pmlp,'InferenceRule')"/>
<xsl:variable name="pmlp:Information"    select="concat($pmlp,'Information')"/>
<xsl:variable name="pmlp:Language"    select="concat($pmlp,'Language')"/>
<xsl:variable name="pmlp:LearnedSourceUsage"    select="concat($pmlp,'LearnedSourceUsage')"/>
<xsl:variable name="pmlp:MethodRule"    select="concat($pmlp,'MethodRule')"/>
<xsl:variable name="pmlp:Ontology"    select="concat($pmlp,'Ontology')"/>
<xsl:variable name="pmlp:Organization"    select="concat($pmlp,'Organization')"/>
<xsl:variable name="pmlp:Person"    select="concat($pmlp,'Person')"/>
<xsl:variable name="pmlp:PrettyNameMapping"    select="concat($pmlp,'PrettyNameMapping')"/>
<xsl:variable name="pmlp:PrettyNameMappingList"    select="concat($pmlp,'PrettyNameMappingList')"/>
<xsl:variable name="pmlp:Publication"    select="concat($pmlp,'Publication')"/>
<xsl:variable name="pmlp:Sensor"    select="concat($pmlp,'Sensor')"/>
<xsl:variable name="pmlp:Software"    select="concat($pmlp,'Software')"/>
<xsl:variable name="pmlp:Source"    select="concat($pmlp,'Source')"/>
<xsl:variable name="pmlp:SourceUsage"    select="concat($pmlp,'SourceUsage')"/>
<xsl:variable name="pmlp:TranslationRule"    select="concat($pmlp,'TranslationRule')"/>
<xsl:variable name="pmlp:WebService"    select="concat($pmlp,'WebService')"/>
<xsl:variable name="pmlp:Website"    select="concat($pmlp,'Website')"/>
<xsl:variable name="pmlp:hasAbstract"    select="concat($pmlp,'hasAbstract')"/>
<xsl:variable name="pmlp:hasAuthorList"    select="concat($pmlp,'hasAuthorList')"/>
<xsl:variable name="pmlp:hasConfidenceValue"    select="concat($pmlp,'hasConfidenceValue')"/>
<xsl:variable name="pmlp:hasContent"    select="concat($pmlp,'hasContent')"/>
<xsl:variable name="pmlp:hasCreationDateTime"    select="concat($pmlp,'hasCreationDateTime')"/>
<xsl:variable name="pmlp:hasDataCollectionEndDateTime"    select="concat($pmlp,'hasDataCollectionEndDateTime')"/>
<xsl:variable name="pmlp:hasDataCollectionStartDateTime"    select="concat($pmlp,'hasDataCollectionStartDateTime')"/>
<xsl:variable name="pmlp:hasDescription"    select="concat($pmlp,'hasDescription')"/>
<xsl:variable name="pmlp:hasDocument"    select="concat($pmlp,'hasDocument')"/>
<xsl:variable name="pmlp:hasEncoding"    select="concat($pmlp,'hasEncoding')"/>
<xsl:variable name="pmlp:hasEnglishDescriptionTemplate"    select="concat($pmlp,'hasEnglishDescriptionTemplate')"/>
<xsl:variable name="pmlp:hasEscapeCharacterSequence"    select="concat($pmlp,'hasEscapeCharacterSequence')"/>
<xsl:variable name="pmlp:hasFormat"    select="concat($pmlp,'hasFormat')"/>
<xsl:variable name="pmlp:hasFromCol"    select="concat($pmlp,'hasFromCol')"/>
<xsl:variable name="pmlp:hasFromLanguage"    select="concat($pmlp,'hasFromLanguage')"/>
<xsl:variable name="pmlp:hasFromOffset"    select="concat($pmlp,'hasFromOffset')"/>
<xsl:variable name="pmlp:hasFromRow"    select="concat($pmlp,'hasFromRow')"/>
<xsl:variable name="pmlp:hasISBN"    select="concat($pmlp,'hasISBN')"/>
<xsl:variable name="pmlp:hasInferenceEngineRule"    select="concat($pmlp,'hasInferenceEngineRule')"/>
<xsl:variable name="pmlp:hasLanguage"    select="concat($pmlp,'hasLanguage')"/>
<xsl:variable name="pmlp:hasLongPrettyName"    select="concat($pmlp,'hasLongPrettyName')"/>
<xsl:variable name="pmlp:hasMember"    select="concat($pmlp,'hasMember')"/>
<xsl:variable name="pmlp:hasMimetype"    select="concat($pmlp,'hasMimetype')"/>
<xsl:variable name="pmlp:hasModificationDateTime"    select="concat($pmlp,'hasModificationDateTime')"/>
<xsl:variable name="pmlp:hasName"    select="concat($pmlp,'hasName')"/>
<xsl:variable name="pmlp:hasOwner"    select="concat($pmlp,'hasOwner')"/>
<xsl:variable name="pmlp:hasPrettyName"    select="concat($pmlp,'hasPrettyName')"/>
<xsl:variable name="pmlp:hasPrettyNameMappingList"    select="concat($pmlp,'hasPrettyNameMappingList')"/>
<xsl:variable name="pmlp:hasPrettyString"    select="concat($pmlp,'hasPrettyString')"/>
<xsl:variable name="pmlp:hasPublicationDateTime"    select="concat($pmlp,'hasPublicationDateTime')"/>
<xsl:variable name="pmlp:hasPublisher"    select="concat($pmlp,'hasPublisher')"/>
<xsl:variable name="pmlp:hasRawString"    select="concat($pmlp,'hasRawString')"/>
<xsl:variable name="pmlp:hasReferenceSourceUsage"    select="concat($pmlp,'hasReferenceSourceUsage')"/>
<xsl:variable name="pmlp:hasReplacee"    select="concat($pmlp,'hasReplacee')"/>
<xsl:variable name="pmlp:hasRuleExample"    select="concat($pmlp,'hasRuleExample')"/>
<xsl:variable name="pmlp:hasShortPrettyName"    select="concat($pmlp,'hasShortPrettyName')"/>
<xsl:variable name="pmlp:hasSource"    select="concat($pmlp,'hasSource')"/>
<xsl:variable name="pmlp:hasToCol"    select="concat($pmlp,'hasToCol')"/>
<xsl:variable name="pmlp:hasToLanguage"    select="concat($pmlp,'hasToLanguage')"/>
<xsl:variable name="pmlp:hasToOffset"    select="concat($pmlp,'hasToOffset')"/>
<xsl:variable name="pmlp:hasToRow"    select="concat($pmlp,'hasToRow')"/>
<xsl:variable name="pmlp:hasURL"    select="concat($pmlp,'hasURL')"/>
<xsl:variable name="pmlp:hasUsageDateTime"    select="concat($pmlp,'hasUsageDateTime')"/>
<xsl:variable name="pmlp:hasUsageQueryContent"    select="concat($pmlp,'hasUsageQueryContent')"/>
<xsl:variable name="pmlp:hasVersion"    select="concat($pmlp,'hasVersion')"/>
<xsl:variable name="pmlp:isMemberOf"    select="concat($pmlp,'isMemberOf')"/>
<xsl:variable name="pmlp:usesInferenceEngine"    select="concat($pmlp,'usesInferenceEngine')"/>

<xsl:variable name="pmlp:ALL" select="(
   $pmlp:hasVersion,
   $pmlp:hasMimetype,
   $pmlp:hasLanguage,
   $pmlp:Language,
   $pmlp:hasISBN,
   $pmlp:hasFromRow,
   $pmlp:Information,
   $pmlp:hasRawString,
   $pmlp:Ontology,
   $pmlp:InferenceRule,
   $pmlp:hasPublisher,
   $pmlp:hasToLanguage,
   $pmlp:hasOwner,
   $pmlp:WebService,
   $pmlp:DocumentFragment,
   $pmlp:DeclarativeRule,
   $pmlp:hasURL,
   $pmlp:hasPrettyNameMappingList,
   $pmlp:IdentifiedThing,
   $pmlp:hasEnglishDescriptionTemplate,
   $pmlp:SourceUsage,
   $pmlp:hasModificationDateTime,
   $pmlp:PrettyNameMappingList,
   $pmlp:EmptyInformation,
   $pmlp:usesInferenceEngine,
   $pmlp:isMemberOf,
   $pmlp:hasToCol,
   $pmlp:DocumentFragmentByOffset,
   $pmlp:hasLongPrettyName,
   $pmlp:TranslationRule,
   $pmlp:PrettyNameMapping,
   $pmlp:java,
   $pmlp:hasSource,
   $pmlp:hasShortPrettyName,
   $pmlp:hasName,
   $pmlp:hasUsageQueryContent,
   $pmlp:hasCreationDateTime,
   $pmlp:hasReferenceSourceUsage,
   $pmlp:hasPrettyString,
   $pmlp:hasEscapeCharacterSequence,
   $pmlp:hasToOffset,
   $pmlp:hasMember,
   $pmlp:hasFromLanguage,
   $pmlp:hasPrettyName,
   $pmlp:hasDataCollectionStartDateTime,
   $pmlp:Agent,
   $pmlp:hasEncoding,
   $pmlp:hasFromCol,
   $pmlp:hasAbstract,
   $pmlp:DocumentFragmentByRowCol,
   $pmlp:Organization,
   $pmlp:hasRuleExample,
   $pmlp:hasDescription,
   $pmlp:hasInferenceEngineRule,
   $pmlp:hasFormat,
   $pmlp:hasAuthorList,
   $pmlp:hasPublicationDateTime,
   $pmlp:hasFromOffset,
   $pmlp:hasDocument,
   $pmlp:LearnedSourceUsage,
   $pmlp:AgentList,
   $pmlp:Sensor,
   $pmlp:Source,
   $pmlp:Dataset,
   $pmlp:MethodRule,
   $pmlp:Document,
   $pmlp:hasToRow,
   $pmlp:hasConfidenceValue,
   $pmlp:Person,
   $pmlp:hasDataCollectionEndDateTime,
   $pmlp:Software,
   $pmlp:hasReplacee,
   $pmlp:hasContent,
   $pmlp:Website,
   $pmlp:hasUsageDateTime,
   $pmlp:Format,
   $pmlp:Publication,
   $pmlp:InferenceEngine
)"/>

</xsl:transform>
