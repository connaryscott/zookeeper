#!/usr/bin/env roundup
#
# This file contains the test plan for the `erase` command.
#    
#/ usage:  rerun stubbs:test -m zookeeper -p erase [--answers <>]
#

# Helpers
#
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------

describe "erase"


it_succeeds_with_defaults() {
   echo will not execute: rerun zookeeper:erase
}

