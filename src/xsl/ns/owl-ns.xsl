<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:time="http://www.w3.org/2006/time#">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="rdf" select="'http://www.w3.org/1999/02/22-rdf-syntax-ns#'"/>
<!-- Terms within the namespace -->
<xsl:variable name="rdf:type"         select="concat($rdf,'type')"/>
<xsl:variable name="rdf:Property"     select="concat($rdf,'Property')"/>
<xsl:variable name="rdf:Restriction"  select="concat($rdf,'Restriction')"/>
<xsl:variable name="rdf:Statement"    select="concat($rdf,'Statement')"/>
<xsl:variable name="rdf:subject"      select="concat($rdf,'subject')"/>
<xsl:variable name="rdf:predicate"    select="concat($rdf,'predicate')"/>
<xsl:variable name="rdf:object"       select="concat($rdf,'object')"/>
<xsl:variable name="rdf:List"         select="concat($rdf,'List')"/>
<xsl:variable name="rdf:first"        select="concat($rdf,'first')"/>
<xsl:variable name="rdf:rest"         select="concat($rdf,'rest')"/>
<xsl:variable name="rdf:nil"          select="concat($rdf,'nil')"/>

<xsl:variable name="rdf:Description"  select="concat($rdf,'Description')"/>
<xsl:variable name="rdf:about"        select="concat($rdf,'about')"/>
<xsl:variable name="rdf:nodeID"       select="concat($rdf,'nodeID')"/>
<xsl:variable name="rdf:resource"     select="concat($rdf,'resource')"/>

<!-- The namespace itself -->
<xsl:variable name="rdfs" select="'http://www.w3.org/2000/01/rdf-schema#'"/>
<!-- Terms within the namespace -->
<xsl:variable name="rdfs:Resource"    select="concat($rdfs,'Resource')"/>
<xsl:variable name="rdfs:Literal"     select="concat($rdfs,'Literal')"/>
<xsl:variable name="rdfs:Class"       select="concat($rdfs,'Class')"/>
<xsl:variable name="rdfs:domain"      select="concat($rdfs,'domain')"/>
<xsl:variable name="rdfs:range"       select="concat($rdfs,'range')"/>
<xsl:variable name="rdfs:label"       select="concat($rdfs,'label')"/>
<xsl:variable name="rdfs:comment"     select="concat($rdfs,'comment')"/>
<xsl:variable name="rdfs:isDefinedBy" select="concat($rdfs,'isDefinedBy')"/>
<xsl:variable name="rdfs:subClassOf"  select="concat($rdfs,'subClassOf')"/>

<!-- The namespace itself -->
<xsl:variable name="xs"               select="'http://www.w3.org/2001/XMLSchema#'"/>
<!-- Terms within the namespace -->
<xsl:variable name="xsinteger"        select="concat($xs,'integer')"/>

<!-- The namespace itself -->
<xsl:variable name="owl"                           select="'http://www.w3.org/2002/07/owl#'"/>
<!-- Terms within the namespace -->
<xsl:variable name="owl:Thing"                     select="concat($owl,'Thing')"/>
<xsl:variable name="owl:ObjectProperty"            select="concat($owl,'ObjectProperty')"/>
<xsl:variable name="owl:DatatypeProperty"          select="concat($owl,'DatatypeProperty')"/>
<xsl:variable name="owl:AnnotationProperty"        select="concat($owl,'AnnotationProperty')"/>
<xsl:variable name="owl:FunctionalProperty"        select="concat($owl,'FunctionalProperty')"/>
<xsl:variable name="owl:InverseFunctionalProperty" select="concat($owl,'InverseFunctionalProperty')"/>
<xsl:variable name="owl:Class"                     select="concat($owl,'Class')"/>
<xsl:variable name="owl:onProperty"                select="concat($owl,'onProperty')"/>
<xsl:variable name="owl:Restriction"               select="concat($owl,'Restriction')"/>
<xsl:variable name="owl:minCardinality"            select="concat($owl,'minCardinality')"/>
<xsl:variable name="owl:maxCardinality"            select="concat($owl,'maxCardinality')"/>
<xsl:variable name="owl:cardinality"               select="concat($owl,'cardinality')"/>
<xsl:variable name="owl:someValuesFrom"            select="concat($owl,'someValuesFrom')"/>
<xsl:variable name="owl:allValuesFrom"             select="concat($owl,'allValuesFrom')"/>
<xsl:variable name="owl:hasValue"                  select="concat($owl,'hasValue')"/>
<xsl:variable name="owl:disjointWith"              select="concat($owl,'disjointWith')"/>
<xsl:variable name="owl:unionOf"                   select="concat($owl,'unionOf')"/>
<xsl:variable name="owl:intersectionOf"            select="concat($owl,'intersectionOf')"/>
<xsl:variable name="owl:complementOf"              select="concat($owl,'complementOf')"/>
<xsl:variable name="owl:sameAs"                    select="concat($owl,'sameAs')"/>
<xsl:variable name="owl:Axiom"                     select="concat($owl,'Axiom')"/>
<xsl:variable name="owl:minQualifiedCardinality"   select="concat($owl,'minQualifiedCardinality')"/>
<xsl:variable name="owl:maxQualifiedCardinality"   select="concat($owl,'maxQualifiedCardinality')"/>
<xsl:variable name="owl:qualifiedCardinality"      select="concat($owl,'qualifiedCardinality')"/>
<xsl:variable name="owl:onDataRange"               select="concat($owl,'onDataRange')"/>
<xsl:variable name="owl:propertyChainAxiom"        select="concat($owl,'propertyChainAxiom')"/>
<xsl:variable name="owl:NamedIndividual"           select="concat($owl,'NamedIndividual')"/>

<!-- OWL Time -->
<xsl:variable name="time"               select="'http://www.w3.org/2006/time#'"/>
<xsl:variable name="time:inXSDDateTime" select="concat($time,'inXSDDateTime')"/>
<xsl:variable name="time:hasBeginning"  select="concat($time,'hasBeginning')"/>
<xsl:variable name="time:hasEnd"        select="concat($time,'hasEnd')"/>

</xsl:transform>
