#!/bin/bash
#
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/tree/master/src/vsr-semantic-graphic-search>;
#3>    prov:wasDerivedFrom   <https://github.com/timrdf/csv2rdf4lod-automation/blob/master/bin/cr-publish-droid-to-endpoint.sh>;
#3>    rdfs:seeAlso <https://github.com/timrdf/csv2rdf4lod-automation/blob/master/bin/cr-cron.sh>;
#3>    rdfs:seeAlso <https://github.com/timrdf/csv2rdf4lod-automation/wiki/Aggregating-subsets-of-converted-datasets> .
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

see="https://github.com/timrdf/csv2rdf4lod-automation/wiki/Aggregating-subsets-of-converted-datasets"
CSV2RDF4LOD_PUBLISH_OUR_SOURCE_ID=${CSV2RDF4LOD_PUBLISH_OUR_SOURCE_ID:?"not set; see $see"}

# cr:data-root cr:source cr:directory-of-datasets cr:dataset cr:directory-of-versions cr:conversion-cockpit
ACCEPTABLE_PWDs="cr:data-root"
if [ `${CSV2RDF4LOD_HOME}/bin/util/is-pwd-a.sh $ACCEPTABLE_PWDs` != "yes" ]; then
   ${CSV2RDF4LOD_HOME}/bin/util/pwd-not-a.sh $ACCEPTABLE_PWDs
   exit 1
fi

TEMP="_"`basename $0``date +%s`_$$.tmp

sourceID=$CSV2RDF4LOD_PUBLISH_OUR_SOURCE_ID
datasetID=`basename $0 | sed 's/.sh$//'`
versionID=`date +%Y-%b-%d`

graphName=${CSV2RDF4LOD_BASE_URI_OVERRIDE:-$CSV2RDF4LOD_BASE_URI}/source/$sourceID/dataset/$datasetID/version/$versionID

if [[ $# -lt 1 || "$1" == "--help" ]]; then
   echo "usage: `basename $0` [--target] [-n] --clear-graph <named_graph_URI | cr:auto | .>"
   echo ""
   echo "  Find all metadata Turtle files in any conversion cockpit, "
   echo "    archive them into a new versioned dataset, and "
   echo "      load it into a virtuoso sparql endpoint."
   echo ""
   echo "         --target : return the name of graph that will be loaded; then quit."
   echo "               -n : perform dry run only; do not load named graph."
   echo "    --clear-graph : clear the named graph."
   echo
   echo "  named_graph_URI : use graph name given"
   echo "          cr:auto : use named graph $graphName"
   echo "                . : print to stdout"
   exit 1
fi

if [ "$1" == "--target" ]; then
   # a conversion:VersionedDataset:
   # e.g. http://purl.org/twc/health/source/tw-rpi-edu/dataset/cr-publish-tic-to-endpoint/version/2012-Sep-07
   echo $graphName
   exit 0
fi

dryRun="false"
if [ "$1" == "-n" ]; then
   dryRun="true"
   dryrun.sh $dryrun beginning
   shift 
fi

clearGraph="false"
if [ "$1" == "--clear-graph" ]; then
   clearGraph="true"
   shift
fi

#if [ $# -lt 1 ]; then
#   $0 --help
#fi

if [ "$1" != "cr:auto" ]; then
   graphName="$1"
   shift 
fi

cockpit="$sourceID/$datasetID/version/$versionID"
if [ ! -d $cockpit/source ]; then
   mkdir -p $cockpit/source
   mkdir -p $cockpit/automatic
fi
#rm -rf $cockpit/source/*

property_path="sio:has-member dcterms:subject skos:broader skos:broader skos:broader"
pushd $cockpit &> /dev/null

   rq="graphic-urls.rq"
   cp $me.rq automatic/$rq

   echo $me.rq against endpoint: $CSV2RDF4LOD_PUBLISH_SPARQL_ENDPOINT 
   if [[ "$CSV2RDF4LOD_PUBLISH_SPARQL_ENDPOINT" =~ http && ! -e source/$rq.xml ]]; then
      rm -f $rq
      ln automatic/$rq $rq # Work around cache-queries.sh assumptions.
      cache-queries.sh $CSV2RDF4LOD_PUBLISH_SPARQL_ENDPOINT -o xml -q `basename $rq` -od source
      rm -f $rq
   fi

   if [[ -e source/$rq.xml ]]; then
      pushd source &> /dev/null
         for url in `saxon.sh $me.xsl a a $rq.xml`; do
            if [[ "$url" =~ http* ]]; then

               download=${url%%_||_*}
               page=${url##*_||_}
               if [[ "$url" == "$page" ]]; then
                  page=''
               else
                  echo $download also $page
               fi
               hash=`md5.sh -qs $download`
               echo $download > $hash.access

               # Retrieve the graphic.
               if [ ! -e $hash.graphic ]; then
                  pcurl.sh "$download" -n $hash -e graphic
               fi

               # Content-augment the graphics.
               if [[ ! -e $hash.graphic.ttl ]]; then
                  depicts.sh -w $hash.graphic --start-to --follow $property_path
               fi
               if [[   -e $hash.graphic.ttl ]]; then
                  pushd ../ &> /dev/null
                     #graph_name=`cat source/$hash.access` # OLD WAY FOR VAST 2013 paper.
                     graph_name="`cr-dataset-uri.sh --uri`/$hash"
                     pvdelete.sh $graph_name
                     # TODO: needs new modeling (should pvload do it?) echo "<$graph_name> a vsr:Dataset ." >> source/$hash.graphic.ttl

                     # OLD: echo vload ttl $hash.graphic.ttl $graph_name -v
                     file_path=`cr-ln-to-www-root.sh source/$hash.graphic.ttl`
                     url=`cr-ln-to-www-root.sh --url-of-filepath $file_path`
                     pvload.sh $url -ng $graph_name

                     if [[ -n "$page" ]]; then
                        # TODO: needs new modeling (should pvload do it?) echo "<$page> a vsr:Dataset ." >> $hash.graphic.ttl
                        echo vload ttl $hash.graphic.ttl $page -v
                     fi
                  popd &> /dev/null
               fi
            fi
         done
      popd &> /dev/null
   fi

popd &> /dev/null

dryrun.sh $dryrun ending
