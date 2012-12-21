#!/bin/sh
#
#3> [] a prov:Activity;
#3>    prov:used      <xsltdoc-config.xml>;
#3>    prov:generated <xsltdoc/index.html>,
#3>                   <xsltdoc-out.xml>;
#3>    prov:wasAttributedTo [ prov:hadPlan <> ];
#3> .

java -jar ../lib/saxonb9-1-0-8j.jar xsltdoc-config.xml ../lib/XSLTdoc_1.2.2/xsl/xsltdoc.xsl > xsltdoc-out.xml
echo xsltdoc/index.html
