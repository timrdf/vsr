<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:frbr="http://purl.org/vocab/frbr/core#">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="frbr"                select="'http://purl.org/vocab/frbr/core#'"/>

<!-- Terms within the namespace -->
<xsl:variable name="frbr:ClassicalWork"    select="concat($frbr,'ClassicalWork')"/>
<xsl:variable name="frbr:Concept"    select="concat($frbr,'Concept')"/>
<xsl:variable name="frbr:CorporateBody"    select="concat($frbr,'CorporateBody')"/>
<xsl:variable name="frbr:Data"    select="concat($frbr,'Data')"/>
<xsl:variable name="frbr:Endeavour"    select="concat($frbr,'Endeavour')"/>
<xsl:variable name="frbr:Event"    select="concat($frbr,'Event')"/>
<xsl:variable name="frbr:Expression"    select="concat($frbr,'Expression')"/>
<xsl:variable name="frbr:Image"    select="concat($frbr,'Image')"/>
<xsl:variable name="frbr:Item"    select="concat($frbr,'Item')"/>
<xsl:variable name="frbr:LegalWork"    select="concat($frbr,'LegalWork')"/>
<xsl:variable name="frbr:LiteraryWork"    select="concat($frbr,'LiteraryWork')"/>
<xsl:variable name="frbr:Manifestation"    select="concat($frbr,'Manifestation')"/>
<xsl:variable name="frbr:MovingImage"    select="concat($frbr,'MovingImage')"/>
<xsl:variable name="frbr:Object"    select="concat($frbr,'Object')"/>
<xsl:variable name="frbr:Performance"    select="concat($frbr,'Performance')"/>
<xsl:variable name="frbr:Person"    select="concat($frbr,'Person')"/>
<xsl:variable name="frbr:Place"    select="concat($frbr,'Place')"/>
<xsl:variable name="frbr:ResponsibleEntity"    select="concat($frbr,'ResponsibleEntity')"/>
<xsl:variable name="frbr:ScholarlyWork"    select="concat($frbr,'ScholarlyWork')"/>
<xsl:variable name="frbr:Sound"    select="concat($frbr,'Sound')"/>
<xsl:variable name="frbr:Subject"    select="concat($frbr,'Subject')"/>
<xsl:variable name="frbr:Text"    select="concat($frbr,'Text')"/>
<xsl:variable name="frbr:Work"    select="concat($frbr,'Work')"/>
<xsl:variable name="frbr:abridgement"    select="concat($frbr,'abridgement')"/>
<xsl:variable name="frbr:abridgementOf"    select="concat($frbr,'abridgementOf')"/>
<xsl:variable name="frbr:adaption"    select="concat($frbr,'adaption')"/>
<xsl:variable name="frbr:adaptionOf"    select="concat($frbr,'adaptionOf')"/>
<xsl:variable name="frbr:alternate"    select="concat($frbr,'alternate')"/>
<xsl:variable name="frbr:alternateOf"    select="concat($frbr,'alternateOf')"/>
<xsl:variable name="frbr:arrangement"    select="concat($frbr,'arrangement')"/>
<xsl:variable name="frbr:arrangementOf"    select="concat($frbr,'arrangementOf')"/>
<xsl:variable name="frbr:complement"    select="concat($frbr,'complement')"/>
<xsl:variable name="frbr:complementOf"    select="concat($frbr,'complementOf')"/>
<xsl:variable name="frbr:creator"    select="concat($frbr,'creator')"/>
<xsl:variable name="frbr:creatorOf"    select="concat($frbr,'creatorOf')"/>
<xsl:variable name="frbr:embodiment"    select="concat($frbr,'embodiment')"/>
<xsl:variable name="frbr:embodimentOf"    select="concat($frbr,'embodimentOf')"/>
<xsl:variable name="frbr:exemplar"    select="concat($frbr,'exemplar')"/>
<xsl:variable name="frbr:exemplarOf"    select="concat($frbr,'exemplarOf')"/>
<xsl:variable name="frbr:imitation"    select="concat($frbr,'imitation')"/>
<xsl:variable name="frbr:imitationOf"    select="concat($frbr,'imitationOf')"/>
<xsl:variable name="frbr:owner"    select="concat($frbr,'owner')"/>
<xsl:variable name="frbr:ownerOf"    select="concat($frbr,'ownerOf')"/>
<xsl:variable name="frbr:part"    select="concat($frbr,'part')"/>
<xsl:variable name="frbr:partOf"    select="concat($frbr,'partOf')"/>
<xsl:variable name="frbr:producer"    select="concat($frbr,'producer')"/>
<xsl:variable name="frbr:producerOf"    select="concat($frbr,'producerOf')"/>
<xsl:variable name="frbr:realization"    select="concat($frbr,'realization')"/>
<xsl:variable name="frbr:realizationOf"    select="concat($frbr,'realizationOf')"/>
<xsl:variable name="frbr:realizer"    select="concat($frbr,'realizer')"/>
<xsl:variable name="frbr:realizerOf"    select="concat($frbr,'realizerOf')"/>
<xsl:variable name="frbr:reconfiguration"    select="concat($frbr,'reconfiguration')"/>
<xsl:variable name="frbr:reconfigurationOf"    select="concat($frbr,'reconfigurationOf')"/>
<xsl:variable name="frbr:relatedEndeavour"    select="concat($frbr,'relatedEndeavour')"/>
<xsl:variable name="frbr:reproduction"    select="concat($frbr,'reproduction')"/>
<xsl:variable name="frbr:reproductionOf"    select="concat($frbr,'reproductionOf')"/>
<xsl:variable name="frbr:responsibleEntity"    select="concat($frbr,'responsibleEntity')"/>
<xsl:variable name="frbr:responsibleEntityOf"    select="concat($frbr,'responsibleEntityOf')"/>
<xsl:variable name="frbr:revision"    select="concat($frbr,'revision')"/>
<xsl:variable name="frbr:revisionOf"    select="concat($frbr,'revisionOf')"/>
<xsl:variable name="frbr:subject"    select="concat($frbr,'subject')"/>
<xsl:variable name="frbr:successor"    select="concat($frbr,'successor')"/>
<xsl:variable name="frbr:successorOf"    select="concat($frbr,'successorOf')"/>
<xsl:variable name="frbr:summarization"    select="concat($frbr,'summarization')"/>
<xsl:variable name="frbr:summarizationOf"    select="concat($frbr,'summarizationOf')"/>
<xsl:variable name="frbr:supplement"    select="concat($frbr,'supplement')"/>
<xsl:variable name="frbr:supplementOf"    select="concat($frbr,'supplementOf')"/>
<xsl:variable name="frbr:transformation"    select="concat($frbr,'transformation')"/>
<xsl:variable name="frbr:transformationOf"    select="concat($frbr,'transformationOf')"/>
<xsl:variable name="frbr:translation"    select="concat($frbr,'translation')"/>
<xsl:variable name="frbr:translationOf"    select="concat($frbr,'translationOf')"/>

<xsl:variable name="frbr:ALL" select="(
   $frbr:arrangementOf,
   $frbr:creatorOf,
   $frbr:embodimentOf,
   $frbr:partOf,
   $frbr:Data,
   $frbr:reproductionOf,
   $frbr:realizationOf,
   $frbr:translationOf,
   $frbr:revisionOf,
   $frbr:Text,
   $frbr:adaptionOf,
   $frbr:Concept,
   $frbr:LiteraryWork,
   $frbr:abridgement,
   $frbr:successor,
   $frbr:reproduction,
   $frbr:ScholarlyWork,
   $frbr:alternate,
   $frbr:Performance,
   $frbr:Person,
   $frbr:CorporateBody,
   $frbr:transformationOf,
   $frbr:realizer,
   $frbr:arrangement,
   $frbr:adaption,
   $frbr:ClassicalWork,
   $frbr:ownerOf,
   $frbr:Object,
   $frbr:realization,
   $frbr:LegalWork,
   $frbr:supplement,
   $frbr:abridgementOf,
   $frbr:summarization,
   $frbr:responsibleEntityOf,
   $frbr:part,
   $frbr:reconfiguration,
   $frbr:exemplarOf,
   $frbr:reconfigurationOf,
   $frbr:alternateOf,
   $frbr:realizerOf,
   $frbr:Image,
   $frbr:creator,
   $frbr:summarizationOf,
   $frbr:Subject,
   $frbr:responsibleEntity,
   $frbr:Manifestation,
   $frbr:complementOf,
   $frbr:imitation,
   $frbr:Endeavour,
   $frbr:producer,
   $frbr:exemplar,
   $frbr:Expression,
   $frbr:translation,
   $frbr:Event,
   $frbr:producerOf,
   $frbr:complement,
   $frbr:embodiment,
   $frbr:ResponsibleEntity,
   $frbr:Item,
   $frbr:Place,
   $frbr:transformation,
   $frbr:revision,
   $frbr:MovingImage,
   $frbr:subject,
   $frbr:relatedEndeavour,
   $frbr:Sound,
   $frbr:successorOf,
   $frbr:owner,
   $frbr:Work,
   $frbr:supplementOf,
   $frbr:imitationOf
)"/>

</xsl:transform>
