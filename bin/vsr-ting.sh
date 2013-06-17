#!/bin/bash
#
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/tree/master/bin/ting.sh>;
#3>    prov:wasDerivedFrom   <https://github.com/timrdf/vsr/tree/master/bin/vsr-semantic-graphic-search>;
#3>    rdfs:seeAlso          <https://github.com/timrdf/vsr/wiki/TiNG-Triples-in-Named-Graph>;
#3> .
#
# Environment variables used:
#
#    CSV2RDF4LOD_HOME                  - to access the scripts.
#    CSV2RDF4LOD_BASE_URI              - 
#    CSV2RDF4LOD_BASE_URI_OVERRIDE     - can override the above.
#    CSV2RDF4LOD_PUBLISH_OUR_SOURCE_ID - to know which source-id this dataset should be placed within.
#
#    (see https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD-environment-variables)
#
# Usage:
#
# Example usage:
# 

VSR_HOME=$(cd ${0%/*} && echo ${PWD%/*})
me=$(cd ${0%/*} && echo ${PWD})/`basename $0`

see="https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD-not-set"
CSV2RDF4LOD_HOME=${CSV2RDF4LOD_HOME:?"not set; source csv2rdf4lod/source-me.sh or see $see"}

TEMP="_"`basename $0``date +%s`_$$.tmp

if [[ $# -lt 1 || "$1" == "--help" ]]; then
   echo "usage: `basename $0` [--endpoint <endpoint>] [--graph <graph>] <rdf>+"
   echo ""
   echo "   Print summary description to stdout."
   echo ""
   echo " --endpoint : The SPARQL endpoint that contained the graph whose serialization is in file <rdf>."
   echo "    --graph : The GRAPH name of the triples in <rdf>"
   echo "                If omitted, <rdf>.sd_name file naming convention can be used to indicate the GRAPH name."
   echo "                If omitted and no <rdf>.sd_name, then will use default GRAPH."
   echo "      <rdf> : One or more RDF files (any syntax) representing the triples in the named graph."
   echo "                The file extension convention <rdf>.sd_name indicates the GRAPH name."
   exit 1
fi

endpoint="$CSV2RDF4LOD_PUBLISH_VIRTUOSO_SPARQL_ENDPOINT"
if [ "$1" == "--endpoint" ]; then
   endpoint="$2" 
   shift 2
fi

default_graph_name=""
if [ "$1" == "--graph" ]; then
   default_graph_name="$2" 
   shift 2
fi

while [ $# -gt 0 ]; do
   file="$1"
   shift
   if [[ -e $file ]]; then 
      if [[ -e $file.sd_name ]]; then
         graph_name="`cat $file.sd_name`"
      fi
      if [[ -z "$graph_name" ]]; then
         graph_name="$default_graph_name"
      fi
      if [[ -n "$graph_name" ]]; then
         ng_ugly=`resource-name.sh --named-graph $endpoint $graph_name`
         ng="$endpoint/id/named-graph/`md5.sh -qs "$ng_ugly"`"

         echo "@prefix rdf:     <http://www.w3.org/1999/02/22-rdf-syntax-ns#> ."
         echo "@prefix rdfs:    <http://www.w3.org/2000/01/rdf-schema#> ."
         echo "@prefix owl:     <http://www.w3.org/2002/07/owl#> ."
         echo "@prefix dcterms: <http://purl.org/dc/terms/> ."
         echo "@prefix sd:      <http://www.w3.org/ns/sparql-service-description#> ."
         echo "@prefix prov:    <http://www.w3.org/ns/prov#> ."
         echo "@prefix vsr:     <http://purl.org/twc/vocab/vsr#> ."
         echo
         echo "<$ng>"
         echo "   a sd:NamedGraph;"
         echo "   prov:hadLocation <$endpoint>;"
         echo "   sd:name <$graph_name>;"
         echo "   owl:sameAs <$ng_ugly>;"
         echo "."
         echo

         echo
         echo "# <> a vsr:TiNG ."
         rdf2nt.sh $file > $file.nt # TODO: uuid the bnode prefix with serdi.
         let "line=1"
         lines=`wc -l $file.nt | awk '{print $1}'`
         while [[ $line -le $lines ]]; do
            triple=`sed "$line!d;q" $file.nt`
            hash=`md5.sh -qs "$triple"`
            tripleR="$CSV2RDF4LOD_BASE_URI/id/triple/$hash"
            echo
            echo "<$tripleR> a rdf:Statement;"
            echo "   dcterms:isPartOf <$ng> ."
            let "line=$line+1"
         done

         echo
         echo "# <> a vsr:ViNG . # (vsr:PiNG, vsr:CiNG) ." # vocab, predicate, class.
         for term in `p-and-c.sh $file | sort -u`; do
            echo
            echo "<$term> a vsr:Term;"
            echo "   dcterms:isPartOf <$ng> ."
         done

         echo
         echo "# <> a vsr:RiNG ."
         for uri in `uri-nodes.sh $file | sort -u`; do
            echo
            echo "<$uri> a rdfs:Resource;"
            echo "   dcterms:isPartOf <$ng> ."
         done

         rm $file.nt
      else
         echo "WARNING: using default graph (not named) for $file"
      fi
   fi
done

dryrun.sh $dryrun ending
