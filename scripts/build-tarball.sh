#!/bin/sh

WORKING_DIR=${1}
REVISION=${2}


svn export -r ${REVISION} ${WORKING_DIR} groupserver-release-${REVISION}
ls ${WORKING_DIR}/src | xargs -i -n1 svn export --force ${WORKING_DIR}/src/{} release/src/{}
tar cvfz groupserver-release-${REVISION}.tar.gz groupserver-release-${REVISION}
