#!/bin/bash
#
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/blob/master/src/vsr-situate-classpaths.sh>;
#3>    rdfs:seeAlso <https://github.com/timrdf/csv2rdf4lod-automation/wiki/situate-shell-paths-pattern> .

VSR_HOME=$(cd ${0%/*} && echo ${PWD%/*})
me=$(cd ${0%/*} && echo ${PWD})/`basename $0`

if [ "$1" == "--help" ]; then
   echo
   echo "`basename $0` [--help]"
   echo
   echo "Put the required classpaths into CLASSPATH by executing:"
   echo "    export CLASSPATH=\$CLASSPATH\`$me\`"
   echo
   exit
fi

missing=''
for jar in \
   $VSR_HOME/lib/*.jar
do
   if [[ $CLASSPATH != *`basename $jar`* ]]; then
      echo "`basename $jar` not in classpath; adding $jar" >&2
      missing=$missing:$jar
   fi
done
echo $missing
