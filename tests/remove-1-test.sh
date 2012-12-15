#!/usr/bin/env roundup
#
# This file contains the test plan for the `remove` command.
#    
#/ usage:  rerun stubbs:test -m zookeeper -p remove [--answers <>]
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "remove"


it_succeeds_with_defaults() {
   echo will not execute: rerun zookeeper:remove
}
