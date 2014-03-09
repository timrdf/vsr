#!/bin/bash
#
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/blob/master/bin/vsr-follow.sh>;
#3>    prov:wasDerivedFrom   <https://github.com/timrdf/vsr/tree/master/bin/vsr2grf.sh>,
#3>                          <https://github.com/timrdf/vsr/tree/master/src/depicts.sh>;
#3>                          <http://richard.cyganiak.de/blog/2008/03/what-is-your-rdf-browsers-accept-header/> .
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
   echo "usage: `basename $0` [-w] [-od <directory>] <seed-file> [--no-sameness] [--start-to] [--instances-of <rdfs-class>+]  [--follow <rdf-property>+]"
   echo
   echo "                           -w : write the output to file."
   echo "              -od <directory> : write the outputs into the given directory."
   echo "                  <seed-file> : the RDF file to start augmentation. Can be an RDF file, or a GRDDL-annotated XML file."
   echo "                --no-sameness : do not follow owl:sameAs, prov:specialization, or prov:alternateOf on followed objects."
   echo "                   --start-to : clear the visit list before beginning augmentation. Will re-visit everything at least once."
   echo " --instances-of <rdfs-class>+ : dereference instances of these classes."
   echo " --follow <rdf-property>+     : after dereferencing the depictions, also resolve all objects of the given RDF property."
   echo
   exit
fi

# This is what rapper requests (see http://richard.cyganiak.de/blog/2008/03/what-is-your-rdf-browsers-accept-header/)
accept='application/rdf+xml, text/rdf;q=0.6, text/plain;q=0.1, text/turtle, application/x-turtle, application/turtle, text/n3;q=0.3, text/rdf+n3;q=0.3, application/rdf+n3;q=0.3, application/x-trig, application/rss;q=0.8, application/rss+xml;q=0.8, text/rss;q=0.8, application/xml;q=0.3, text/xml;q=0.3, application/atom+xml;q=0.3, text/html;q=0.2, application/xhtml+xml;q=0.4, text/html;q=0.6, application/xhtml+xml;q=0.8, text/x-nquads, */*;q=0.1'
timeout='--max-time 60'

TEMP="_"`basename $0``date +%s`_$$.tmp

follow_count=0

function dereference {
   local uri="$1"
   local outfile="$2"
   local visited="$3"
   let "follow_count=$follow_count+1"

   fragment=${uri#*#}
   uri=${uri%#*}
   if [[ "$fragment" == "$uri" ]]; then
      fragment=""
   else
      fragment="(for #$fragment)"
   fi
   if [[ `grep "^$uri$" $visited` ]]; then
      echo "          `void-triples.sh $outfile | sed 's/./ /g'` | $uri $fragment ($follow_count)" >&2
   else
      local ERROR=''
      #rapper -q -g -o ntriples $uri >> $outfile
      curl $timeout -sH "Accept: $accept" -L "$uri" > $TEMP
      local status=$?
      if [[ $status = '6' ]]; then
         ERROR=" (curl ERROR 6 Couldn't resolve host.) " # The given remote host was not resolved."
      elif [[ $status = '7' ]]; then
         ERROR=" (curl ERROR 7 Failed to connect to host. "
      elif [[ $status = '28' ]]; then
         ERROR=" (curl ERROR 28 Operation timeout.) "    # The specified time-out period was reached according to the conditions."
      elif [[ $status = '56' ]]; then
         ERROR=" (curl ERROR 56 Failure in receiving network data.) "
      elif [[ $status -ne 0 ]]; then
         ERROR=" (curl ERROR $status) "
      else
         ERROR=' '
      fi

      if [[ `valid-rdf.sh $TEMP` == 'yes' ]]; then
         rdf2nt.sh $TEMP >> $outfile
      else
         if [[ "${#ERROR}" -eq 0 ]]; then
            ERROR=" (ERROR invalid RDF response) "
         fi
      fi
      echo "          `void-triples.sh $outfile` <$ERROR$uri $fragment ($follow_count)" >&2

      echo $uri >> $visited
   fi
}

# [-w]
overwrite="no"
if [ "$1" == "-w" ]; then
overwrite="yes"
shift
fi

if [ $# -lt 1 ]; then
   $0 --help
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

# --no-sameness
sames="`prefix.cc owl:sameAs` `prefix.cc prov:alternateOf`"
fill_sameness="true"
if [ "$1" == "--no-sameness" ]; then
   fill_sameness="false" 
   shift
fi

# [--start-to]
visited=".`basename $0`-visit-list"
if [ "$1" == "--start-to" ]; then
   rm -f $visited 
   touch $visited
   shift
fi

# [--instances-of <rdfs-class>+]
instances_of=''
totalC=0
if [ "$1" == "--instances-of" ]; then
   shift
   while [[ $# -gt 0 && "$1" != '--follow' ]]; do
      class="$1"
      shift
      instances_of="$instances_of `prefix.cc $class`"
      let "totalC=totalC+1"
   done
fi

# [--follow <rdf-predicate>+]
follows=''
total=0
if [ "$1" == "--follow" ]; then
   shift
   while [[ $# -gt 0 && "$1" != '--follow' ]]; do
      property="$1"
      shift
      follows="$follows `prefix.cc $class`"
      let "total=total+1"
   done
fi

if [[ -z "$instances_of" && -z "$follows" ]]; then
   $0 --help
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
   # The file isn't RDF, so GRDDL it.
   cr-default-prefixes.sh --turtle > $outfile
   grddl.sh $artifact >> $outfile
   echo "`void-triples.sh $outfile` < $artifact" >&2
   for depicted in `o-of-p.sh 'vsr:depicts' $outfile`; do
      dereference "$depicted" "$outfile" "$visited"
   done
else
   # Skip past GRDDL if the file is already RDF.
   rdf2nt.sh $artifact > $outfile
fi

followed=0
for follow in "bootstrap $follows"; do

   filledC=0
   for class in "$instances_of" ; do
      let "filledC=filledC+1"
      echo "filling $class (class $filledC / $totalC) from subjects in $outfile"
      for instance in `o-of-p.sh --instances-of \`prefix.cc $class\` $outfile`; do
         dereference "$instance" "$outfile" "$visited"
      done
   done

   if [[ ! "$follow" =~ bootstrap* ]]; then
      let "followed=followed+1"

      echo "following $follow (property $followed / $total) from subjects in $outfile"
      for object in `o-of-p.sh $follow $outfile | sort -u`; do
         dereference "$object" "$outfile" "$visited"
      done

      if [[ "$fill_sameness" == "true" ]]; then
         for sameas in $sames; do
            echo "   filling \"sameness\" relation $sameas for objects of $follow ($followed / $total)"
            for object in `o-of-p.sh --inverse-of $sameas $outfile | sort -u`; do
               dereference "$object" "$outfile" "$visited"
            done
         done
      fi
   fi
done

rapper -q -g -o turtle $outfile > $intermediate_file
mv $intermediate_file $outfile
void-triples.sh $outfile >&2
rm -f $TEMP
