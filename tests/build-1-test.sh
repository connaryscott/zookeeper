#!/usr/bin/env roundup
#
# This file contains the test plan for the `build` command.
#    
#/ usage:  rerun stubbs:test -m zookeeper -p build [--answers <>]
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "build"

it_fails_without_arguments() {
    rerun zookeeper:build || return 0
}

it_builds_with_a_specified_version() {
   tmpDir="$(mktemp -d)/zookeeper"
   cp -r ${RERUN_MODULES}/zookeeper/examples/build/zookeeper ${tmpDir}
   rerun  zookeeper:build --package-release 1 --package-version 3.4.5 --package-directory "${tmpDir}"
   rpm -qip "${tmpDir}/RPMS/noarch/zookeeper-3.4.5-1.noarch.rpm"
   echo remove via rm -rf "${tmpDir}"
}
