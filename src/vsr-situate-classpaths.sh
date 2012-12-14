#!/bin/bash
#
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/blob/master/bin/vsr-situate-classpath.sh>;
#3>    rdfs:seeAlso <https://github.com/timrdf/csv2rdf4lod-automation/wiki/situate-shell-paths-pattern> .

VSR_HOME=$(cd ${0%/*} && echo ${PWD%/*})

missing=''
for jar in \
   $VSR_HOME/lib/csv2rdf4lod.jar
do
   if [[ $CLASSPATH != *`basename $jar`* ]]; then
      echo "`basename $jar` not in classpath; adding $CSV2RDF4LOD_HOME/$jar" >&2
      missing=$missing:$jar
   fi
done
echo $missing
