<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:foaf="http://xmlns.com/foaf/0.1/">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="foaf"                select="'http://xmlns.com/foaf/0.1/'"/>

<!-- Terms within the namespace -->
<xsl:variable name="foaf:Agent"    select="concat($foaf,'Agent')"/>
<xsl:variable name="foaf:Document"    select="concat($foaf,'Document')"/>
<xsl:variable name="foaf:Group"    select="concat($foaf,'Group')"/>
<xsl:variable name="foaf:Image"    select="concat($foaf,'Image')"/>
<xsl:variable name="foaf:LabelProperty"    select="concat($foaf,'LabelProperty')"/>
<xsl:variable name="foaf:OnlineAccount"    select="concat($foaf,'OnlineAccount')"/>
<xsl:variable name="foaf:OnlineChatAccount"    select="concat($foaf,'OnlineChatAccount')"/>
<xsl:variable name="foaf:OnlineEcommerceAccount"    select="concat($foaf,'OnlineEcommerceAccount')"/>
<xsl:variable name="foaf:OnlineGamingAccount"    select="concat($foaf,'OnlineGamingAccount')"/>
<xsl:variable name="foaf:Organization"    select="concat($foaf,'Organization')"/>
<xsl:variable name="foaf:Person"    select="concat($foaf,'Person')"/>
<xsl:variable name="foaf:PersonalProfileDocument"    select="concat($foaf,'PersonalProfileDocument')"/>
<xsl:variable name="foaf:Project"    select="concat($foaf,'Project')"/>
<xsl:variable name="foaf:account"    select="concat($foaf,'account')"/>
<xsl:variable name="foaf:accountName"    select="concat($foaf,'accountName')"/>
<xsl:variable name="foaf:accountServiceHomepage"    select="concat($foaf,'accountServiceHomepage')"/>
<xsl:variable name="foaf:age"    select="concat($foaf,'age')"/>
<xsl:variable name="foaf:aimChatID"    select="concat($foaf,'aimChatID')"/>
<xsl:variable name="foaf:based_near"    select="concat($foaf,'based_near')"/>
<xsl:variable name="foaf:birthday"    select="concat($foaf,'birthday')"/>
<xsl:variable name="foaf:currentProject"    select="concat($foaf,'currentProject')"/>
<xsl:variable name="foaf:depiction"    select="concat($foaf,'depiction')"/>
<xsl:variable name="foaf:depicts"    select="concat($foaf,'depicts')"/>
<xsl:variable name="foaf:dnaChecksum"    select="concat($foaf,'dnaChecksum')"/>
<xsl:variable name="foaf:familyName"    select="concat($foaf,'familyName')"/>
<xsl:variable name="foaf:family_name"    select="concat($foaf,'family_name')"/>
<xsl:variable name="foaf:firstName"    select="concat($foaf,'firstName')"/>
<xsl:variable name="foaf:focus"    select="concat($foaf,'focus')"/>
<xsl:variable name="foaf:fundedBy"    select="concat($foaf,'fundedBy')"/>
<xsl:variable name="foaf:geekcode"    select="concat($foaf,'geekcode')"/>
<xsl:variable name="foaf:gender"    select="concat($foaf,'gender')"/>
<xsl:variable name="foaf:givenName"    select="concat($foaf,'givenName')"/>
<xsl:variable name="foaf:givenname"    select="concat($foaf,'givenname')"/>
<xsl:variable name="foaf:holdsAccount"    select="concat($foaf,'holdsAccount')"/>
<xsl:variable name="foaf:homepage"    select="concat($foaf,'homepage')"/>
<xsl:variable name="foaf:icqChatID"    select="concat($foaf,'icqChatID')"/>
<xsl:variable name="foaf:img"    select="concat($foaf,'img')"/>
<xsl:variable name="foaf:interest"    select="concat($foaf,'interest')"/>
<xsl:variable name="foaf:isPrimaryTopicOf"    select="concat($foaf,'isPrimaryTopicOf')"/>
<xsl:variable name="foaf:jabberID"    select="concat($foaf,'jabberID')"/>
<xsl:variable name="foaf:knows"    select="concat($foaf,'knows')"/>
<xsl:variable name="foaf:lastName"    select="concat($foaf,'lastName')"/>
<xsl:variable name="foaf:logo"    select="concat($foaf,'logo')"/>
<xsl:variable name="foaf:made"    select="concat($foaf,'made')"/>
<xsl:variable name="foaf:maker"    select="concat($foaf,'maker')"/>
<xsl:variable name="foaf:mbox"    select="concat($foaf,'mbox')"/>
<xsl:variable name="foaf:mbox_sha1sum"    select="concat($foaf,'mbox_sha1sum')"/>
<xsl:variable name="foaf:member"    select="concat($foaf,'member')"/>
<xsl:variable name="foaf:membershipClass"    select="concat($foaf,'membershipClass')"/>
<xsl:variable name="foaf:msnChatID"    select="concat($foaf,'msnChatID')"/>
<xsl:variable name="foaf:myersBriggs"    select="concat($foaf,'myersBriggs')"/>
<xsl:variable name="foaf:name"    select="concat($foaf,'name')"/>
<xsl:variable name="foaf:nick"    select="concat($foaf,'nick')"/>
<xsl:variable name="foaf:openid"    select="concat($foaf,'openid')"/>
<xsl:variable name="foaf:page"    select="concat($foaf,'page')"/>
<xsl:variable name="foaf:pastProject"    select="concat($foaf,'pastProject')"/>
<xsl:variable name="foaf:phone"    select="concat($foaf,'phone')"/>
<xsl:variable name="foaf:plan"    select="concat($foaf,'plan')"/>
<xsl:variable name="foaf:primaryTopic"    select="concat($foaf,'primaryTopic')"/>
<xsl:variable name="foaf:publications"    select="concat($foaf,'publications')"/>
<xsl:variable name="foaf:schoolHomepage"    select="concat($foaf,'schoolHomepage')"/>
<xsl:variable name="foaf:sha1"    select="concat($foaf,'sha1')"/>
<xsl:variable name="foaf:skypeID"    select="concat($foaf,'skypeID')"/>
<xsl:variable name="foaf:status"    select="concat($foaf,'status')"/>
<xsl:variable name="foaf:surname"    select="concat($foaf,'surname')"/>
<xsl:variable name="foaf:theme"    select="concat($foaf,'theme')"/>
<xsl:variable name="foaf:thumbnail"    select="concat($foaf,'thumbnail')"/>
<xsl:variable name="foaf:tipjar"    select="concat($foaf,'tipjar')"/>
<xsl:variable name="foaf:title"    select="concat($foaf,'title')"/>
<xsl:variable name="foaf:topic"    select="concat($foaf,'topic')"/>
<xsl:variable name="foaf:topic_interest"    select="concat($foaf,'topic_interest')"/>
<xsl:variable name="foaf:weblog"    select="concat($foaf,'weblog')"/>
<xsl:variable name="foaf:workInfoHomepage"    select="concat($foaf,'workInfoHomepage')"/>
<xsl:variable name="foaf:workplaceHomepage"    select="concat($foaf,'workplaceHomepage')"/>
<xsl:variable name="foaf:yahooChatID"    select="concat($foaf,'yahooChatID')"/>

<xsl:variable name="foaf:ALL" select="(
   $foaf:topic_interest,
   $foaf:tipjar,
   $foaf:jabberID,
   $foaf:interest,
   $foaf:OnlineChatAccount,
   $foaf:page,
   $foaf:logo,
   $foaf:name,
   $foaf:mbox,
   $foaf:givenname,
   $foaf:yahooChatID,
   $foaf:age,
   $foaf:Image,
   $foaf:icqChatID,
   $foaf:family_name,
   $foaf:sha1,
   $foaf:title,
   $foaf:myersBriggs,
   $foaf:geekcode,
   $foaf:workInfoHomepage,
   $foaf:openid,
   $foaf:dnaChecksum,
   $foaf:OnlineEcommerceAccount,
   $foaf:member,
   $foaf:topic,
   $foaf:homepage,
   $foaf:focus,
   $foaf:aimChatID,
   $foaf:firstName,
   $foaf:birthday,
   $foaf:Group,
   $foaf:Agent,
   $foaf:workplaceHomepage,
   $foaf:accountServiceHomepage,
   $foaf:OnlineAccount,
   $foaf:familyName,
   $foaf:isPrimaryTopicOf,
   $foaf:surname,
   $foaf:gender,
   $foaf:fundedBy,
   $foaf:account,
   $foaf:Organization,
   $foaf:membershipClass,
   $foaf:based_near,
   $foaf:accountName,
   $foaf:publications,
   $foaf:LabelProperty,
   $foaf:knows,
   $foaf:primaryTopic,
   $foaf:currentProject,
   $foaf:Project,
   $foaf:PersonalProfileDocument,
   $foaf:made,
   $foaf:img,
   $foaf:Document,
   $foaf:thumbnail,
   $foaf:maker,
   $foaf:lastName,
   $foaf:weblog,
   $foaf:theme,
   $foaf:nick,
   $foaf:mbox_sha1sum,
   $foaf:depiction,
   $foaf:Person,
   $foaf:depicts,
   $foaf:skypeID,
   $foaf:pastProject,
   $foaf:msnChatID,
   $foaf:OnlineGamingAccount,
   $foaf:status,
   $foaf:schoolHomepage,
   $foaf:givenName,
   $foaf:plan,
   $foaf:phone,
   $foaf:holdsAccount
)"/>

</xsl:transform>
