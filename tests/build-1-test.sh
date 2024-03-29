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
   tmpDir="$(mktemp -d)"
   zooKeeperTmpDir="${tmpDir}/zookeeper"

   # see tests/functions.sh
   buildZooKeeper "${zooKeeperTmpDir}" 3.4.5 1

   rm -rf "${tmpDir}"
}

