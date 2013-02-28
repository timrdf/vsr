<xsl:transform version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:xfm="transform namespace"

   exclude-result-prefixes="xs xfm xd">

<xsl:import href="string-variables.xsl"/>

<xd:doc type="stylesheet">
   <xd:short>Functions to produce Rich Text Format.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- replaced by xfm:rtf
xsl:variable name="rtf-header">
<xsl:text>{\rtf1\mac\ansicpg10000\cocoartf824\cocoasubrtf420
{\fonttbl\f0\fswiss\fcharset77 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\qc\pardirnatural

\f0\fs24 \cf0 </xsl:text>
</xsl:variable>

<xsl:variable name="rtf-header-gray">
<xsl:text>{\rtf1\mac\ansicpg10000\cocoartf824\cocoasubrtf420
{\fonttbl\f0\fswiss\fcharset77 Helvetica;}
{\colortbl;\red255\green255\blue255;\red179\green179\blue179;}
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\qc\pardirnatural

\f0\fs24 \cf2 </xsl:text>
</xsl:variable-->

<xd:doc>
   <xd:short>RTF of a textual string.</xd:short>
   <xd:detail>
   </xd:detail>
   <xd:param name="message"></xd:param>
</xd:doc>
<xsl:function name="xfm:rtf">
   <xsl:param name="message"/>
   <xsl:value-of select="xfm:rtf($message,'0 0 0')"/>
</xsl:function>

<xd:doc>
   <xd:short>RTF of a textual string.</xd:short>
   <xd:detail>
   </xd:detail>
   <xd:param name="message">The textual string.</xd:param>
   <xd:param name="rgb">The font color to render <tt>message</tt>.</xd:param>
</xd:doc>
<xsl:function name="xfm:rtf">
   <xsl:param name="message"/>
   <xsl:param name="rgb"/> <!-- 0,1 -->

   <xsl:variable name="estring" select="replace(replace(replace($message,'\{','\\{'),
                                                                '\}','\\}'),
                                                                  $NL,concat('\\',$NL))"/>

   <xsl:variable name="r" select="if (count(tokenize($rgb,'\s')) = 3) then tokenize($rgb,'\s')[1] else '0'"/>
   <xsl:variable name="g" select="if (count(tokenize($rgb,'\s')) = 3) then tokenize($rgb,'\s')[2] else '0'"/>
   <xsl:variable name="b" select="if (count(tokenize($rgb,'\s')) = 3) then tokenize($rgb,'\s')[3] else '0'"/>

   <xsl:variable name="R" select="round(number($r) * 255)"/>
   <xsl:variable name="G" select="round(number($g) * 255)"/>
   <xsl:variable name="B" select="round(number($b) * 255)"/>

   <!-- debug xsl:message select="concat('r ',tokenize($rgb,'\s')[1],' - ',$R,', ',
                               'g ',tokenize($rgb,'\s')[2],' - ',$G,', ',
                               'b ',tokenize($rgb,'\s')[3],' - ',$B)"/-->
 
  <!-- doesn't work, \mac? xsl:value-of select="concat(
                               '\rtf1\mac\ansicpg10000\cocoartf824\cocoasubrtf420',$NL,
                               '{\fonttbl\f0\fswiss\fcharset77 Helvetica;}',$NL,
                               '{\colortbl;\red255\green255\blue255;\red',  $R,
                                                                   '\green',$G,
                                                                   '\blue', $B,';}',$NL,
                               '\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\qc\pardirnatural',$NL,
                               $NL,$NL,
                               '\f0\fs24 \cf2 ',$message,'}')"/-->
   <!--xsl:message select="concat('xfm:rft(',$message,')')"/-->
   <xsl:value-of select="concat('{\rtf1\ansi\ansicpg1252\cocoartf949\cocoasubrtf430',
'{\fonttbl\f0\fnil\fcharset0 LucidaGrande;}',
'{\colortbl;\red255\green255\blue255;\red',  $R,
                                   '\green',$G,
                                   '\blue', $B,';}',
'\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\qc\pardirnatural',

'\f0\fs22 \cf2 ',$estring,'}')"/>
</xsl:function>

<!-- use xfm:rtf
xsl:template name="rtf-string">
   <xsl:param name="message" required="yes"/>
   <!- todo. finish. not used yet->
   <xsl:param name="r">255</xsl:param>
   <xsl:param name="g">255</xsl:param>
   <xsl:param name="b">255</xsl:param>
  <!-xsl:value-of select="concat(
                               '\rtf1\mac\ansicpg10000\cocoartf824\cocoasubrtf420',$NL,
                               '{\fonttbl\f0\fswiss\fcharset77 Helvetica;}',$NL,
                               '{\colortbl;\red255\green255\blue255;}',$NL,
                               '\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\qc\pardirnatural',$NL,
                               $NL,$NL
                               '\f0\fs24 \cf0 ',$message,'}')"/->
</xsl:template-->

<xd:doc>
   <xd:short>Strip RTF to get the textual message.</xd:short>
   <xd:detail>
   </xd:detail>
   <xd:param name="rtf">An Rich Text Formatted string from which to extract the string message.</xd:param>
</xd:doc>
<xsl:function name="xfm:rtf2txt">
   <xsl:param name="rtf"/>
   <xsl:value-of select="replace(replace(replace($rtf,'^.* ','','s'),'.$',''),$NL,'')"/>
</xsl:function>

</xsl:transform>
