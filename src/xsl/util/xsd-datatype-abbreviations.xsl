<!--
-->
<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:xsdabv="https://github.com/timrdf/vsr/tree/master/src/xsl/util/xsd-datatype-abbreviations.xsl">

<xd:doc type="stylesheet">
   <xd:short>Some string abbreviations for XSD and OWL restrictions.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!--
   xs:boolean,''    -> {T,F} or {true, false}
   xs:boolean,true  -> {T,F} or {true, false}
   xs:boolean,false -> {T,F} or {true, false}
   xs:string,''     -> abc
 -->
<xsl:function name="xsdabv:type-char">
   <xsl:param name="type"/>
   <xsl:param name="default"/>
   <xsl:message select="concat('IN ',$type,' ',$default)"/>

   <xsl:variable name="abbrev-boolean" select="false()"/>
   <xsl:variable name="true"  select="if ($abbrev-boolean) then 'T' else 'true'"/>
   <xsl:variable name="false" select="if ($abbrev-boolean) then 'F' else ' false'"/>
   
   <xsl:variable name="char">
   <xsl:choose>
      <xsl:when test="not($type)">
      </xsl:when>
      <xsl:when test="$type = 'xs:string'">
         <xsl:value-of select="concat('  ',$DQ,'abc',$DQ)"/>
      </xsl:when>
      <xsl:when test="$type = 'xs:boolean'">
         <xsl:choose>
            <xsl:when test="$default = 'true'">
               <xsl:value-of select="concat('  \{\b ',$true,'\b0,',$false,'\}')"/>
            </xsl:when>
            <xsl:when test="$default = 'false'">
               <xsl:value-of select="concat('  \{',$true,',\b ',$false,'\b0\}')"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="concat('  \{',$true,',',$false,'\}')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:when>
      <xsl:when test="$type = 'xs:nonNegativeInteger'">
         <xsl:value-of select="'{0,1,...}'"/>
      </xsl:when>
      <xsl:when test="$type = 'xs:double'">
         <xsl:value-of select="'{1.001}'"/>
      </xsl:when>
      <xsl:when test="$type = 'xs:decimal'">
         <xsl:value-of select="'{1.001}'"/>
      </xsl:when>
      <xsl:when test="$type = ('xs:integer','xs:int')">
         <xsl:value-of select="'  {...,-1,0,-1,...}'"/>
      </xsl:when>
      <xsl:when test="$type = 'xs:date'">
         <xsl:value-of select="'  {13aug2009}'"/>
      </xsl:when>
      <xsl:when test="$type = 'xs:time'">
         <xsl:value-of select="'  {23:59}'"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:message select="concat('ERROR: could not type: ',$type)"/>
         <xsl:value-of select="substring-after($type,'http://www.w3.org/2001/XMLSchema')"/>
      </xsl:otherwise>
   </xsl:choose>
   </xsl:variable>
   <xsl:if test="$type">
      <xsl:message select="concat($in,'datatype: ',$char)"/>
      <xsl:value-of select="$char"/>
   </xsl:if>
</xsl:function>

<xsl:function name="xsdabv:regex-char">
   <xsl:param name="minOccurs"/>
   <xsl:param name="maxOccurs"/>
   <xsl:message select="concat('IN2 ',$minOccurs,' ',$maxOccurs)"/>
   
   <!-- default value for maxOccurs and minOccurs is 1 -->

   <xsl:variable name="char">
   <xsl:choose>
      <xsl:when test="$minOccurs = 'unbounded'">
         <xsl:value-of select="'TODO'"/>
      </xsl:when>
      <xsl:when test="xs:integer($minOccurs) = 0">
         <xsl:choose>
            <xsl:when test="$maxOccurs = 'unbounded'">
               <xsl:value-of select="'*'"/>
            </xsl:when>
            <xsl:when test="xs:integer($maxOccurs) = 0">
               <xsl:value-of select="'NONSENSICAL-CARDINALITY'"/>
            </xsl:when>
            <xsl:when test="xs:integer($maxOccurs) = 1 or not($maxOccurs)">
               <xsl:value-of select="'?'"/>
            </xsl:when>
            <xsl:when test="xs:integer($maxOccurs) gt 1">
               <xsl:value-of select="concat('[0,',$maxOccurs,']')"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="'TODO'"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:when>
      <xsl:when test="xs:integer($minOccurs) = 1 or not($minOccurs)">
         <xsl:choose>
            <xsl:when test="$maxOccurs = 'unbounded'">
               <xsl:value-of select="'+'"/>
            </xsl:when>
            <xsl:when test="xs:integer($maxOccurs) = 0">
               <xsl:value-of select="'NONSENSICAL-CARDINALITY'"/>
            </xsl:when>
            <xsl:when test="xs:integer($maxOccurs) = 1 or not($maxOccurs)">
               <xsl:value-of select="''"/>
            </xsl:when>
            <xsl:when test="xs:integer($maxOccurs) gt 1">
               <xsl:value-of select="concat('[0,',$maxOccurs,']')"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="'TODO'"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:when>
      <xsl:when test="xs:integer($minOccurs) gt 1">
         <xsl:value-of select="concat('[',$minOccurs,']')"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:message select="concat('ERROR: could not regex minOccurs,maxOccurs: ',$minOccurs,' ',$maxOccurs)"/>
         <xsl:value-of select="'TODO'"/>
      </xsl:otherwise>
   </xsl:choose>
   </xsl:variable>
   <xsl:if test="$char">
      <xsl:message select="concat($in,'card: ',$char)"/>
      <xsl:value-of select="$char"/>
   </xsl:if>
</xsl:function>

</xsl:transform>
