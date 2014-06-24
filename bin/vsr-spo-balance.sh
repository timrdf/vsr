#!/bin/bash
#
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/blob/master/bin/vsr-spo-balance.sh> .

VSR_HOME=$(cd ${0%/*} && echo ${PWD%/*})
me=$(cd ${0%/*} && echo ${PWD})/`basename $0`

#export CLASSPATH=''
export CLASSPATH=$CLASSPATH`$VSR_HOME/bin/vsr-situate-classpaths.sh`

if [[ `which cr-pwd-type.sh` && `cr-pwd-type.sh` == 'cr:conversion-cockpit' ]]; then
   # TODO: source source-me.sh

   baseURI="--cr-base-uri ${CSV2RDF4LOD_BASE_URI:-'http://localhost'}"
   if [[ "$1" == "--cr-base-uri" || "$1" == '--baseURI' ]]; then
      baseURI="--cr-base-uri $2"
      shift 2
   fi

   if [[ $# -eq 2 && $1 == "-f" || $1 == "-file" ]]; then
      # e.g. vsr-spo-balance.sh -f source/NOMGEO_provincias.rdf
      file="$2"

      derivedFrom=""
      if [[ -e $file.pml.ttl ]]; then
         derivedFrom=`grep "wasQuotedFrom" $file.pml.ttl | awk '{print $2}' | sed 's/<//; s/>;//; s/>//'`
         if [[ ${#derivedFrom} -gt 0 && "$derivedFrom" =~ http* ]]; then
            derivedFrom="--derivedFrom $derivedFrom"
         else
            echo "NOTE: --derivedFrom not being used because source/$file.pml.ttl did not contain prov:wasDerivedFrom an HTTP object." >&2
         fi
      else
         echo "NOTE: --derivedFrom not being used because no provenance available at source/$file.pml.ttl" >&2
      fi

      #java -xmx8000m edu.rpi.tw.visualization.overview.summarizer.RepositorySummarizer $baseURI -f $file $derivedFrom `cr-dataset-uri.sh --uri`
      java edu.rpi.tw.visualization.overview.summarizer.RepositorySummarizer $baseURI -f $file $derivedFrom `cr-dataset-uri.sh --uri`
      # vsr-spo-balance.sh --baseURI ${CSV2RDF4LOD_BASE_URI:-'http://localhost'} -f source/ieeevis-tw-rpi-edu.nt --derivedFrom http://ieeevis.tw.rpi.edu/source/ieeevis-tw-rpi-edu/file/cr-full-dump/version/latest/conversion/ieeevis-tw-rpi-edu.nt.gz `cr-dataset-uri.sh --uri`
   else
      # vsr-spo-balance.sh --baseURI ${CSV2RDF4LOD_BASE_URI:-'http://localhost'} -s http://ieeevis.tw.rpi.edu/sparql `cr-dataset-uri.sh --uri` http://ieeevis.tw.rpi.edu/source/vis-stanford-edu/dataset/revision-image-corpus/version/2013-Mar-08
      java edu.rpi.tw.visualization.overview.summarizer.RepositorySummarizer $baseURI $*
   fi

else
   java edu.rpi.tw.visualization.overview.summarizer.RepositorySummarizer $baseURI $*
fi
