<xsl:transform version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:grddl="http://www.w3.org/2003/g/data-view#"
   xmlns:xfm="transform namespace"
   exclude-result-prefixes="xs xfm xd">

<xd:doc type="stylesheet">
   <xd:short>Target Graphical System: OmniGraffle</xd:short>
   <xd:detail><p>2graffle5.xsl provides only the administrative graffle file setup content.
                 2graffle5.xsl acts as a 2y in the x2y pattern and requires an x2 mate, which
                 2graffle5.xsl yields to with an <tt>apply-templates match="*"</tt> at the appropriate
                 location. 
             </p>
             <p>It is the 2y's responsibility to template match <tt>/</tt>, setup the file,
                and yield to whatever templates exist in scope (which are provided by x2.xsl).
             </p>
             <p>x2.xsl picks up with a template match on the root element (not <tt>/</tt>, but 
                the first element in the x xml format.)
             </p>

              TODO: see how much of the admin can be cut out and keep graffle happy.
   </xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

<xsl:include href="../util/atoid.xsl"/>
<xsl:include href="graffle.xsl"/>

<xd:doc>
   <xd:short>4 or 5.</xd:short>
   <xd:detail>
   </xd:detail>
</xd:doc>
<xsl:variable name="graffle-version" select="5" as="xs:integer"/>

<xd:doc>
   <xd:short>Render the boilerplate for an OmniGrafflePro file, then defer to the x2.xsl templates.</xd:short>
   <xd:detail>The x2.xsl templates walk the domain form and call the 2y.xsl's <tt>node</tt> and <tt>edge</tt> templates.
   </xd:detail>
</xd:doc>
<xsl:template match="/">
<plist version="1.0"
       xmlns:grddl="http://www.w3.org/2003/g/data-view#"
       grddl:transformation="https://raw.github.com/timrdf/vsr/master/src/xsl/grddl/graffle.xsl">
<dict>
	<key>ActiveLayerIndex</key>
	<integer>0</integer>
	<key>ApplicationVersion</key>
	<array>
		<string>com.omnigroup.OmniGrafflePro</string>
		<string>136.7.0.98135</string>
	</array>
	<key>AutoAdjust</key>
	<true/>
	<key>BackgroundGraphic</key>
	<dict>
		<key>Bounds</key>
		<string>{{0, 0}, {576, 733}}</string>
		<key>Class</key>
		<string>SolidGraphic</string>
		<key>ID</key>
		<integer>2</integer>
		<key>Style</key>
		<dict>
			<key>shadow</key>
			<dict>
				<key>Draws</key>
				<string>NO</string>
			</dict>
			<key>stroke</key>
			<dict>
				<key>Draws</key>
				<string>NO</string>
			</dict>
		</dict>
	</dict>
	<key>CanvasOrigin</key>
	<string>{0, 0}</string>
	<key>ColumnAlign</key>
	<integer>1</integer>
	<key>ColumnSpacing</key>
	<real>36</real>
	<key>CreationDate</key>
	<string>2008-06-25 18:23:07 -0400</string>
	<key>Creator</key>
	<string>lebot</string>
	<key>DisplayScale</key>
	<string>1 0/72 in = 1 0/72 in</string>
	<key>FileType</key>
	<string>flat</string>
	<key>GraphDocumentVersion</key>
	<integer>6</integer>
	<key>GraphicsList</key>
	<array>
      <!--xsl:apply-templates select="*" mode="edges"/-->
      <!--xsl:apply-templates select="*" mode="nodes"/-->
      <xsl:apply-templates select="*"/> <!--NOTE: This is where 2y.xsl yields to x2.xsl -->
      <!--xsl:call-template name="node">
         <xsl:with-param name="id"  select="'blah'"/>
         <xsl:with-param name="uri" select="'https://www.example.org/wiki/index.php/RDF'"/>
      </xsl:call-template-->
	</array>
	<key>GridInfo</key>
	<dict/>
	<key>GuidesLocked</key>
	<string>NO</string>
	<key>GuidesVisible</key>
	<string>YES</string>
	<key>HPages</key>
	<integer>1</integer>
	<key>ImageCounter</key>
	<integer>1</integer>
	<key>KeepToScale</key>
	<false/>
	<key>Layers</key>
	<array>
		<dict>
			<key>Lock</key>
			<string>NO</string>
			<key>Name</key>
			<string>Layer 1</string>
			<key>Print</key>
			<string>YES</string>
			<key>View</key>
			<string>YES</string>
		</dict>
	</array>
	<key>LayoutInfo</key>
	<dict>
		<key>Animate</key>
		<string>NO</string>
      <key>HierarchicalOrientation</key>
      <integer>0</integer>
		<key>circoMinDist</key>
		<real>18</real>
		<key>circoSeparation</key>
		<real>0.0</real>
		<key>layoutEngine</key>
		<string>dot</string>
		<key>neatoSeparation</key>
		<real>0.0</real>
		<key>twopiSeparation</key>
		<real>0.0</real>
	</dict>
	<key>LinksVisible</key>
	<string>NO</string>
	<key>MagnetsVisible</key>
	<string>NO</string>
	<key>MasterSheets</key>
	<array/>
	<key>ModificationDate</key>
	<string>2008-06-25 18:23:17 -0400</string>
	<key>Modifier</key>
	<string>lebot</string>
	<key>NotesVisible</key>
	<string>NO</string>
	<key>Orientation</key>
	<integer>2</integer>
	<key>OriginVisible</key>
	<string>NO</string>
	<key>PageBreaks</key>
	<string>NO</string>
	<key>PrintInfo</key>
	<dict>
		<key>NSBottomMargin</key>
		<array>
			<string>coded</string>
			<string>BAtzdHJlYW10eXBlZIHoA4QBQISEhAhOU051bWJlcgCEhAdOU1ZhbHVlAISECE5TT2JqZWN0AIWEASqEhAFklymG</string>
		</array>
		<key>NSLeftMargin</key>
		<array>
			<string>coded</string>
			<string>BAtzdHJlYW10eXBlZIHoA4QBQISEhAhOU051bWJlcgCEhAdOU1ZhbHVlAISECE5TT2JqZWN0AIWEASqEhAFklxKG</string>
		</array>
		<key>NSPaperSize</key>
		<array>
			<string>size</string>
			<string>{612, 792}</string>
		</array>
		<key>NSRightMargin</key>
		<array>
			<string>coded</string>
			<string>BAtzdHJlYW10eXBlZIHoA4QBQISEhAhOU051bWJlcgCEhAdOU1ZhbHVlAISECE5TT2JqZWN0AIWEASqEhAFklxKG</string>
		</array>
		<key>NSTopMargin</key>
		<array>
			<string>coded</string>
			<string>BAtzdHJlYW10eXBlZIHoA4QBQISEhAhOU051bWJlcgCEhAdOU1ZhbHVlAISECE5TT2JqZWN0AIWEASqEhAFklxKG</string>
		</array>
	</dict>
	<key>PrintOnePage</key>
	<false/>
	<key>ReadOnly</key>
	<string>NO</string>
	<key>RowAlign</key>
	<integer>1</integer>
	<key>RowSpacing</key>
	<real>36</real>
	<key>SheetTitle</key>
	<string>Canvas 1</string>
	<key>SmartAlignmentGuidesActive</key>
	<string>YES</string>
	<key>SmartDistanceGuidesActive</key>
	<string>YES</string>
	<key>UniqueID</key>
	<integer>1</integer>
	<key>UseEntirePage</key>
	<false/>
   <key>UserInfo</key>
   <dict>
      <key>kMDItemAuthors</key>
      <array>
         <string>2graffle5.xsl</string>
      </array>
   </dict>
	<key>VPages</key>
	<integer>1</integer>
	<key>WindowInfo</key>
	<dict>
		<key>CurrentSheet</key>
		<integer>0</integer>
		<key>ExpandedCanvases</key>
		<array>
			<dict>
				<key>name</key>
				<string>Canvas 1</string>
			</dict>
		</array>
		<key>Frame</key>
		<string>{{385, 59}, {710, 819}}</string>
		<key>ListView</key>
		<true/>
		<key>OutlineWidth</key>
		<integer>142</integer>
		<key>RightSidebar</key>
		<false/>
		<key>ShowRuler</key>
		<false/>
		<key>Sidebar</key>
		<true/>
		<key>SidebarWidth</key>
		<integer>120</integer>
		<key>VisibleRegion</key>
		<string>{{0, 0}, {561, 650}}</string>
		<key>Zoom</key>
		<real>1</real>
		<key>ZoomValues</key>
		<array>
			<array>
				<string>Canvas 1</string>
				<real>1</real>
				<real>1</real>
			</array>
		</array>
	</dict>
	<key>saveQuickLookFiles</key>
	<string>NO</string>
</dict>
</plist>
</xsl:template>

</xsl:transform>
