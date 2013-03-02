<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:conversion="http://purl.org/twc/vocab/conversion/">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="conversion"                select="'http://purl.org/twc/vocab/conversion/'"/>

<!-- Terms within the namespace -->
<xsl:variable name="conversion:AbstractDataset"    select="concat($conversion,'AbstractDataset')"/>
<xsl:variable name="conversion:AuxiliaryDataset"    select="concat($conversion,'AuxiliaryDataset')"/>
<xsl:variable name="conversion:BooleanPromotionEnhancement"    select="concat($conversion,'BooleanPromotionEnhancement')"/>
<xsl:variable name="conversion:BooleanSymbolInterpretation"    select="concat($conversion,'BooleanSymbolInterpretation')"/>
<xsl:variable name="conversion:CSV2RDF4LOD_environment_variables"    select="concat($conversion,'CSV2RDF4LOD_environment_variables')"/>
<xsl:variable name="conversion:CaseInsensitiveLODLink"    select="concat($conversion,'CaseInsensitiveLODLink')"/>
<xsl:variable name="conversion:CatalogedDataset"    select="concat($conversion,'CatalogedDataset')"/>
<xsl:variable name="conversion:ConversionMetaDataset"    select="concat($conversion,'ConversionMetaDataset')"/>
<xsl:variable name="conversion:ConversionProcess"    select="concat($conversion,'ConversionProcess')"/>
<xsl:variable name="conversion:ConversionTrigger"    select="concat($conversion,'ConversionTrigger')"/>
<xsl:variable name="conversion:Curl"    select="concat($conversion,'Curl')"/>
<xsl:variable name="conversion:DataEndRow"    select="concat($conversion,'DataEndRow')"/>
<xsl:variable name="conversion:DataStartRow"    select="concat($conversion,'DataStartRow')"/>
<xsl:variable name="conversion:Dataset"    select="concat($conversion,'Dataset')"/>
<xsl:variable name="conversion:DatasetCatalog"    select="concat($conversion,'DatasetCatalog')"/>
<xsl:variable name="conversion:DatasetSample"    select="concat($conversion,'DatasetSample')"/>
<xsl:variable name="conversion:DatatypePromotionEnhancement"    select="concat($conversion,'DatatypePromotionEnhancement')"/>
<xsl:variable name="conversion:DatePromotionEnhancement"    select="concat($conversion,'DatePromotionEnhancement')"/>
<xsl:variable name="conversion:DateTimePromotionEnhancement"    select="concat($conversion,'DateTimePromotionEnhancement')"/>
<xsl:variable name="conversion:Deprecated"    select="concat($conversion,'Deprecated')"/>
<xsl:variable name="conversion:DirectSameAsEnhancement"    select="concat($conversion,'DirectSameAsEnhancement')"/>
<xsl:variable name="conversion:DocumentState"    select="concat($conversion,'DocumentState')"/>
<xsl:variable name="conversion:Enhancement"    select="concat($conversion,'Enhancement')"/>
<xsl:variable name="conversion:EnhancementProcess"    select="concat($conversion,'EnhancementProcess')"/>
<xsl:variable name="conversion:ExampleResource"    select="concat($conversion,'ExampleResource')"/>
<xsl:variable name="conversion:ExistingBundleEnhancement"    select="concat($conversion,'ExistingBundleEnhancement')"/>
<xsl:variable name="conversion:HTTPHeader"    select="concat($conversion,'HTTPHeader')"/>
<xsl:variable name="conversion:HeaderRow"    select="concat($conversion,'HeaderRow')"/>
<xsl:variable name="conversion:ImplicitBundle"    select="concat($conversion,'ImplicitBundle')"/>
<xsl:variable name="conversion:ImplicitBundleEnhancement"    select="concat($conversion,'ImplicitBundleEnhancement')"/>
<xsl:variable name="conversion:IncludesLODLinks"    select="concat($conversion,'IncludesLODLinks')"/>
<xsl:variable name="conversion:IndirectSameAsEnhancement"    select="concat($conversion,'IndirectSameAsEnhancement')"/>
<xsl:variable name="conversion:InterpretedAsNullEnhancement"    select="concat($conversion,'InterpretedAsNullEnhancement')"/>
<xsl:variable name="conversion:LODLinks"    select="concat($conversion,'LODLinks')"/>
<xsl:variable name="conversion:LabelRenameEnhancement"    select="concat($conversion,'LabelRenameEnhancement')"/>
<xsl:variable name="conversion:LargeValue"    select="concat($conversion,'LargeValue')"/>
<xsl:variable name="conversion:LayerDataset"    select="concat($conversion,'LayerDataset')"/>
<xsl:variable name="conversion:MetaDataset"    select="concat($conversion,'MetaDataset')"/>
<xsl:variable name="conversion:MultiplierEnhancement"    select="concat($conversion,'MultiplierEnhancement')"/>
<xsl:variable name="conversion:ObjectEnhancement"    select="concat($conversion,'ObjectEnhancement')"/>
<xsl:variable name="conversion:ObjectSameAsEnhancement"    select="concat($conversion,'ObjectSameAsEnhancement')"/>
<xsl:variable name="conversion:ObjectSameAsEnhancementViaLookup"    select="concat($conversion,'ObjectSameAsEnhancementViaLookup')"/>
<xsl:variable name="conversion:Omitted"    select="concat($conversion,'Omitted')"/>
<xsl:variable name="conversion:Only_if_column"    select="concat($conversion,'Only_if_column')"/>
<xsl:variable name="conversion:PredicateEnhancement"    select="concat($conversion,'PredicateEnhancement')"/>
<xsl:variable name="conversion:PropertyCommentEnhancement"    select="concat($conversion,'PropertyCommentEnhancement')"/>
<xsl:variable name="conversion:PropertyScopedResourcePromotionEnhancement"    select="concat($conversion,'PropertyScopedResourcePromotionEnhancement')"/>
<xsl:variable name="conversion:RawConversionProcess"    select="concat($conversion,'RawConversionProcess')"/>
<xsl:variable name="conversion:Repeat_previous_if_empty_column"    select="concat($conversion,'Repeat_previous_if_empty_column')"/>
<xsl:variable name="conversion:ResourceCastEnhancement"    select="concat($conversion,'ResourceCastEnhancement')"/>
<xsl:variable name="conversion:ResourcePromotionEnhancement"    select="concat($conversion,'ResourcePromotionEnhancement')"/>
<xsl:variable name="conversion:SameAsDataset"    select="concat($conversion,'SameAsDataset')"/>
<xsl:variable name="conversion:SameAsEnhancement"    select="concat($conversion,'SameAsEnhancement')"/>
<xsl:variable name="conversion:ServiceEndpoint"    select="concat($conversion,'ServiceEndpoint')"/>
<xsl:variable name="conversion:Source"    select="concat($conversion,'Source')"/>
<xsl:variable name="conversion:SubClassEnhancement"    select="concat($conversion,'SubClassEnhancement')"/>
<xsl:variable name="conversion:SubPropertyEnhancement"    select="concat($conversion,'SubPropertyEnhancement')"/>
<xsl:variable name="conversion:SubjectAnnotation"    select="concat($conversion,'SubjectAnnotation')"/>
<xsl:variable name="conversion:SubjectEnhancement"    select="concat($conversion,'SubjectEnhancement')"/>
<xsl:variable name="conversion:SubjectSameAsEnhancement"    select="concat($conversion,'SubjectSameAsEnhancement')"/>
<xsl:variable name="conversion:SubjectSameAsEnhancementViaLookup"    select="concat($conversion,'SubjectSameAsEnhancementViaLookup')"/>
<xsl:variable name="conversion:SubjectTypeEnhancement"    select="concat($conversion,'SubjectTypeEnhancement')"/>
<xsl:variable name="conversion:SymbolInterpretation"    select="concat($conversion,'SymbolInterpretation')"/>
<xsl:variable name="conversion:TemplateResourcePromotionEnhancement"    select="concat($conversion,'TemplateResourcePromotionEnhancement')"/>
<xsl:variable name="conversion:TripleStore"    select="concat($conversion,'TripleStore')"/>
<xsl:variable name="conversion:TypedResourcePromotionEnhancement"    select="concat($conversion,'TypedResourcePromotionEnhancement')"/>
<xsl:variable name="conversion:UnitTestedDataset"    select="concat($conversion,'UnitTestedDataset')"/>
<xsl:variable name="conversion:VersionControlledDataset"    select="concat($conversion,'VersionControlledDataset')"/>
<xsl:variable name="conversion:VersionedDataset"    select="concat($conversion,'VersionedDataset')"/>
<xsl:variable name="conversion:base_uri"    select="concat($conversion,'base_uri')"/>
<xsl:variable name="conversion:bundled_by"    select="concat($conversion,'bundled_by')"/>
<xsl:variable name="conversion:class_name"    select="concat($conversion,'class_name')"/>
<xsl:variable name="conversion:comment"    select="concat($conversion,'comment')"/>
<xsl:variable name="conversion:conceptual_depth"    select="concat($conversion,'conceptual_depth')"/>
<xsl:variable name="conversion:conversion_identifier"    select="concat($conversion,'conversion_identifier')"/>
<xsl:variable name="conversion:conversion_process"    select="concat($conversion,'conversion_process')"/>
<xsl:variable name="conversion:dataset_file"    select="concat($conversion,'dataset_file')"/>
<xsl:variable name="conversion:dataset_identifier"    select="concat($conversion,'dataset_identifier')"/>
<xsl:variable name="conversion:date_pattern"    select="concat($conversion,'date_pattern')"/>
<xsl:variable name="conversion:datetime_pattern"    select="concat($conversion,'datetime_pattern')"/>
<xsl:variable name="conversion:datetime_timezone"    select="concat($conversion,'datetime_timezone')"/>
<xsl:variable name="conversion:delimits_cell"    select="concat($conversion,'delimits_cell')"/>
<xsl:variable name="conversion:delimits_object"    select="concat($conversion,'delimits_object')"/>
<xsl:variable name="conversion:domain_name"    select="concat($conversion,'domain_name')"/>
<xsl:variable name="conversion:domain_template"    select="concat($conversion,'domain_template')"/>
<xsl:variable name="conversion:eg"    select="concat($conversion,'eg')"/>
<xsl:variable name="conversion:encoding"    select="concat($conversion,'encoding')"/>
<xsl:variable name="conversion:enhance"    select="concat($conversion,'enhance')"/>
<xsl:variable name="conversion:enhancement_identifier"    select="concat($conversion,'enhancement_identifier')"/>
<xsl:variable name="conversion:equivalent_property"    select="concat($conversion,'equivalent_property')"/>
<xsl:variable name="conversion:interpret"    select="concat($conversion,'interpret')"/>
<xsl:variable name="conversion:interpretation"    select="concat($conversion,'interpretation')"/>
<xsl:variable name="conversion:label"    select="concat($conversion,'label')"/>
<xsl:variable name="conversion:links_via"    select="concat($conversion,'links_via')"/>
<xsl:variable name="conversion:multiplier"    select="concat($conversion,'multiplier')"/>
<xsl:variable name="conversion:name_template"    select="concat($conversion,'name_template')"/>
<xsl:variable name="conversion:num_invocation_logs"    select="concat($conversion,'num_invocation_logs')"/>
<xsl:variable name="conversion:num_triples"    select="concat($conversion,'num_triples')"/>
<xsl:variable name="conversion:object"    select="concat($conversion,'object')"/>
<xsl:variable name="conversion:object_search"    select="concat($conversion,'object_search')"/>
<xsl:variable name="conversion:pattern"    select="concat($conversion,'pattern')"/>
<xsl:variable name="conversion:predicate"    select="concat($conversion,'predicate')"/>
<xsl:variable name="conversion:predicate_identifier"    select="concat($conversion,'predicate_identifier')"/>
<xsl:variable name="conversion:property_name"    select="concat($conversion,'property_name')"/>
<xsl:variable name="conversion:range"    select="concat($conversion,'range')"/>
<xsl:variable name="conversion:range_name"    select="concat($conversion,'range_name')"/>
<xsl:variable name="conversion:range_template"    select="concat($conversion,'range_template')"/>
<xsl:variable name="conversion:regex"    select="concat($conversion,'regex')"/>
<xsl:variable name="conversion:source_data"    select="concat($conversion,'source_data')"/>
<xsl:variable name="conversion:source_identifier"    select="concat($conversion,'source_identifier')"/>
<xsl:variable name="conversion:subclass_of"    select="concat($conversion,'subclass_of')"/>
<xsl:variable name="conversion:subject_of"    select="concat($conversion,'subject_of')"/>
<xsl:variable name="conversion:subproperty_of"    select="concat($conversion,'subproperty_of')"/>
<xsl:variable name="conversion:subseT"    select="concat($conversion,'subseT')"/>
<xsl:variable name="conversion:symbol"    select="concat($conversion,'symbol')"/>
<xsl:variable name="conversion:template_pattern"    select="concat($conversion,'template_pattern')"/>
<xsl:variable name="conversion:testable_by"    select="concat($conversion,'testable_by')"/>
<xsl:variable name="conversion:triples_per_minute"    select="concat($conversion,'triples_per_minute')"/>
<xsl:variable name="conversion:type_name"    select="concat($conversion,'type_name')"/>
<xsl:variable name="conversion:version_identifier"    select="concat($conversion,'version_identifier')"/>

<xsl:variable name="conversion:ALL" select="(
   $conversion:multiplier,
   $conversion:CaseInsensitiveLODLink,
   $conversion:LabelRenameEnhancement,
   $conversion:subclass_of,
   $conversion:IndirectSameAsEnhancement,
   $conversion:ImplicitBundle,
   $conversion:pattern,
   $conversion:LODLinks,
   $conversion:Deprecated,
   $conversion:ObjectSameAsEnhancementViaLookup,
   $conversion:datetime_pattern,
   $conversion:label,
   $conversion:Repeat_previous_if_empty_column,
   $conversion:InterpretedAsNullEnhancement,
   $conversion:SubPropertyEnhancement,
   $conversion:VersionedDataset,
   $conversion:PropertyCommentEnhancement,
   $conversion:conversion_identifier,
   $conversion:MultiplierEnhancement,
   $conversion:bundled_by,
   $conversion:AbstractDataset,
   $conversion:predicate,
   $conversion:version_identifier,
   $conversion:ObjectSameAsEnhancement,
   $conversion:num_invocation_logs,
   $conversion:ExistingBundleEnhancement,
   $conversion:eg,
   $conversion:Source,
   $conversion:HeaderRow,
   $conversion:name_template,
   $conversion:predicate_identifier,
   $conversion:DatasetCatalog,
   $conversion:TypedResourcePromotionEnhancement,
   $conversion:DatasetSample,
   $conversion:range_template,
   $conversion:range_name,
   $conversion:ObjectEnhancement,
   $conversion:type_name,
   $conversion:SubjectSameAsEnhancement,
   $conversion:DataEndRow,
   $conversion:TemplateResourcePromotionEnhancement,
   $conversion:Only_if_column,
   $conversion:interpret,
   $conversion:SubjectSameAsEnhancementViaLookup,
   $conversion:object_search,
   $conversion:RawConversionProcess,
   $conversion:UnitTestedDataset,
   $conversion:dataset_file,
   $conversion:Curl,
   $conversion:SameAsEnhancement,
   $conversion:date_pattern,
   $conversion:delimits_cell,
   $conversion:ExampleResource,
   $conversion:ConversionTrigger,
   $conversion:MetaDataset,
   $conversion:DocumentState,
   $conversion:ResourcePromotionEnhancement,
   $conversion:testable_by,
   $conversion:IncludesLODLinks,
   $conversion:encoding,
   $conversion:source_identifier,
   $conversion:SubjectEnhancement,
   $conversion:equivalent_property,
   $conversion:template_pattern,
   $conversion:ConversionMetaDataset,
   $conversion:ImplicitBundleEnhancement,
   $conversion:source_data,
   $conversion:object,
   $conversion:ServiceEndpoint,
   $conversion:TripleStore,
   $conversion:DateTimePromotionEnhancement,
   $conversion:regex,
   $conversion:LayerDataset,
   $conversion:CatalogedDataset,
   $conversion:subject_of,
   $conversion:range,
   $conversion:PredicateEnhancement,
   $conversion:delimits_object,
   $conversion:links_via,
   $conversion:DataStartRow,
   $conversion:class_name,
   $conversion:SubClassEnhancement,
   $conversion:datetime_timezone,
   $conversion:LargeValue,
   $conversion:base_uri,
   $conversion:DatePromotionEnhancement,
   $conversion:Dataset,
   $conversion:ConversionProcess,
   $conversion:DatatypePromotionEnhancement,
   $conversion:AuxiliaryDataset,
   $conversion:VersionControlledDataset,
   $conversion:Enhancement,
   $conversion:SubjectTypeEnhancement,
   $conversion:conversion_process,
   $conversion:symbol,
   $conversion:SubjectAnnotation,
   $conversion:property_name,
   $conversion:domain_template,
   $conversion:comment,
   $conversion:BooleanSymbolInterpretation,
   $conversion:SameAsDataset,
   $conversion:BooleanPromotionEnhancement,
   $conversion:CSV2RDF4LOD_environment_variables,
   $conversion:domain_name,
   $conversion:enhance,
   $conversion:ResourceCastEnhancement,
   $conversion:triples_per_minute,
   $conversion:subseT,
   $conversion:HTTPHeader,
   $conversion:SymbolInterpretation,
   $conversion:interpretation,
   $conversion:EnhancementProcess,
   $conversion:PropertyScopedResourcePromotionEnhancement,
   $conversion:conceptual_depth,
   $conversion:num_triples,
   $conversion:dataset_identifier,
   $conversion:subproperty_of,
   $conversion:Omitted,
   $conversion:DirectSameAsEnhancement,
   $conversion:enhancement_identifier
)"/>

</xsl:transform>
