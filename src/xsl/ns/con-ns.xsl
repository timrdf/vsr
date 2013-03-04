<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:con="http://www.w3.org/2000/10/swap/pim/contact#">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="con"                select="'http://www.w3.org/2000/10/swap/pim/contact#'"/>

<!-- Terms within the namespace -->
<xsl:variable name="con:Address"    select="concat($con,'Address')"/>
<xsl:variable name="con:ContactLocation"    select="concat($con,'ContactLocation')"/>
<xsl:variable name="con:Female"    select="concat($con,'Female')"/>
<xsl:variable name="con:LanguageCode"    select="concat($con,'LanguageCode')"/>
<xsl:variable name="con:Male"    select="concat($con,'Male')"/>
<xsl:variable name="con:Person"    select="concat($con,'Person')"/>
<xsl:variable name="con:Phone"    select="concat($con,'Phone')"/>
<xsl:variable name="con:SocialEntity"    select="concat($con,'SocialEntity')"/>
<xsl:variable name="con:_addressProperty"    select="concat($con,'_addressProperty')"/>
<xsl:variable name="con:address"    select="concat($con,'address')"/>
<xsl:variable name="con:assistant"    select="concat($con,'assistant')"/>
<xsl:variable name="con:birthday"    select="concat($con,'birthday')"/>
<xsl:variable name="con:child"    select="concat($con,'child')"/>
<xsl:variable name="con:description"    select="concat($con,'description')"/>
<xsl:variable name="con:emergency"    select="concat($con,'emergency')"/>
<xsl:variable name="con:fax"    select="concat($con,'fax')"/>
<xsl:variable name="con:fullName"    select="concat($con,'fullName')"/>
<xsl:variable name="con:home"    select="concat($con,'home')"/>
<xsl:variable name="con:knownAs"    select="concat($con,'knownAs')"/>
<xsl:variable name="con:mobile"    select="concat($con,'mobile')"/>
<xsl:variable name="con:motherTongue"    select="concat($con,'motherTongue')"/>
<xsl:variable name="con:nearestAirport"    select="concat($con,'nearestAirport')"/>
<xsl:variable name="con:office"    select="concat($con,'office')"/>
<xsl:variable name="con:participant"    select="concat($con,'participant')"/>
<xsl:variable name="con:partner"    select="concat($con,'partner')"/>
<xsl:variable name="con:phone"    select="concat($con,'phone')"/>
<xsl:variable name="con:preferredURI"    select="concat($con,'preferredURI')"/>
<xsl:variable name="con:region"    select="concat($con,'region')"/>
<xsl:variable name="con:sortName"    select="concat($con,'sortName')"/>
<xsl:variable name="con:vacationHome"    select="concat($con,'vacationHome')"/>
<xsl:variable name="con:webPage"    select="concat($con,'webPage')"/>

<!-- TBL uses these, but they are not defined: -->
<xsl:variable name="con:givenName"    select="concat($con,'givenName')"/>
<xsl:variable name="con:familyName"    select="concat($con,'familyName')"/>

<xsl:variable name="con:ALL" select="(
   $con:vacationHome,
   $con:LanguageCode,
   $con:address,
   $con:participant,
   $con:office,
   $con:mobile,
   $con:region,
   $con:knownAs,
   $con:home,
   $con:partner,
   $con:preferredURI,
   $con:assistant,
   $con:nearestAirport,
   $con:Male,
   $con:birthday,
   $con:_addressProperty,
   $con:Phone,
   $con:Female,
   $con:fullName,
   $con:motherTongue,
   $con:Address,
   $con:webPage,
   $con:sortName,
   $con:Person,
   $con:emergency,
   $con:description,
   $con:SocialEntity,
   $con:child,
   $con:phone,
   $con:fax,
   $con:ContactLocation,

   $con:givenName,
   $con:familyName
)"/>

</xsl:transform>
