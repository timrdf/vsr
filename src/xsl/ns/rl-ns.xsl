<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:p="http://purl.org/twc/vocab/vsr/">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<xsl:variable name="rl" select="'http://purl.org/twc/vocab/vsr#'"/>

<!-- Types -->
<xsl:variable name="rlFilter"                                     select="concat($rl,'Filter')"/>
<xsl:variable name="rlAction"                                     select="concat($rl,'Action')"/>

<!-- Filter instances -->
<xsl:variable name="rlDefault_statement_handler"                  select="concat($rl,'Default_statement_handler')"/>
<xsl:variable name="rlOnPropertyRelaxer"                          select="concat($rl,'OnPropertyRelaxer')"/>

<!-- Actions -->
<xsl:variable name="rlConnect_to_elements"                        select="concat($rl,'Connect_to_elements')"/>
<xsl:variable name="rlDefer_to_default_processing"                select="concat($rl,'Defer_to_default_processing')"/>
<xsl:variable name="rlDraw_statement_literally"                   select="concat($rl,'Draw_statement_literally')"/>
<xsl:variable name="rlPrevent_default_processing"                 select="concat($rl,'Prevent_default_processing')"/>
<xsl:variable name="rlTemporaily_Defer_to_default_processing"     select="concat($rl,'Temporaily_Deferring_to_default_processing')"/>
<xsl:variable name="rlNot_draw_edge"                              select="concat($rl,'Not_draw_edge')"/>
<xsl:variable name="rlDeferred"                                   select="concat($rl,'Deferred')"/>

<!-- Justifications -->
<xsl:variable name="rlDebugging"                                  select="concat($rl,'Debugging')"/>
<xsl:variable name="rlA_Filter_deferred"                          select="concat($rl,'A_Filter_deferred')"/>
<xsl:variable name="rlEncodedWithVisualProperties"                select="concat($rl,'EncodedWithVisualProperties')"/>
<xsl:variable name="rlDerivableFromVisualWithRDFS_Semantics"      select="concat($rl,'DerivableFromVisualWithRDFS_Semantics')"/>
<xsl:variable name="rlDerivableFromVisualWithOWL_Semantics"       select="concat($rl,'DerivableFromVisualWithOWL_Semantics')"/>
<xsl:variable name="rlTypeWasNotFoundUnacceptable"                select="concat($rl,'TypeWasNotFoundUnacceptable')"/>

<xsl:variable name="pns" select="'http://purl.org/twc/vocab/vsr#'"/>

<xsl:variable name="ps" select="concat($pns,'s')"/>
<xsl:variable name="pp" select="concat($pns,'p')"/>
<xsl:variable name="po" select="concat($pns,'o')"/>

<!--xsl:variable name="pns:connected_to" select="concat($pns,'connected_to')"/-->

<xsl:variable name="dns"    select="'http://purl.org/twc/vocab/vsr#'"/>

</xsl:transform>
