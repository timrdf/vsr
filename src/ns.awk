#3> <> prov:specializationOf <https://github.com/timrdf/vsr/blob/master/src/ns.sh>;
#3>    prov:generated <https://github.com/timrdf/vsr/blob/master/src/xsl/ns/prov-ns.xsl>,
#3>                   <https://github.com/timrdf/vsr/blob/master/src/xsl/ns/sio-ns.xsl>,
#3>                   <https://github.com/timrdf/vsr/blob/master/src/xsl/ns/void-ns.xsl>,
#3>                   <https://github.com/timrdf/vsr/blob/master/src/xsl/ns/dcterms-ns.xsl>;
#3> .
#
# Usage:
#
#    awk -v prefix=$prefix -v namespace=$namespace
#
#    awk -v prefix=$prefix
#       (if no namespace is given, just use local name)
#
# (three more full examples at bottom)

BEGIN {
   print "<xsl:transform version=\"2.0\""
   print "   xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\""
   print "   xmlns:xd=\"http://www.pnp-software.com/XSLTdoc\""
   if( length(namespace) ) {
      print "   xmlns:"prefix"=\""namespace"\">"
   }else {
      print "   xmlns:"prefix"=\""prefix"\">" # It's not ideal, but it's the best that we can do without knowing a namespace.
   }
   print ""
   print "<xd:doc type=\"stylesheet\">"
   print "   <xd:short>Vocabulary terms.</xd:short>"
   print "   <xd:detail></xd:detail>"
   print "   <xd:author>Timothy Lebo</xd:author>"
   print "   <xd:copyright></xd:copyright>"
   print "   <xd:svnId></xd:svnId>"
   print "</xd:doc>"
   print ""
   if( length(namespace) ) {
      print "<!-- The namespace itself -->"
      print "<xsl:variable name=\""prefix"\"                select=\"'"namespace"'\"/>"
      print ""
   }
   print "<!-- Terms within the namespace -->"
}
{
   term = $1
   if( length(namespace) ) {
      gsub(namespace,"",term)
   }else {
      gsub(/^.*\./,"",term)
      gsub(/^.*\//,"",term)
      gsub(/^.*#/,"",term)
   }
   if( length(term) ) {
      terms[term]=term
      print "<xsl:variable name=\""prefix":"term"\"    select=\"concat($"prefix",'"term"')\"/>"
      ts++
   }
}
END {
   print ""
   print "<xsl:variable name=\""prefix":ALL\" select=\"("
   for (term in terms) {
      if ( t<ts-1 ) {
         comma=","
      }else {
         comma=""
      }
      t++
      print "   $"prefix":"term""comma
   } 
   print ")\"/>"
   print ""
   print "</xsl:transform>"
}

# bash-3.2$ echo TERM | awk -f ns.awk -v prefix=MY_PRE -v namespace=MY_NS
#
# <xsl:transform version="2.0"
#    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
#    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
#    xmlns:MY_PRE="MY_NS">
# 
# <xd:doc type="stylesheet">
#    <xd:short>Vocabulary terms.</xd:short>
#    <xd:detail></xd:detail>
#    <xd:author>Timothy Lebo</xd:author>
#    <xd:copyright></xd:copyright>
#    <xd:svnId></xd:svnId>
# </xd:doc>
# 
# <!-- The namespace itself -->
# <xsl:variable name="MY_PRE"                select="'MY_NS'"/>
# 
# <!-- Terms within the namespace -->
# <xsl:variable name="MY_PRE:TERM"    select="concat($MY_PRE,'TERM')"/>
# 
# <xsl:variable name="MY_PRE:ALL" select="(
#    $MY_PRE:TERM
# )"/>
# 
# </xsl:transform>


# bash-3.2$ echo label | awk -f ns.awk -v prefix=rdfs -v namespace=http://www.w3.org/2000/01/rdf-schema#
#
# <xsl:transform version="2.0"
#    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
#    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
#    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#">
# 
# <xd:doc type="stylesheet">
#    <xd:short>Vocabulary terms.</xd:short>
#    <xd:detail></xd:detail>
#    <xd:author>Timothy Lebo</xd:author>
#    <xd:copyright></xd:copyright>
#    <xd:svnId></xd:svnId>
# </xd:doc>
# 
# <!-- The namespace itself -->
# <xsl:variable name="rdfs"                select="'http://www.w3.org/2000/01/rdf-schema#'"/>
# 
# <!-- Terms within the namespace -->
# <xsl:variable name="rdfs:label"    select="concat($rdfs,'label')"/>
# 
# <xsl:variable name="rdfs:ALL" select="(
#    $rdfs:label
# )"/>
# 
# </xsl:transform>


# bash-3.2$ echo http://xmlns.com/foaf/0.1/OnlineAccount | awk -f ns.awk -v prefix=foaf
#
# <xsl:transform version="2.0"
#    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
#    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
#    xmlns:foaf="foaf">
# 
# <xd:doc type="stylesheet">
#    <xd:short>Vocabulary terms.</xd:short>
#    <xd:detail></xd:detail>
#    <xd:author>Timothy Lebo</xd:author>
#    <xd:copyright></xd:copyright>
#    <xd:svnId></xd:svnId>
# </xd:doc>
# 
# <!-- Terms within the namespace -->
# <xsl:variable name="foaf:OnlineAccount"    select="concat($foaf,'OnlineAccount')"/>
# 
# <xsl:variable name="foaf:ALL" select="(
#    $foaf:OnlineAccount
# )"/>
# 
# </xsl:transform>
