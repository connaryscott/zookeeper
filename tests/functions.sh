# 
# Test functions for command tests.
#

# - - -
# Your functions declared here.
# - - -



buildZooKeeper() {
   if [ $# -lt 2 ]
   then
      echo "buildZooKeeper(), requires at least two arguments"
      return 1
   fi

   directory=$1
   version=$2

   if [ $# -eq 3 ]
   then
      release=$3
   else
      release=1
   fi

   cp -r ${RERUN_MODULES}/zookeeper/examples/build/zookeeper "${directory}"
   rerun  zookeeper:build --package-release ${release} --package-version ${version} --package-directory "${directory}"
   rpm -qip "${directory}/RPMS/noarch/zookeeper-${version}-${release}.noarch.rpm"
}

