<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:datafaqs="http://purl.org/twc/vocab/datafaqs#">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="datafaqs"                select="'http://purl.org/twc/vocab/datafaqs#'"/>

<!-- Terms within the namespace -->
<xsl:variable name="datafaqs:CKANDataset"    select="concat($datafaqs,'CKANDataset')"/>
<xsl:variable name="datafaqs:CKANGroup"    select="concat($datafaqs,'CKANGroup')"/>
<xsl:variable name="datafaqs:Composite"    select="concat($datafaqs,'Composite')"/>
<xsl:variable name="datafaqs:CoreService"    select="concat($datafaqs,'CoreService')"/>
<xsl:variable name="datafaqs:CoreServiceInput"    select="concat($datafaqs,'CoreServiceInput')"/>
<xsl:variable name="datafaqs:DatasetAugmenter"    select="concat($datafaqs,'DatasetAugmenter')"/>
<xsl:variable name="datafaqs:DatasetAugmenting"    select="concat($datafaqs,'DatasetAugmenting')"/>
<xsl:variable name="datafaqs:DatasetCollection"    select="concat($datafaqs,'DatasetCollection')"/>
<xsl:variable name="datafaqs:DatasetReferencer"    select="concat($datafaqs,'DatasetReferencer')"/>
<xsl:variable name="datafaqs:DatasetReferencing"    select="concat($datafaqs,'DatasetReferencing')"/>
<xsl:variable name="datafaqs:DatasetSelection"    select="concat($datafaqs,'DatasetSelection')"/>
<xsl:variable name="datafaqs:DatasetSelector"    select="concat($datafaqs,'DatasetSelector')"/>
<xsl:variable name="datafaqs:DatasetWithDump"    select="concat($datafaqs,'DatasetWithDump')"/>
<xsl:variable name="datafaqs:Epoch"    select="concat($datafaqs,'Epoch')"/>
<xsl:variable name="datafaqs:Error"    select="concat($datafaqs,'Error')"/>
<xsl:variable name="datafaqs:Evaluated"    select="concat($datafaqs,'Evaluated')"/>
<xsl:variable name="datafaqs:EvaluatedDataset"    select="concat($datafaqs,'EvaluatedDataset')"/>
<xsl:variable name="datafaqs:Evaluation"    select="concat($datafaqs,'Evaluation')"/>
<xsl:variable name="datafaqs:FAqTBrick"    select="concat($datafaqs,'FAqTBrick')"/>
<xsl:variable name="datafaqs:FAqTBrickExplorer"    select="concat($datafaqs,'FAqTBrickExplorer')"/>
<xsl:variable name="datafaqs:FAqTReferencing"    select="concat($datafaqs,'FAqTReferencing')"/>
<xsl:variable name="datafaqs:FAqTSelection"    select="concat($datafaqs,'FAqTSelection')"/>
<xsl:variable name="datafaqs:FAqTSelector"    select="concat($datafaqs,'FAqTSelector')"/>
<xsl:variable name="datafaqs:FAqTService"    select="concat($datafaqs,'FAqTService')"/>
<xsl:variable name="datafaqs:FAqTServiceCollection"    select="concat($datafaqs,'FAqTServiceCollection')"/>
<xsl:variable name="datafaqs:Modified"    select="concat($datafaqs,'Modified')"/>
<xsl:variable name="datafaqs:ModifiedCKANDataset"    select="concat($datafaqs,'ModifiedCKANDataset')"/>
<xsl:variable name="datafaqs:NotCKANDataset"    select="concat($datafaqs,'NotCKANDataset')"/>
<xsl:variable name="datafaqs:SADIService"    select="concat($datafaqs,'SADIService')"/>
<xsl:variable name="datafaqs:SPARQLQuery"    select="concat($datafaqs,'SPARQLQuery')"/>
<xsl:variable name="datafaqs:Satisfactory"    select="concat($datafaqs,'Satisfactory')"/>
<xsl:variable name="datafaqs:SourceCode"    select="concat($datafaqs,'SourceCode')"/>
<xsl:variable name="datafaqs:Tagged"    select="concat($datafaqs,'Tagged')"/>
<xsl:variable name="datafaqs:TaggedCKANDataset"    select="concat($datafaqs,'TaggedCKANDataset')"/>
<xsl:variable name="datafaqs:Unsatisfactory"    select="concat($datafaqs,'Unsatisfactory')"/>
<xsl:variable name="datafaqs:dataset"    select="concat($datafaqs,'dataset')"/>
<xsl:variable name="datafaqs:evaluation_error"    select="concat($datafaqs,'evaluation_error')"/>
<xsl:variable name="datafaqs:internet_domain"    select="concat($datafaqs,'internet_domain')"/>
<xsl:variable name="datafaqs:namespace"    select="concat($datafaqs,'namespace')"/>
<xsl:variable name="datafaqs:powered_by"    select="concat($datafaqs,'powered_by')"/>
<xsl:variable name="datafaqs:query"    select="concat($datafaqs,'query')"/>
<xsl:variable name="datafaqs:resolved_triples"    select="concat($datafaqs,'resolved_triples')"/>

<xsl:variable name="datafaqs:ALL" select="(
   $datafaqs:FAqTBrickExplorer,
   $datafaqs:namespace,
   $datafaqs:FAqTServiceCollection,
   $datafaqs:powered_by,
   $datafaqs:SADIService,
   $datafaqs:FAqTSelection,
   $datafaqs:dataset,
   $datafaqs:Tagged,
   $datafaqs:NotCKANDataset,
   $datafaqs:DatasetSelection,
   $datafaqs:DatasetReferencing,
   $datafaqs:Composite,
   $datafaqs:resolved_triples,
   $datafaqs:internet_domain,
   $datafaqs:SPARQLQuery,
   $datafaqs:Evaluation,
   $datafaqs:DatasetCollection,
   $datafaqs:DatasetSelector,
   $datafaqs:DatasetAugmenter,
   $datafaqs:evaluation_error,
   $datafaqs:Unsatisfactory,
   $datafaqs:FAqTBrick,
   $datafaqs:Satisfactory,
   $datafaqs:Modified,
   $datafaqs:CoreServiceInput,
   $datafaqs:ModifiedCKANDataset,
   $datafaqs:FAqTReferencing,
   $datafaqs:DatasetReferencer,
   $datafaqs:DatasetAugmenting,
   $datafaqs:Error,
   $datafaqs:CoreService,
   $datafaqs:FAqTService,
   $datafaqs:Epoch,
   $datafaqs:CKANDataset,
   $datafaqs:query,
   $datafaqs:CKANGroup,
   $datafaqs:DatasetWithDump,
   $datafaqs:EvaluatedDataset,
   $datafaqs:SourceCode,
   $datafaqs:Evaluated,
   $datafaqs:TaggedCKANDataset,
   $datafaqs:FAqTSelector
)"/>

</xsl:transform>
