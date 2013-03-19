<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:bibo="http://purl.org/ontology/bibo/">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="bibo"                select="'http://purl.org/ontology/bibo/'"/>

<!-- Terms within the namespace -->
<xsl:variable name="bibo:AcademicArticle"    select="concat($bibo,'AcademicArticle')"/>
<xsl:variable name="bibo:Article"    select="concat($bibo,'Article')"/>
<xsl:variable name="bibo:AudioDocument"    select="concat($bibo,'AudioDocument')"/>
<xsl:variable name="bibo:AudioVisualDocument"    select="concat($bibo,'AudioVisualDocument')"/>
<xsl:variable name="bibo:Bill"    select="concat($bibo,'Bill')"/>
<xsl:variable name="bibo:Book"    select="concat($bibo,'Book')"/>
<xsl:variable name="bibo:BookSection"    select="concat($bibo,'BookSection')"/>
<xsl:variable name="bibo:Brief"    select="concat($bibo,'Brief')"/>
<xsl:variable name="bibo:Chapter"    select="concat($bibo,'Chapter')"/>
<xsl:variable name="bibo:Code"    select="concat($bibo,'Code')"/>
<xsl:variable name="bibo:CollectedDocument"    select="concat($bibo,'CollectedDocument')"/>
<xsl:variable name="bibo:Collection"    select="concat($bibo,'Collection')"/>
<xsl:variable name="bibo:Conference"    select="concat($bibo,'Conference')"/>
<xsl:variable name="bibo:CourtReporter"    select="concat($bibo,'CourtReporter')"/>
<xsl:variable name="bibo:Document"    select="concat($bibo,'Document')"/>
<xsl:variable name="bibo:DocumentPart"    select="concat($bibo,'DocumentPart')"/>
<xsl:variable name="bibo:DocumentStatus"    select="concat($bibo,'DocumentStatus')"/>
<xsl:variable name="bibo:EditedBook"    select="concat($bibo,'EditedBook')"/>
<xsl:variable name="bibo:Email"    select="concat($bibo,'Email')"/>
<xsl:variable name="bibo:Event"    select="concat($bibo,'Event')"/>
<xsl:variable name="bibo:Excerpt"    select="concat($bibo,'Excerpt')"/>
<xsl:variable name="bibo:Film"    select="concat($bibo,'Film')"/>
<xsl:variable name="bibo:Hearing"    select="concat($bibo,'Hearing')"/>
<xsl:variable name="bibo:Image"    select="concat($bibo,'Image')"/>
<xsl:variable name="bibo:Interview"    select="concat($bibo,'Interview')"/>
<xsl:variable name="bibo:Issue"    select="concat($bibo,'Issue')"/>
<xsl:variable name="bibo:Journal"    select="concat($bibo,'Journal')"/>
<xsl:variable name="bibo:LegalCaseDocument"    select="concat($bibo,'LegalCaseDocument')"/>
<xsl:variable name="bibo:LegalDecision"    select="concat($bibo,'LegalDecision')"/>
<xsl:variable name="bibo:LegalDocument"    select="concat($bibo,'LegalDocument')"/>
<xsl:variable name="bibo:Legislation"    select="concat($bibo,'Legislation')"/>
<xsl:variable name="bibo:Letter"    select="concat($bibo,'Letter')"/>
<xsl:variable name="bibo:Magazine"    select="concat($bibo,'Magazine')"/>
<xsl:variable name="bibo:Manual"    select="concat($bibo,'Manual')"/>
<xsl:variable name="bibo:Manuscript"    select="concat($bibo,'Manuscript')"/>
<xsl:variable name="bibo:Map"    select="concat($bibo,'Map')"/>
<xsl:variable name="bibo:MultiVolumeBook"    select="concat($bibo,'MultiVolumeBook')"/>
<xsl:variable name="bibo:Newspaper"    select="concat($bibo,'Newspaper')"/>
<xsl:variable name="bibo:Note"    select="concat($bibo,'Note')"/>
<xsl:variable name="bibo:Patent"    select="concat($bibo,'Patent')"/>
<xsl:variable name="bibo:Performance"    select="concat($bibo,'Performance')"/>
<xsl:variable name="bibo:Periodical"    select="concat($bibo,'Periodical')"/>
<xsl:variable name="bibo:PersonalCommunication"    select="concat($bibo,'PersonalCommunication')"/>
<xsl:variable name="bibo:PersonalCommunicationDocument"    select="concat($bibo,'PersonalCommunicationDocument')"/>
<xsl:variable name="bibo:Proceedings"    select="concat($bibo,'Proceedings')"/>
<xsl:variable name="bibo:Quote"    select="concat($bibo,'Quote')"/>
<xsl:variable name="bibo:ReferenceSource"    select="concat($bibo,'ReferenceSource')"/>
<xsl:variable name="bibo:Report"    select="concat($bibo,'Report')"/>
<xsl:variable name="bibo:Series"    select="concat($bibo,'Series')"/>
<xsl:variable name="bibo:Slide"    select="concat($bibo,'Slide')"/>
<xsl:variable name="bibo:Slideshow"    select="concat($bibo,'Slideshow')"/>
<xsl:variable name="bibo:Standard"    select="concat($bibo,'Standard')"/>
<xsl:variable name="bibo:Statute"    select="concat($bibo,'Statute')"/>
<xsl:variable name="bibo:Thesis"    select="concat($bibo,'Thesis')"/>
<xsl:variable name="bibo:ThesisDegree"    select="concat($bibo,'ThesisDegree')"/>
<xsl:variable name="bibo:Webpage"    select="concat($bibo,'Webpage')"/>
<xsl:variable name="bibo:Website"    select="concat($bibo,'Website')"/>
<xsl:variable name="bibo:Workshop"    select="concat($bibo,'Workshop')"/>
<xsl:variable name="bibo:abstract"    select="concat($bibo,'abstract')"/>
<xsl:variable name="bibo:affirmedBy"    select="concat($bibo,'affirmedBy')"/>
<xsl:variable name="bibo:annotates"    select="concat($bibo,'annotates')"/>
<xsl:variable name="bibo:argued"    select="concat($bibo,'argued')"/>
<xsl:variable name="bibo:asin"    select="concat($bibo,'asin')"/>
<xsl:variable name="bibo:authorList"    select="concat($bibo,'authorList')"/>
<xsl:variable name="bibo:chapter"    select="concat($bibo,'chapter')"/>
<xsl:variable name="bibo:citedBy"    select="concat($bibo,'citedBy')"/>
<xsl:variable name="bibo:cites"    select="concat($bibo,'cites')"/>
<xsl:variable name="bibo:coden"    select="concat($bibo,'coden')"/>
<xsl:variable name="bibo:content"    select="concat($bibo,'content')"/>
<xsl:variable name="bibo:contributorList"    select="concat($bibo,'contributorList')"/>
<xsl:variable name="bibo:court"    select="concat($bibo,'court')"/>
<xsl:variable name="bibo:degree"    select="concat($bibo,'degree')"/>
<xsl:variable name="bibo:director"    select="concat($bibo,'director')"/>
<xsl:variable name="bibo:distributor"    select="concat($bibo,'distributor')"/>
<xsl:variable name="bibo:doi"    select="concat($bibo,'doi')"/>
<xsl:variable name="bibo:eanucc13"    select="concat($bibo,'eanucc13')"/>
<xsl:variable name="bibo:edition"    select="concat($bibo,'edition')"/>
<xsl:variable name="bibo:editor"    select="concat($bibo,'editor')"/>
<xsl:variable name="bibo:editorList"    select="concat($bibo,'editorList')"/>
<xsl:variable name="bibo:eissn"    select="concat($bibo,'eissn')"/>
<xsl:variable name="bibo:gtin14"    select="concat($bibo,'gtin14')"/>
<xsl:variable name="bibo:handle"    select="concat($bibo,'handle')"/>
<xsl:variable name="bibo:identifier"    select="concat($bibo,'identifier')"/>
<xsl:variable name="bibo:interviewee"    select="concat($bibo,'interviewee')"/>
<xsl:variable name="bibo:interviewer"    select="concat($bibo,'interviewer')"/>
<xsl:variable name="bibo:isbn"    select="concat($bibo,'isbn')"/>
<xsl:variable name="bibo:isbn10"    select="concat($bibo,'isbn10')"/>
<xsl:variable name="bibo:isbn13"    select="concat($bibo,'isbn13')"/>
<xsl:variable name="bibo:issn"    select="concat($bibo,'issn')"/>
<xsl:variable name="bibo:issue"    select="concat($bibo,'issue')"/>
<xsl:variable name="bibo:issuer"    select="concat($bibo,'issuer')"/>
<xsl:variable name="bibo:lccn"    select="concat($bibo,'lccn')"/>
<xsl:variable name="bibo:locator"    select="concat($bibo,'locator')"/>
<xsl:variable name="bibo:numPages"    select="concat($bibo,'numPages')"/>
<xsl:variable name="bibo:numVolumes"    select="concat($bibo,'numVolumes')"/>
<xsl:variable name="bibo:number"    select="concat($bibo,'number')"/>
<xsl:variable name="bibo:oclcnum"    select="concat($bibo,'oclcnum')"/>
<xsl:variable name="bibo:organizer"    select="concat($bibo,'organizer')"/>
<xsl:variable name="bibo:owner"    select="concat($bibo,'owner')"/>
<xsl:variable name="bibo:pageEnd"    select="concat($bibo,'pageEnd')"/>
<xsl:variable name="bibo:pageStart"    select="concat($bibo,'pageStart')"/>
<xsl:variable name="bibo:pages"    select="concat($bibo,'pages')"/>
<xsl:variable name="bibo:performer"    select="concat($bibo,'performer')"/>
<xsl:variable name="bibo:pmid"    select="concat($bibo,'pmid')"/>
<xsl:variable name="bibo:prefixName"    select="concat($bibo,'prefixName')"/>
<xsl:variable name="bibo:presentedAt"    select="concat($bibo,'presentedAt')"/>
<xsl:variable name="bibo:presents"    select="concat($bibo,'presents')"/>
<xsl:variable name="bibo:producer"    select="concat($bibo,'producer')"/>
<xsl:variable name="bibo:recipient"    select="concat($bibo,'recipient')"/>
<xsl:variable name="bibo:reproducedIn"    select="concat($bibo,'reproducedIn')"/>
<xsl:variable name="bibo:reversedBy"    select="concat($bibo,'reversedBy')"/>
<xsl:variable name="bibo:reviewOf"    select="concat($bibo,'reviewOf')"/>
<xsl:variable name="bibo:section"    select="concat($bibo,'section')"/>
<xsl:variable name="bibo:shortDescription"    select="concat($bibo,'shortDescription')"/>
<xsl:variable name="bibo:shortTitle"    select="concat($bibo,'shortTitle')"/>
<xsl:variable name="bibo:sici"    select="concat($bibo,'sici')"/>
<xsl:variable name="bibo:status"    select="concat($bibo,'status')"/>
<xsl:variable name="bibo:subsequentLegalDecision"    select="concat($bibo,'subsequentLegalDecision')"/>
<xsl:variable name="bibo:suffixName"    select="concat($bibo,'suffixName')"/>
<xsl:variable name="bibo:transcriptOf"    select="concat($bibo,'transcriptOf')"/>
<xsl:variable name="bibo:translationOf"    select="concat($bibo,'translationOf')"/>
<xsl:variable name="bibo:translator"    select="concat($bibo,'translator')"/>
<xsl:variable name="bibo:upc"    select="concat($bibo,'upc')"/>
<xsl:variable name="bibo:uri"    select="concat($bibo,'uri')"/>
<xsl:variable name="bibo:volume"    select="concat($bibo,'volume')"/>

<xsl:variable name="bibo:ALL" select="(
   $bibo:coden,
   $bibo:Article,
   $bibo:content,
   $bibo:Webpage,
   $bibo:edition,
   $bibo:doi,
   $bibo:Note,
   $bibo:DocumentStatus,
   $bibo:volume,
   $bibo:affirmedBy,
   $bibo:translationOf,
   $bibo:Collection,
   $bibo:reversedBy,
   $bibo:pages,
   $bibo:numVolumes,
   $bibo:ReferenceSource,
   $bibo:Chapter,
   $bibo:Magazine,
   $bibo:Film,
   $bibo:Manuscript,
   $bibo:PersonalCommunicationDocument,
   $bibo:issuer,
   $bibo:isbn10,
   $bibo:suffixName,
   $bibo:authorList,
   $bibo:PersonalCommunication,
   $bibo:LegalDecision,
   $bibo:isbn13,
   $bibo:subsequentLegalDecision,
   $bibo:reproducedIn,
   $bibo:annotates,
   $bibo:shortDescription,
   $bibo:organizer,
   $bibo:AudioVisualDocument,
   $bibo:Bill,
   $bibo:presents,
   $bibo:editor,
   $bibo:Performance,
   $bibo:Code,
   $bibo:gtin14,
   $bibo:Website,
   $bibo:Excerpt,
   $bibo:translator,
   $bibo:cites,
   $bibo:presentedAt,
   $bibo:director,
   $bibo:Thesis,
   $bibo:number,
   $bibo:lccn,
   $bibo:handle,
   $bibo:AcademicArticle,
   $bibo:chapter,
   $bibo:Workshop,
   $bibo:LegalCaseDocument,
   $bibo:AudioDocument,
   $bibo:upc,
   $bibo:locator,
   $bibo:pageEnd,
   $bibo:interviewee,
   $bibo:contributorList,
   $bibo:Patent,
   $bibo:Issue,
   $bibo:Legislation,
   $bibo:Journal,
   $bibo:Standard,
   $bibo:uri,
   $bibo:Letter,
   $bibo:pageStart,
   $bibo:BookSection,
   $bibo:Series,
   $bibo:CourtReporter,
   $bibo:interviewer,
   $bibo:Image,
   $bibo:Statute,
   $bibo:numPages,
   $bibo:Interview,
   $bibo:degree,
   $bibo:Document,
   $bibo:recipient,
   $bibo:eanucc13,
   $bibo:argued,
   $bibo:producer,
   $bibo:issn,
   $bibo:performer,
   $bibo:Report,
   $bibo:prefixName,
   $bibo:asin,
   $bibo:isbn,
   $bibo:citedBy,
   $bibo:Map,
   $bibo:Proceedings,
   $bibo:pmid,
   $bibo:eissn,
   $bibo:Brief,
   $bibo:Email,
   $bibo:Event,
   $bibo:issue,
   $bibo:section,
   $bibo:reviewOf,
   $bibo:court,
   $bibo:abstract,
   $bibo:editorList,
   $bibo:EditedBook,
   $bibo:Quote,
   $bibo:Manual,
   $bibo:oclcnum,
   $bibo:CollectedDocument,
   $bibo:Slide,
   $bibo:status,
   $bibo:sici,
   $bibo:Slideshow,
   $bibo:Newspaper,
   $bibo:Book,
   $bibo:LegalDocument,
   $bibo:Periodical,
   $bibo:Conference,
   $bibo:owner,
   $bibo:ThesisDegree,
   $bibo:DocumentPart,
   $bibo:transcriptOf,
   $bibo:MultiVolumeBook,
   $bibo:Hearing,
   $bibo:distributor,
   $bibo:identifier,
   $bibo:shortTitle
)"/>

</xsl:transform>
