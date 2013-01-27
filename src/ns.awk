BEGIN {
   print "<xsl:transform version=\"2.0\""
   print "   xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\""
   print "   xmlns:xd=\"http://www.pnp-software.com/XSLTdoc\""
   print "   xmlns:dc=\"http://purl.org/dc/elements/1.1/\""
   print "   xmlns:dcterms=\"http://purl.org/dc/terms/\">"
   print ""
   print "<xd:doc type=\"stylesheet\">"
   print "   <xd:short>Vocabulary terms.</xd:short>"
   print "   <xd:detail></xd:detail>"
   print "   <xd:author>Timothy Lebo</xd:author>"
   print "   <xd:copyright></xd:copyright>"
   print "   <xd:svnId></xd:svnId>"
   print "</xd:doc>"
   print ""
   print "<!-- The namespace itself -->"
   print "<xsl:variable name=\""prefix"\"                select=\"'"namespace"'\"/>"
   print ""
   print "<!-- Terms within the namespace -->"
}
{
   term = $1
   gsub(namespace,"",term)
   terms[term]=term
   print "<xsl:variable name=\""prefix":"term"\"    select=\"concat($"prefix",'"term"')\"/>"
   ts++
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
