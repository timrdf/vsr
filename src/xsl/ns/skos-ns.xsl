<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:skos="http://www.w3.org/2004/02/skos/core#">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="skos"                select="'http://www.w3.org/2004/02/skos/core#'"/>

<!-- Terms within the namespace -->
<xsl:variable name="skos:Collection"    select="concat($skos,'Collection')"/>
<xsl:variable name="skos:Concept"    select="concat($skos,'Concept')"/>
<xsl:variable name="skos:ConceptScheme"    select="concat($skos,'ConceptScheme')"/>
<xsl:variable name="skos:OrderedCollection"    select="concat($skos,'OrderedCollection')"/>
<xsl:variable name="skos:altLabel"    select="concat($skos,'altLabel')"/>
<xsl:variable name="skos:broadMatch"    select="concat($skos,'broadMatch')"/>
<xsl:variable name="skos:broader"    select="concat($skos,'broader')"/>
<xsl:variable name="skos:broaderTransitive"    select="concat($skos,'broaderTransitive')"/>
<xsl:variable name="skos:changeNote"    select="concat($skos,'changeNote')"/>
<xsl:variable name="skos:closeMatch"    select="concat($skos,'closeMatch')"/>
<xsl:variable name="skos:definition"    select="concat($skos,'definition')"/>
<xsl:variable name="skos:editorialNote"    select="concat($skos,'editorialNote')"/>
<xsl:variable name="skos:exactMatch"    select="concat($skos,'exactMatch')"/>
<xsl:variable name="skos:example"    select="concat($skos,'example')"/>
<xsl:variable name="skos:hasTopConcept"    select="concat($skos,'hasTopConcept')"/>
<xsl:variable name="skos:hiddenLabel"    select="concat($skos,'hiddenLabel')"/>
<xsl:variable name="skos:historyNote"    select="concat($skos,'historyNote')"/>
<xsl:variable name="skos:inScheme"    select="concat($skos,'inScheme')"/>
<xsl:variable name="skos:mappingRelation"    select="concat($skos,'mappingRelation')"/>
<xsl:variable name="skos:member"    select="concat($skos,'member')"/>
<xsl:variable name="skos:memberList"    select="concat($skos,'memberList')"/>
<xsl:variable name="skos:narrowMatch"    select="concat($skos,'narrowMatch')"/>
<xsl:variable name="skos:narrower"    select="concat($skos,'narrower')"/>
<xsl:variable name="skos:narrowerTransitive"    select="concat($skos,'narrowerTransitive')"/>
<xsl:variable name="skos:notation"    select="concat($skos,'notation')"/>
<xsl:variable name="skos:note"    select="concat($skos,'note')"/>
<xsl:variable name="skos:prefLabel"    select="concat($skos,'prefLabel')"/>
<xsl:variable name="skos:related"    select="concat($skos,'related')"/>
<xsl:variable name="skos:relatedMatch"    select="concat($skos,'relatedMatch')"/>
<xsl:variable name="skos:scopeNote"    select="concat($skos,'scopeNote')"/>
<xsl:variable name="skos:semanticRelation"    select="concat($skos,'semanticRelation')"/>
<xsl:variable name="skos:topConceptOf"    select="concat($skos,'topConceptOf')"/>

<xsl:variable name="skos:ALL" select="(
   $skos:notation,
   $skos:broaderTransitive,
   $skos:ConceptScheme,
   $skos:OrderedCollection,
   $skos:semanticRelation,
   $skos:member,
   $skos:narrowerTransitive,
   $skos:hasTopConcept,
   $skos:closeMatch,
   $skos:memberList,
   $skos:example,
   $skos:changeNote,
   $skos:altLabel,
   $skos:inScheme,
   $skos:broadMatch,
   $skos:relatedMatch,
   $skos:narrowMatch,
   $skos:exactMatch,
   $skos:definition,
   $skos:Concept,
   $skos:mappingRelation,
   $skos:scopeNote,
   $skos:related,
   $skos:editorialNote,
   $skos:prefLabel,
   $skos:note,
   $skos:narrower,
   $skos:historyNote,
   $skos:broader,
   $skos:Collection,
   $skos:hiddenLabel,
   $skos:topConceptOf
)"/>

</xsl:transform>
