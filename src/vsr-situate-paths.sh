#!/bin/bash
#
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/blob/master/bin/vsr-sitaute-paths.sh>;
#3>    prov:wasDerivedFrom   <https://github.com/timrdf/prizms/blob/master/bin/install/paths.sh> .
#
# Usage:
#
#   export PATH=$PATH`$DATAFAQS_HOME/bin/df-situate-paths.sh`
#   (can be repeated indefinitely, once paths are in PATH, nothing is returned.)

HOME=$(cd ${0%/*/*} && echo ${PWD%/*})
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

if [ ! `which vsr2grf.sh` ]; then
   missing=":"
   missing=$missing$HOME/bin
fi
