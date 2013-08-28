#!/bin/bash
#
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/tree/master/src/depicts.sh>;
#3>    prov:wasDerivedFrom   <https://github.com/timrdf/vsr/tree/master/src/vsr2grf.sh> .
#
# usage:
#

VSR_HOME=$(cd ${0%/*} && echo ${PWD%/*})
me=$(cd ${0%/*} && echo ${PWD})/`basename $0`

see='https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD-not-set'
CSV2RDF4LOD_HOME=${CSV2RDF4LOD_HOME:?"not set; source csv2rdf4lod/source-me.sh or see $see"}

export CLASSPATH=$CLASSPATH`$VSR_HOME/bin/vsr-situate-classpaths.sh`
#export CLASSPATH=$CLASSPATH`$CSV2RDF4LOD_HOME/bin/util/cr-situate-classpaths.sh`

if [[ $# -lt 1 || "$1" == "--help" ]]; then
   echo "usage: `basename $0` [-w] [-od <directory>] <graphic-file> [--start-to] [--follow <rdf-property>+]"
   echo
   echo "                      -w : write the output to file."
   echo "         -od <directory> : write the outputs into the given directory."
   echo "          <graphic-file> : GRDDL-annotated XML file."
   echo "              --start-to : clear the visit list."
   echo " --follow <rdf-property> : after dereferencing the depictions, also resolve all objects of the given RDF property."
   echo
   exit
fi

# [-w]
overwrite="no"
if [ "$1" == "-w" ]; then
  overwrite="yes"
  shift
fi

if [ $# -lt 1 ]; then
   echo $usage_message 
   exit 1
fi

# [-od <directory>]
output_dir="."
output_dir_set="false"
if [ "$1" == "-od" ]; then
   output_dir_set="true"
   output_dir="$2"
   if [ ! -d $output_dir ]; then
     mkdir $output_dir
   fi
   shift 2
fi

# <graphic-file>
artifact="$1"
shift

# [--start-to]
visited=".`basename $0`-visit-list"
if [ "$1" == "--start-to" ]; then
  rm -f $visited 
   touch $visited
  shift
fi

# [--follow <rdf-predicate>+]
if [ "$1" == "--follow" ]; then
   shift
fi

if [ $# -lt 1 ]; then
   echo $usage_message 
   exit 1
fi
multiple_files="false"
#if [ $# -gt 1 ]; then
#  multiple_files="true"
#fi

intermediate_file="_`basename $0`_pid$$.date`date +%s`.tmp"

output_extension='ttl'

# Determine full path of output file (stored in var 'outfile')
#if [ 1 -a `echo $artifact | sed 's/^.*\.\(.*\)$/\1/' | grep $input_extension | wc -l` -gt 0 -a $replace_extension = "yes" ]; then
   # If the extension is the expected $input_extension and extention should be replaced
#   base=`basename $artifact | sed 's/^\(.*\)\..*$/\1/'` # Strip all after last period.
#else
   # The extension was not $input_extension OR extention should be appended (i.e. not replaced)
   base=`basename $artifact`
#fi
if [[ $output_dir_set == "false" && -e $artifact ]]; then
   # If output directory not provided, write to file at same location as artifact
   output_dir=`dirname $artifact`
fi
outfile=$output_dir/$base.$output_extension
errorfile=$output_dir/$base.$output_extension.out
provenancefile=$output_dir/$base.$output_extension.prov.ttl

if [[ `valid-rdf.sh $artifact` != 'yes' ]]; then
   # The file isnt' RDF, so GRDDL it.
   cr-default-prefixes.sh --turtle > $outfile
   grddl.sh $artifact >> $outfile
   echo "`void-triples.sh $outfile` < $artifact" >&2
   for depicted in `o-of-p.sh 'vsr:depicts' $outfile`; do
      rapper -q -g -o ntriples $depicted >> $outfile
      echo "`void-triples.sh $outfile` < $depicted" >&2
   done
else
   # Skip past GRDDL if the file is already RDF.
   cp $artifact $outfile
fi

sames="`prefix.cc owl:sameAs` `prefix.cc prov:alternateOf`"
followed=0
total=$#
while [ $# -gt 0 ]; do

   follow=`prefix.cc $1`
   let "followed=followed+1"
   shift

   echo "following ($followed / $total) $follow in $outfile"
   for object in `o-of-p.sh $follow $outfile | sort -u | grep 'http://ieeevis.tw.rpi.edu/'`; do
      if [[ `grep "^$object$" $visited` ]]; then
         echo "`void-triples.sh $outfile | sed 's/./ /g'` | $object" >&2
      else
         rapper -q -g -o ntriples $object >> $outfile
         echo "`void-triples.sh $outfile` < $object" >&2
         echo $object >> $visited
      fi
   done

   for sameas in $sames; do
      echo "filling ($followed / $total) $follow $sameas"
      for object in `o-of-p.sh --inverse-of $sameas $outfile | sort -u | grep 'http://ieeevis.tw.rpi.edu/'`; do
         if [[ `grep "^$object$" $visited` ]]; then
            echo "`void-triples.sh $outfile | sed 's/./ /g'` | $object" >&2
         else
            rapper -q -g -o ntriples $object >> $outfile
            echo "`void-triples.sh $outfile` < $object" >&2
            echo $object >> $visited
         fi
      done
   done
done

rapper -q -g -o turtle $outfile > $intermediate_file
mv $intermediate_file $outfile
void-triples.sh $outfile >&2
