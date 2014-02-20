#!/bin/bash
#
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/blob/master/src/ns.sh>;
#3> .
#
# Usage:
#    src/ns.sh schema @ http://schema.rdfs.org/all.rdf
#       creates:                 by doing:
#                                src/xsl/ns/schema-ns.rdf < http://schema.rdfs.org/all.rdf
#                                src/xsl/ns/tdb           < src/xsl/ns/schema-ns.rdf
#                                src/ns.rq | _ns.sh1392906149_91669.rq | src/ns.xsl | src/ns.awk
#       src/xsl/ns/schema-ns.rdf
#       src/xsl/ns/schema-ns.sxr
#       src/xsl/ns/schema-ns.xsl
#
# Usage:
#    src/ns.sh aat
#       creates:
#       src/xsl/ns/aat-ns.xsl
#       src/xsl/ns/aat-ns.sxr
#       src/xsl/ns/aat-ns.rdf
#
# Usage:
#    src/ns.sh - prov | less
#       http://www.w3.org/ns/prov#Accept
#       http://www.w3.org/ns/prov#Activity
#       http://www.w3.org/ns/prov#ActivityInfluence
#       ...
#       http://www.w3.org/ns/prov#wasRevisionOf
#       http://www.w3.org/ns/prov#wasStartedBy

VSR_HOME=$(cd ${0%/*} && echo ${PWD%/*})

if [[ $# -lt 1 || "$1" == "--help" ]]; then
   echo "usage: `basename $0` [-] (<vocab-prefix> [@ <location>])+"
   echo "                          - : print terms to stdout; don't write files into src/."
   echo "               vocab-prefix : e.g. 'prov', 'dcterms'"
   echo "   [@ (or 'at') <location>] : Override the ontology location provided by prefix.cc"
   exit
fi

TEMP="_"`basename $0``date +%s`_$$

# Avoid doing anything within the VSR_HOME
LOCAL=''
if [[ "$1" == '-' ]]; then
   LOCAL=$TEMP
   shift
fi

while [ $# -gt 0 ]; do
   prefix="$1"
   if [[ "$2" == "at" || "$2" == "@" ]]; then
      if [ $# -gt 2 ]; then
         loc="$3" 
         shift
      fi
      shift
   fi
   shift

   rdf=${LOCAL:-"$VSR_HOME/src/xsl/ns/$prefix-ns"}.rdf # Vocabulary definition
   sxr=${LOCAL:-"$VSR_HOME/src/xsl/ns/$prefix-ns"}.sxr # SPARQL XML Results listing properties/classes
   xsl=${LOCAL:-"$VSR_HOME/src/xsl/ns/$prefix-ns"}.xsl # XSL for use by VSR

   if [[ -n "$LOCAL" || ! -e $xsl ]]; then
      namespace=`curl -Ls http://prefix.cc/$prefix.file.txt | awk '{print $2}'`
      echo "$prefix $namespace" >&2

      if [ -z "$loc" ]; then
         loc="$namespace"
      fi

      echo "   $rdf < $loc" >&2
      rapper -q -g -o rdfxml $loc > $rdf
      tdb="$VSR_HOME/src/xsl/ns/tdb"
      if [ ! -e $tdb ]; then
         mkdir -p $tdb
      fi

      echo "   $tdb" >&2
      tdbloader --quiet --loc=$tdb $rdf 1>&2

      cp "$VSR_HOME/src/ns.rq" $TEMP.rq
      perl -pi -e "s|http://www.w3.org/ns/prov#|$namespace|" $TEMP.rq
      tdbquery --quiet --loc=$tdb --query=$TEMP.rq --results XML > $sxr

      if [[ -z "$LOCAL" ]]; then
         saxon.sh "$VSR_HOME/src/ns.xsl" a a $sxr | awk -f "$VSR_HOME/src/ns.awk" -v prefix=$prefix -v namespace=$namespace > $xsl
         echo '- - - - -'
      else
         saxon.sh "$VSR_HOME/src/ns.xsl" a a $sxr
      fi
   fi
   if [[ -z "$LOCAL" ]]; then
      echo ${xsl#$PWD/}
      echo ${sxr#$PWD/}
      echo ${rdf#$PWD/}
   fi
   loc=""
   namespace=""
done

if [[ "$CSV2RDF4LOD_CONVERT_DEBUG_LEVEL" == "fine" ]]; then
   echo xsl   $xsl
   echo rdf   $rdf
   echo sxr   $sxr
else
   rm -f $TEMP.rq
   rm -f $LOCAL.rdf $LOCAL.sxr $LOCAL.xsl
fi
