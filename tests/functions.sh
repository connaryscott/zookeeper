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

#
# interface to the python-setuptools module build command
#
pythonSetupToolsBuild() {
   name=$1
   version=$2
   directory=$3

   rerun python-setuptools:build --name ${name} --version ${version} --directory ${directory} 
}

#
# produce rpms for zookeeper python api, c-bindings, and threads
#
buildZooKeeperPythonSupport() {
   directory=$1


   #
   #build the zc.zk module
   #
   mkdir -p ${directory}/zc_zk
   zc_zk=${directory}/zc_zk
   pythonSetupToolsBuild zc.zk 1.2.0 "${zc_zk}"

   #
   #static binary support is needed (we need to adjust python-setuptools to support platform dependent modules
   #since this generates x86_64 (in specific case, a 64 bit arch), e.g add --package-arch x86_64
   #
   mkdir -p ${directory}/zc_zookeeper_static
   zc_zookeeper_static=${directory}/zc_zookeeper_static
   rerun -v python-setuptools:build --version 3.4.3 --directory "${zc_zookeeper_static}" --name zc-zookeeper-static 
   pythonSetupToolsBuild zc-zookeeper-static 3.4.3 "${zc_zookeeper_static}"

   #
   #thread support is needed
   #
   mkdir -p ${directory}/zc_thread
   zc_thread=${directory}/zc_thread
   pythonSetupToolsBuild zc.thread 0.1.0 "${zc_thread}"
}

