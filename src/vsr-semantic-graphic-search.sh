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
rm -rf $cockpit/source/*

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
pushd $cockpit &> /dev/null

   rq="graphic-urls.rq"
   cp $me.rq automatic/$rq

   echo $me.rq against endpoint: $CSV2RDF4LOD_PUBLISH_SPARQL_ENDPOINT 
   if [[ "$CSV2RDF4LOD_PUBLISH_SPARQL_ENDPOINT" =~ http ]]; then
      rm -f $rq
      ln automatic/$rq $rq # Work around cache-queries.sh assumptions.
      cache-queries.sh $CSV2RDF4LOD_PUBLISH_SPARQL_ENDPOINT -o xml -q `basename $rq` -od source
      rm -f $rq
   fi

   if [[ -e source/$rq.xml ]]; then
      for url in `saxon.sh $me.xsl a a source/$rq.xml`; do
         if [[ "$url" =~ http* ]]; then
            download=${url%%_||_*}
            page=${url##*_||_}
            if [[ "$url" == "$page" ]]; then
               page=''
            else
               echo $download also $page
            fi
            hash=`md5.sh -qs $download`
            echo $download > source/$hash.access
            pcurl.sh "$download" -n $hash -e graphic
         fi
      done
   fi

   #tally=1
   #valid=""
   #for droid in `find . -mindepth 6 -maxdepth 6 -name cr-droid.ttl`; do
   #   echo $droid
   #   loc=`dirname $droid`
   #   loc=`dirname $loc`
   #   sdv=$(cd $loc && cr-sdv.sh) # Local file name in the aggregated source/ directory.

      # Files are referenced relatively in the turtle file, so 
      # moving it will lose the file it's talking about.
      # We need to set the @base in the file's new location.
      # e.g., "<Hospital_flatfiles.zip>" 
      #   in:
      #    "<Hospital_flatfiles.zip> dcterms:format <http://provenanceweb.org/formats/pronom/x-fmt/263> ."
      #   in:
      #     /srv/twc-healthdata/data/source/hub-healthdata-gov/hospital-compare/version/2012-Oct-10
      #   is:
      #     http://healthdata.tw.rpi.edu/source/hub-healthdata-gov/file/hospital-compare/version/2012-Oct-10/source/Hospital_flatfiles.zip 
      #
      # cr-dataset-uri.sh --uri | sed 's/\/dataset\//\/file\//' | awk '{print $0"/source/"}'
      # gives
      #     http://purl.org/twc/health/source/hub-healthdata-gov/file/hospital-compare/version/2012-Oct-10/source/
   #   url=$(cd $loc && cr-dataset-uri.sh --uri)
   #   base=`echo $url | sed 's/\/dataset\//\/file\//' | awk '{print "@base <"$0"/source/> ."}'`

      #ext=${droid%*.}
      #let "tally=tally+1
   #   echo "   --> $sdv.ttl"
   #   if [ "$dryRun" != "true" ]; then
   #      echo $base  > $cockpit/source/$sdv.ttl
   #      echo       >> $cockpit/source/$sdv.ttl
   #      cat $droid >> $cockpit/source/$sdv.ttl
   #   fi
   #   #count=`void-triples.sh $cockpit/automatic/$tally$ext.ttl`
   #   #if [ "$count" -gt 0 ]; then
   #   #   valid="$valid $tic"
   ##   #fi
   #done
popd &> /dev/null
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

#pushd $cockpit &> /dev/null
#   echo
#   echo aggregate-source-rdf.sh --link-as-latest source/* 
#   if [ "$dryRun" != "true" ]; then
#      aggregate-source-rdf.sh --link-as-latest source/* 
#      # WARNING: ^^ publishes even with -n b/c it checks for CSV2RDF4LOD_PUBLISH_VIRTUOSO
#   fi
#popd &> /dev/null
#
#if [ "$clearGraph" == "true" ]; then
#   echo
#   echo "Deleting $graphName" >&2
#   if [ "$dryRun" != "true" ]; then
#      publish/bin/virtuoso-delete-$sourceID-$datasetID-$versionID.sh
#   fi
#fi

#if [ "$dryRun" != "true" ]; then
#   pushd $cockpit &> /dev/null
#      publish/bin/virtuoso-load-$sourceID-$datasetID-$versionID.sh
#   popd &> /dev/null
#fi

# if [ "$CSV2RDF4LOD_PUBLISH_COMPRESS" == "true" ]; then
# fi

dryrun.sh $dryrun ending
