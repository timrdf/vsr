#!/bin/bash

VSR_HOME=$(cd ${0%/*} && echo ${PWD%/*})

if [[ $# -lt 1 || "$1" == "--help" ]]; then
   echo "usage: `basename $0` <vocab-prefix>+"
   echo "   vocab-prefix : e.g. 'prov', 'dcterms'"
   exit
fi

TEMP="_"`basename $0``date +%s`_$$.tmp

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

   xsl="$VSR_HOME/src/xsl/ns/$prefix-ns.xsl"

   tdb="$VSR_HOME/src/xsl/ns/tdb"
   rq="$VSR_HOME/src/ns.rq"
   xslSR="$VSR_HOME/src/ns.xsl"
   awk="$VSR_HOME/src/ns.awk"

   if [ ! -e $xsl ]; then
      rdf="$VSR_HOME/src/xsl/ns/$prefix-ns.rdf"
      sxr="$VSR_HOME/src/xsl/ns/$prefix-ns.sxr"

      namespace=`curl -Ls http://prefix.cc/$prefix.file.txt | awk '{print $2}'`
      echo "$prefix $namespace"

      if [ -z "$loc" ]; then
         loc="$namespace"
      fi

      echo "   $rdf < $loc"
      rapper -q -g -o rdfxml $loc > $rdf
      if [ ! -e $tdb ]; then
         mkdir -p $tdb
      fi

      echo "   $tdb"
      tdbloader --quiet --loc=$tdb $rdf

      cp $rq $TEMP
      perl -pi -e "s|http://www.w3.org/ns/prov#|$namespace|" $TEMP 
      tdbquery --quiet --loc=$tdb --query=$TEMP --results XML > $sxr
      saxon.sh $xslSR a a $sxr | awk -f $awk -v prefix=$prefix -v namespace=$namespace > $xsl
   fi
   loc=""
   namespace=""
done

rm -f $TEMP
