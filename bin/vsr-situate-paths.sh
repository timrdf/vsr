#!/bin/bash
#
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/blob/master/bin/vsr-sitaute-paths.sh>;
#3>    prov:wasDerivedFrom   <https://github.com/timrdf/prizms/blob/master/bin/install/paths.sh> .
#
# Usage:
#
#   export PATH=$PATH`$DATAFAQS_HOME/src/vsr-situate-paths.sh`
#   (can be repeated indefinitely, once paths are in PATH, nothing is returned.)

VSR_HOME=$(cd ${0%/*} && echo ${PWD%/*})
me=$(cd ${0%/*} && echo ${PWD})/`basename $0`


if [ "$1" == "--help" ]; then
   echo "`basename $0` [--help]"
   echo
   echo "Return the shell paths needed for Prizms scripts to run."
   echo "Set them by executing:"
   echo
   echo "    export PATH=\$PATH\`$me\`" # DO NOT echo anything after this.
   exit
fi

missing=""
HOME=$(cd ${0%/*} && echo ${PWD})
opt="${HOME%/*/*}"
if [[ -e $opt/csv2rdf4lod-automation/bin/util/cr-situate-paths.sh ]]; then
   # In case VSR's dependency is installed, too.
   missing=`$opt/csv2rdf4lod-automation/bin/util/cr-situate-paths.sh`
fi

if [ ! `which depicts.sh` ]; then
   missing=$missing:$VSR_HOME/src
fi
if [ ! `which vsr2grf.sh` ]; then
   missing=$missing:$VSR_HOME/bin
fi

echo $missing
