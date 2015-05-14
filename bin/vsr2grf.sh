#!/bin/bash
#
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/tree/master/bin/vsr2grf.sh> .
#
# usage:
#
#   $path_to/in2out.sh file1.in > file1.out
#       output is sent to stdout
#
#   $path_to/in2out.sh -w file1.in; ls = file1.out 
#       same effect as $path_to/in2out.sh file1.in > file1.out: OVERWRITES
#
#   $path_to/in2out.sh -od newdir file1.in > file1.out 
#       -od has no effect with single file (use in2out.sh file1.in > newdir/file1.out instead)
#
#   $path_to/in2out.sh -w -od newdir file1.in > file1.out 
#       -w and -od have no effect with single file
#
#   $path_to/in2out.sh file1.in file999.in; ls = file1.out file999.out  
#       an out file is created 'next to' each given file (in the same directory as input file)
#
#   $path_to/in2out.sh -od newdir file1.in file999.in
#       if 'newdir' exists and output file does NOT exist, write output file into 'newdir'
#       if 'newdir' exists and output file DOES exist, print warning and do not write file
#       if 'newdir' does not exist, creates 'newdir' and write output file into 'newdir'
#
#   $path_to/in2out.sh -w -od newdir file1.in file999.in
#       if 'newdir' exists, write output file into 'newdir' (OVERWRITES even if it exists)
#       if 'newdir' does not exist, creates 'newdir' and write output file into 'newdir'
#
# file renaming:
#   file1.arb.in  ($input_extension = 'in') ($output_extension = 'out') ($replace_extension = 'true')  -> file1.arb.out
#   file1.arb.in  ($input_extension = 'in') ($output_extension = 'out') ($replace_extension != 'true') -> file1.arb.in.out
#   file1.arb.txt ($input_extension = 'in') ($output_extension = 'out')                                -> file1.arb.txt.out
#
# Author: Timothy Lebo

# {edu.rpi.tw.string.pmm.DefaultPrefixMappings}canAbbreviate()

VSR_HOME=$(cd ${0%/*} && echo ${PWD%/*})
me=$(cd ${0%/*} && echo ${PWD})/`basename $0`

export CLASSPATH=$CLASSPATH`$VSR_HOME/bin/vsr-situate-classpaths.sh`
#export CLASSPATH=$CLASSPATH`$CSV2RDF4LOD_HOME/bin/util/cr-situate-classpaths.sh`

opt=${VSR_HOME%/*}
if [[ -d $opt/csv2rdf4lod-automation ]]; then
   export CSV2RDF4LOD_HOME=$opt/csv2rdf4lod-automation
else
   see='https://github.com/timrdf/vsr/wiki/Installing-VSR'
   export CSV2RDF4LOD_HOME=${CSV2RDF4LOD_HOME:?"not set; source csv2rdf4lod/source-me.sh or see $see"}
fi

input_extension="rdf"
output_extension="<graffle,graphml>"
replace_extension="false"
debug="false"

usage_message="usage: `basename $0` {pml, owl, rdf, rdf-literal, path/to/some.vsr} {graffle, graphml} [-w] [-od path/to/dir] some.$input_extension+" 

# TODO: moved into --count to avoid infinite loop on no args - need to recover this capability that was done for VAST 2013.

if [[ "$1" == "--count" ]]; then
   # Note, this regex needs to match the annotation shown below at GRAPHIC_TIC.
   # e.g.
   #3> <> a prov:Bundle; foaf:primaryTopic <vis> . <vis> a vsr:Graphic .
   count=`grep "^#3> <> a prov:Bundle.* a vsr:Graphic" \`find . -name "*.prov.ttl"\` | awk '{print $6}' | sort -u | wc -l`
   let "next=count+1"

   echo $count
   exit
elif [[ "$1" == "--next-id" ]]; then
   echo $next
   exit
fi




if [[ $# -lt 3 || "$1" == "--help" ]]; then
   echo $usage_message 
   exit
fi

################################# owl, rdf, rdf-literal, or full path to vsr.


vsr="$1"                                   
if [[ $vsr == "rdf-literal" || "$vsr" == "uri-list" ]]; then
   # A uri-list is just a one-URI-per-line file; we'll convert it to a turtle.
   vis_strat_full="$VSR_HOME/src/xsl/from/rdf2.xsl"
   vis_strat=`basename $vis_strat_full`
elif [ $vsr == "rdf" ]; then
   vis_strat_full="$VSR_HOME/src/xsl/from/rdf-abbrev.xsl"
   vis_strat=`basename $vis_strat_full`
elif [ $vsr == "owl" ]; then
   vis_strat_full="$VSR_HOME/src/xsl/from/owl2.xsl"
   vis_strat=`basename $vis_strat_full`
elif [ $vsr == "pml" ]; then
   vis_strat_full="$VSR_HOME/src/xsl/from/pml.vsr.xsl"
   vis_strat=`basename $vis_strat_full`
else
   echo "[INFO] Search for visual strategy by keyword failed, attempting as file path..." >&2

   # Check if absolute.
   vis_strat=`basename $1`
   vis_strat_full="$1"                 # Try it as absolute path
   checkAbs=`echo $1 | sed 's/^\/.*$/__/g'`
   if [ $checkAbs != $vis_strat_full ]; then
      echo "[INFO]    Visual strategy is an absoluate file path." >&2
      vis_strat_full="$1"
   else
      echo "[INFO]    Visual strategy is a relative file path." >&2

      # https://github.com/timrdf/vsr/issues/10
      if [[ ${VSR_PATH/$VSR_HOME/} == "$VSR_PATH" ]]; then
         VSR_PATH="$VSR_PATH:$VSR_HOME/src/xsl/from/"
         echo "[INFO]       Added VSR_HOME to VSR_PATH: $VSR_PATH" >&2
      fi

      vis_strat_full=''
      if [[ -e "`pwd`/$1" ]]; then
         vis_strat_full="`pwd`/$1"        # Try it as relative path
      else
         for try_path in `echo $VSR_PATH | sed 's/:/ /g'`; do
            VSR_EXT='.vsr.xsl'
            if [[ -e "$try_path/$1" && -z "$vis_strat_full" ]]; then
               vis_strat_full="$try_path/$1"           # Try it as relative path
               echo "[INFO]       Visual strategy found at $vis_strat_full" >&2
            elif [[ -e "$try_path/${1}$VSR_EXT" && -z "$vis_strat_full" ]]; then
               vis_strat_full="$try_path/${1}$VSR_EXT" # Try it as relative path, with extension
               echo "[INFO]       Visual strategy found at $vis_strat_full" >&2
            else
               echo "[INFO]       Visual strategy not found in $try_path ..." >&2
            fi
         done
      fi
   fi 
fi
# TODO: just let them give the base, fill in the file pattern.
# TODO: search through all directories soft-linked in.
shift

################################# graffle, graphml
graphical_format=$1 # Could be 'graffle', or an absolute path '/Users/lebot/.../from/template.vsr.xsl'
if [[ -e "$graphical_format" ]]; then
   output_extension=`basename $graphical_format` 
   output_extension=${output_extension%.vsr.xsl}
else
   output_extension=$graphical_format
fi
shift

overwrite="no"
if [ $1 = "-w" ]; then
  overwrite="yes"
  shift
fi

if [ $# -lt 1 ]; then
   echo $usage_message 
   exit 1
fi
output_dir="."
output_dir_set="false"
if [ $1 = "-od" ]; then
   output_dir_set="true"
   output_dir="$2"
	if [ ! -d $output_dir ]; then
	  mkdir $output_dir
	fi
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

#CLASSPATH=${CLASSPATH}:${CLUSTERMAP_LIB}/commons-cli-1.1.jar
#CLASSPATH=${CLASSPATH}:${CLUSTERMAP_LIB}/commons-codec-1.3.jar
#CLASSPATH=${CLASSPATH}:${CLUSTERMAP_LIB}/commons-dbcp-1.2.2.jar
#CLASSPATH=${CLASSPATH}:${CLUSTERMAP_LIB}/commons-httpclient-3.1.jar
#CLASSPATH=${CLASSPATH}:${CLUSTERMAP_LIB}/commons-logging-1.1.jar
#CLASSPATH=${CLASSPATH}:${CLUSTERMAP_LIB}/commons-pool-1.3.jar

# Determine the absolute path to this script.
D=`dirname "$0"`
script_home="`cd \"$D\" 2>/dev/null && pwd || echo \"$D\"`"

intermediate_file="_`basename $0`_pid$$.date`date +%s`.tmp"

# TODO: https://github.com/timrdf/vsr/issues/10

XSL=$intermediate_file.${vis_strat}2`basename ${graphical_format}`_$$.xsl
echo '<xsl:transform version="2.0"'                                               > $XSL
echo '   xmlns:xsl="http://www.w3.org/1999/XSL/Transform">'                      >> $XSL
echo "   <xsl:include href=\"$vis_strat_full\"/>"                                >> $XSL
if [   "$graphical_format" == "graffle" ]; then
   echo "   <xsl:include href=\"$VSR_HOME/src/xsl/to/2graffle5.xsl\"/>"          >> $XSL
elif [ "$graphical_format" == "graphml" ]; then
   echo "   <xsl:include href=\"$VSR_HOME/src/xsl/to/2graphml.xsl\"/>"           >> $XSL
else
   echo "   <xsl:include href=\"$VSR_HOME/src/xsl/to/2$graphical_format.xsl\"/>" >> $XSL
fi
echo '</xsl:transform>'                                                          >> $XSL

if [[ "$debug" == "true" ]]; then
   echo "-----------------"
   echo "input_extension   = $input_extension"
   echo "output_extension  = $output_extension"
   echo "intermediate_file = $intermediate_file"
   echo "-----------------"
   echo "replace_extension = $replace_extension"
   echo "overwrite         = $overwrite"
   echo "output_dir_set    = $output_dir_set"
   echo "output_dir        = $output_dir"
   echo "multiple_files    = $multiple_files"
   echo "-----------------"
   echo "script_home       = $script_home"
   echo "vsr               = $vsr"
   echo "vis_strat         = $vis_strat"
   echo "vis_strat_full    = $vis_strat_full"
   echo "----------------------------------"
   exit 1
fi


while [ $# -gt 0 ]; do
	artifact="$1"

   # Determine full path of output file (stored in var 'outfile')
	if [ 1 -a `echo $artifact | sed 's/^.*\.\(.*\)$/\1/' | grep $input_extension | wc -l` -gt 0 -a $replace_extension = "yes" ]; then
      # If the extension is the expected $input_extension and extention should be replaced
		base=`basename $artifact | sed 's/^\(.*\)\..*$/\1/'` # Strip all after last period.
	else
		# The extension was not $input_extension OR extention should be appended (i.e. not replaced)
		base=`basename $artifact`
	fi
	if [[ "$output_dir_set" == "false" && -e "$artifact" ]]; then
		# If output directory not provided, write to file at same location as artifact.
		output_dir=`dirname $artifact` 
	fi
	outfile=$output_dir/$base.$output_extension
	errorfile=$output_dir/$base.$output_extension.out
	provenancefile=$output_dir/$base.$output_extension.prov.ttl

   rdf="_"`basename $0``date +%s`_$$.tmp
   # TODO: Determine base URI of local file RDF from $artifact.pml.ttl or $artifact.prov.ttl
   if [[ ! -e "$artifact" && "$artifact" =~ http.* ]]; then
      $CSV2RDF4LOD_HOME/bin/util/rdf2nt.sh $artifact | rapper -q -i ntriples -o rdfxml -I       $artifact - > $rdf
   else
      if [[ "$vsr" == 'uri-list' ]]; then
         cat "$artifact" | sed 's/^ *<//;s/> *$//g' | awk 'BEGIN{print "@prefix owl: <http://www.w3.org/2002/07/owl#> ."}\
                        {print "<"$1"> a owl:Thing ."}' | rapper -q -i turtle   -o rdfxml -I `pwd`/$artifact - > $rdf
      else
         $CSV2RDF4LOD_HOME/bin/util/rdf2nt.sh $artifact | rapper -q -i ntriples -o rdfxml -I `pwd`/$artifact - > $rdf
      fi
   fi

   graphicURI=""
   situated=""
   params=""
   if [[ `which cr-dataset-uri.sh` && `cr-dataset-uri.sh --uri` == http* ]]; then
      situated="yes"
      # visual-artifact-uri
      # [-v a=1 b=2 ... -in]
      #graphicURI="`cr-dataset-uri.sh --uri`/visualization/$next"
      graphicURI="`cr-dataset-uri.sh --uri`/visualization/`date +%Y/%m/%d/T/%H/%M/%S`"
      params="visual-artifact-uri=$graphicURI"
      # ^^ e.g. http://ieeevis.tw.rpi.edu/source/datahub.io/dataset/vis-seven-scenarios-codings/version/2013-Mar-08
   fi
   if [[ "$VSR_PROVENANCE" == "true" ]]; then
      params="$params log-visual-decisions=true"
      params="$params log-serverURL=."
   fi
   if [[ -n "$params" ]]; then
      params="-v $params -in"
      echo "[INFO] Saxon parameters: $params" >&2
   fi

   # Convert file at 'artifact' into file 'outfile', depending on how many files are being processed.
	if [ $multiple_files = "true" ]; then
		if [ ! -e $outfile -o $overwrite = "yes" ]; then
         # EXECUTE CONVERSION ($artifact to $outfile via $intermediate_file)
         echo "Transforming $base to $outfile"
         $CSV2RDF4LOD_HOME/bin/dup/saxon.sh $XSL $input_extension $output_extension $params $rdf > $outfile 2> $errorfile
         perl -pi -e 's/SLF4J:.*//' $errorfile
         #if [[ -e "$errorfile" && "$VSR_PROVENANCE" == "true" ]]; then
            # NOTE: duplicated below.
            #$CSV2RDF4LOD_HOME/bin/util/grep-tail.sh -p "# Begin provenance dump." $errorfile | grep -v "^Begin provenance dump" > $provenancefile
            #if [[ `$CSV2RDF4LOD_HOME/bin/util/valid-rdf.sh $provenancefile` == "yes" && `which rapper` ]]; then
            #   tmp="_"`basename $0``date +%s`_$$.tmp
            #   rapper -q -i turtle -o turtle $provenancefile -I `cr-dataset-uri.sh --uri` > $tmp
            #   mv $tmp $provenancefile
            #fi
            #tmp="_"`basename $0``date +%s`_$$.tmp
            #$CSV2RDF4LOD_HOME/bin/util/grep-head.sh -p "# Begin provenance dump." $errorfile | grep -v "^# Begin provenance dump" > $tmp
            #mv $tmp $errorfile
         #fi
      else 
         echo "$base    WARNING: $outfile already exists. Did not overwrite." $overwrite
		fi
	else
		# Only one file was given
		if [ $overwrite = "yes" ]; then
         # EXECUTE CONVERSION ($artifact to $outfile via $intermediate_file)
         echo "[INFO] Transforming $base to $outfile"
         echo "[INFO] with $XSL"
         echo $CSV2RDF4LOD_HOME/bin/dup/saxon.sh $XSL $input_extension $output_extension $params $rdf $outfile $errorfile
         $CSV2RDF4LOD_HOME/bin/dup/saxon.sh $XSL $input_extension $output_extension $params $rdf > $outfile 2> $errorfile
         perl -pi -e 's/SLF4J:.*//' $errorfile
         if [[ -e "$errorfile" && "$VSR_PROVENANCE" == "true" ]]; then
            # NOTE: duplicated above.
            $CSV2RDF4LOD_HOME/bin/util/cr-default-prefixes.sh --turtle                                                                          > $provenancefile 
            $CSV2RDF4LOD_HOME/bin/util/grep-tail.sh -p "# Begin provenance dump." $errorfile | \
               perl -pe "s|^# Begin provenance dump.*$|#3> <> a prov:Bundle; foaf:primaryTopic <$graphicURI> . <$graphicURI> a vsr:Graphic .|" >> $provenancefile
            #                                          GRAPHIC_TIC
            nfoFocus=`$CSV2RDF4LOD_HOME/bin/util/nfo-filehash.sh --foci $outfile`
            echo "$nfoFocus a vsr:Graphic ."                                                                                                   >> $provenancefile
            echo "<`cr-dataset-uri.sh --uri`> dcterms:subject <$graphicURI> ."                                                                 >> $provenancefile
            echo "<$graphicURI> prov:alternateOf $nfoFocus ."                                                                                  >> $provenancefile
            $CSV2RDF4LOD_HOME/bin/util/nfo-filehash.sh $outfile                                                                                >> $provenancefile

            #if [[ `$CSV2RDF4LOD_HOME/bin/util/valid-rdf.sh $provenancefile` == "yes" && `which rapper` ]]; then
            #   tmp="_"`basename $0``date +%s`_$$.tmp
            #   rapper -q -i turtle -o turtle $provenancefile -I `cr-dataset-uri.sh --uri` > $tmp
            #   cp $tmp $provenancefile
            #fi
            tmp="_"`basename $0``date +%s`_$$.tmp
            $CSV2RDF4LOD_HOME/bin/util/grep-head.sh -p "# Begin provenance dump." $errorfile | grep -v "^# Begin provenance dump" > $tmp
            mv $tmp $errorfile
         fi
		else
         # EXECUTE CONVERSION ($artifact to stdout via $intermediate_file)
         #for path in `echo $CLASSPATH | sed 's/:/ /g'`; do 
         #   echo $path
         #   tar -tf $path | grep NameFactory
         #done 
         $CSV2RDF4LOD_HOME/bin/dup/saxon.sh $XSL $input_extension $output_extension $params $rdf 
         # Convert the file, but print to stdout (and NOT a file, since we shouldn't overwrite it)
	  fi
	fi

  shift
done

if [ -e "$intermediate_file" ]; then
   rm $intermediate_file 
fi
if [ -e "$XSL" ]; then
   rm $XSL
fi
if [ -e "$rdf" ]; then
   rm $rdf
fi
