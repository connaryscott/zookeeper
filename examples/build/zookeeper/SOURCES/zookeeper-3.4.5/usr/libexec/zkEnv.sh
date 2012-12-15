#!/bin/bash

#
# wrap the zkEnv.sh in the installed zookeeper share directory
# to ensure correct environment for service management.
#
ZOOKEEPER_HOME=/usr/share/zookeeper


if [ -f ${ZOOKEEPER_HOME}/bin/zkEnv.sh ]
then
   export ZOOCFGDIR=/etc/zookeeper
   export ZOO_LOG_DIR=/var/log/zookeeper
   export ZOOBINDIR=/usr/bin
   export ZOOPIDFILE=/var/zookeeper/zookeeper_server.pid
   source ${ZOOKEEPER_HOME}/bin/zkEnv.sh

fi
