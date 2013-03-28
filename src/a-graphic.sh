#!/bin/bash
#
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/tree/master/src/a-graphic.sh>;
#3>    prov:wasDerivedFrom   <https://github.com/timrdf/vsr/tree/master/src/depicts.sh> .
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
   echo "usage: `basename $0` [-w] [-od <directory>] <graphic-file>+"
   echo
   echo "                      -w : write the output to file."
   echo "         -od <directory> : write the outputs into the given directory."
   echo "          <graphic-file> : any file."
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
errorfile=$output_dir/$base.out
provenancefile=$output_dir/$base.prov.ttl

cr-default-prefixes.sh --turtle > $intermediate_file
while [ $# -gt 0 ]; do
   if [ -e $file ]; then
      echo "<$file> a vsr:Graphic ." >> $intermediate_file
   fi
done

if [[ -e "$provenancefile" ]]; then
   cat $intermediate_file >> $provenancefile
else
   cat $intermediate_file >> $provenancefile
fi

rm -f $intermediate_file
