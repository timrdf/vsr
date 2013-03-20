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

export CLASSPATH=$CLASSPATH`$VSR_HOME/src/vsr-situate-classpaths.sh`
#export CLASSPATH=$CLASSPATH`$CSV2RDF4LOD_HOME/bin/util/cr-situate-classpaths.sh`

if [[ $# -lt 1 || "$1" == "--help" ]]; then
   echo "usage: `basename $0` [-w] [-od <directory>] [--follow <rdf-property>] <graphic-file>..."
   echo
   echo "                      -w : write the output to file."
   echo "         -od <directory> : write the outputs into the given directory."
   echo " --follow <rdf-property> : after dereferencing the depictions, also resolve all objects of the given RDF property."
   echo
   exit
fi

overwrite="no"
if [ "$1" == "-w" ]; then
  overwrite="yes"
  shift
fi

if [ $# -lt 1 ]; then
   echo $usage_message 
   exit 1
fi
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

follow=""
if [ "$1" == "--follow" ]; then
  follow="$2"
  shift 2
fi

if [ $# -lt 1 ]; then
   echo $usage_message 
   exit 1
fi
multiple_files="false"
if [ $# -gt 1 ]; then
  multiple_files="true"
fi

intermediate_file="_`basename $0`_pid$$.date`date +%s`.tmp"

output_extension='ttl'

while [ $# -gt 0 ]; do
   artifact="$1"
   shift

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

   grddl.sh $artifact > $outfile
   void-triples.sh $outfile >&2
   for depicted in `rdf2nt.sh --version 2 $outfile | awk '{if($2 == "<http://purl.org/twc/vocab/vsr#depicts>"){ gsub("<",""); gsub(">",""); print $3 }}'`; do
      rapper -q -g -o turtle $depicted >> $outfile
      void-triples.sh $outfile >&2
   done
   rapper -q -g -o turtle $outfile > $intermediate_file
   mv $intermediate_file $outfile
   void-triples.sh $outfile >&2

   if [[ -n "$follow" ]]; then
      follow=`prefix.cc $follow`
      echo $follow
   fi
done
