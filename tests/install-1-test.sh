#!/usr/bin/env roundup
#
# This file contains the test plan for the `install` command.
#    
#/ usage:  rerun stubbs:test -m zookeeper -p install [--answers <>]
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "install"


it_fails_without_a_real_test() {

   tmpDir="$(mktemp -d)"
   zooKeeperTmpDir="${tmpDir}/zookeeper"

   # see tests/functions.sh
   buildZooKeeper "${zooKeeperTmpDir}" 3.4.5 1

   rerun rpm: upgrade --package-file "${zooKeeperTmpDir}/RPMS/noarch/zookeeper-3.4.5-1.noarch.rpm"

   rm -rf "${tmpDir}"
}
