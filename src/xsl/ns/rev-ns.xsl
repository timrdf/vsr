<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:rev="http://purl.org/stuff/rev#">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="rev"                select="'http://purl.org/stuff/rev#'"/>

<!-- Terms within the namespace -->
<xsl:variable name="rev:Comment"    select="concat($rev,'Comment')"/>
<xsl:variable name="rev:Feedback"    select="concat($rev,'Feedback')"/>
<xsl:variable name="rev:Review"    select="concat($rev,'Review')"/>
<xsl:variable name="rev:commenter"    select="concat($rev,'commenter')"/>
<xsl:variable name="rev:hasComment"    select="concat($rev,'hasComment')"/>
<xsl:variable name="rev:hasFeedback"    select="concat($rev,'hasFeedback')"/>
<xsl:variable name="rev:hasReview"    select="concat($rev,'hasReview')"/>
<xsl:variable name="rev:maxRating"    select="concat($rev,'maxRating')"/>
<xsl:variable name="rev:minRating"    select="concat($rev,'minRating')"/>
<xsl:variable name="rev:positiveVotes"    select="concat($rev,'positiveVotes')"/>
<xsl:variable name="rev:rating"    select="concat($rev,'rating')"/>
<xsl:variable name="rev:reviewer"    select="concat($rev,'reviewer')"/>
<xsl:variable name="rev:text"    select="concat($rev,'text')"/>
<xsl:variable name="rev:title"    select="concat($rev,'title')"/>
<xsl:variable name="rev:totalVotes"    select="concat($rev,'totalVotes')"/>
<xsl:variable name="rev:type"    select="concat($rev,'type')"/>

<xsl:variable name="rev:ALL" select="(
   $rev:reviewer,
   $rev:title,
   $rev:Comment,
   $rev:positiveVotes,
   $rev:Feedback,
   $rev:rating,
   $rev:hasFeedback,
   $rev:type,
   $rev:hasReview,
   $rev:hasComment,
   $rev:commenter,
   $rev:Review,
   $rev:totalVotes,
   $rev:text,
   $rev:maxRating,
   $rev:minRating
)"/>

</xsl:transform>
