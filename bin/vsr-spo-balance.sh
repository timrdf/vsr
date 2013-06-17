#!/bin/bash
#
#3> <> prov:specializationOf <https://github.com/timrdf/vsr/blob/master/bin/vsr-spo-balance.sh> .

VSR_HOME=$(cd ${0%/*} && echo ${PWD%/*})
me=$(cd ${0%/*} && echo ${PWD})/`basename $0`

export CLASSPATH=''
export CLASSPATH=$CLASSPATH`$VSR_HOME/src/vsr-situate-classpaths.sh`

java edu.rpi.tw.visualization.overview.summarizer.RepositorySummarizer $*
