#!/usr/bin/env roundup
#
# This file contains the test plan for the `cleanup` command.
#    
#/ usage:  rerun stubbs:test -m zookeeper -p cleanup [--answers <>]
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "cleanup"


it_succeeds_with_defaults() {
   echo will not execute: rerun zookeeper:cleanup
}
