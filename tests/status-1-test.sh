#!/usr/bin/env roundup
#
# This file contains the test plan for the `status` command.
#    
#/ usage:  rerun stubbs:test -m zookeeper -p status [--answers <>]
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "status"



it_succeeeds_with_defaults() {
   tmpDir="$(mktemp -d)"
   zooKeeperTmpDir="${tmpDir}/zookeeper"

   # see tests/functions.sh
   buildZooKeeper "${zooKeeperTmpDir}" 3.4.5 1

   rerun rpm: upgrade --package-file "${zooKeeperTmpDir}/RPMS/noarch/zookeeper-3.4.5-1.noarch.rpm"

   rerun zookeeper:start
   rerun zookeeper:status
   rerun zookeeper:stop
   rerun zookeeper:status || true

   rm -rf "${tmpDir}"
}

