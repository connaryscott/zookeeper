Summary: ZooKeeper 

# The package name, version and release are supplied by rpm:build using rpmbuild(8)'s "--define" option:
Name: %{name}
Version: %{version}
Release: %{release} 

# Assumes the appropriate community release has been downloaded to SOURCES from zookeeper mirror
Source0: %{name}-%{version}.tar.gz
 
License: LGPL
Group: Applications/System

BuildArch: noarch

# Specify minimum Java version required:
Requires: java

# Disables debug packages and stripping of binaries:
%global _enable_debug_package 0
%global debug_package %{nil}
%global __os_install_post %{nil}
 
# stop the build failing just becauses there are a few sample binaries in the distribution:
%define _binaries_in_noarch_packages_terminate_build   0


%description
ZooKeeper
 
%prep

%setup

%build
 
%install
# setup the target directory hierarchy:
rm -rf %{buildroot}
install -d -m 755 %{buildroot}/usr/share/zookeeper
mv * %{buildroot}/usr/share/zookeeper
mv %{buildroot}/usr/share/zookeeper/lib/*.jar %{buildroot}/usr/share/zookeeper

mkdir -p %{buildroot}/usr/bin
(cd %{buildroot}/usr/bin && ln -s ../share/zookeeper/bin/zkServer.sh)
(cd %{buildroot}/usr/bin && ln -s ../share/zookeeper/bin/zkCli.sh)
(cd %{buildroot}/usr/bin && ln -s ../share/zookeeper/bin/zkCleanup.sh)

#
# copy in libexec environment to ensure sufficient support for service management
#
mkdir -p %{buildroot}/usr/libexec
cp -r $RPM_SOURCE_DIR/%{name}-%{version}/usr/libexec/* %{buildroot}/usr/libexec

install -d -m 755 %{buildroot}/etc/zookeeper
(cd %{buildroot}/etc/zookeeper && ln -s ../../usr/share/zookeeper/conf/configuration.xsl)
(cd %{buildroot}/etc/zookeeper && ln -s ../../usr/share/zookeeper/conf/log4j.properties)
(cd %{buildroot}/etc/zookeeper && cat /usr/share/zookeeper/conf/zoo_sample.cfg |sed 's,^dataDir=.*,dataDir=/var/zookeeper,' > zoo.cfg)

mkdir -p %{buildroot}/etc/rc.d/init.d
(cd %{buildroot}/etc/rc.d/init.d && cp  ../../../usr/share/zookeeper/src/packages/rpm/init.d/zookeeper .)

install -d -m 750 %{buildroot}/var/zookeeper
install -d -m 750 %{buildroot}/var/log/zookeeper


%clean

%files
%defattr(-,zookeeper,zookeeper)
%attr(755,root,root) /usr/bin/zkServer.sh
%attr(755,root,root) /usr/bin/zkCli.sh
%attr(755,root,root) /usr/bin/zkCleanup.sh

%attr(755,root,root) /usr/libexec/*

%dir %attr(-,zookeeper,zookeeper) /etc/zookeeper
%attr(-,zookeeper,zookeeper) /etc/zookeeper/*
#%attr(644,zookeeper,zookeeper) /etc/zookeeper/configuration.xsl
#%attr(644,zookeeper,zookeeper) /etc/zookeeper/log4j.properties

%attr(755,root,root) /etc/rc.d/init.d/zookeeper

%dir %attr(-,zookeeper,zookeeper) /usr/share/zookeeper
%attr(-,zookeeper,zookeeper) /usr/share/zookeeper/*


%dir %attr(750,zookeeper,zookeeper) /var/zookeeper
%dir %attr(750,zookeeper,zookeeper) /var/log/zookeeper
 
%changelog

%pre

# make sure the zookeeper user and group exist:
if id zookeeper > /dev/null 2>&1
then
  :
else
  groupadd -f zookeeper
  useradd -rd /usr/share/zookeeper -s /bin/bash -g zookeeper zookeeper
  passwd -l zookeeper
fi

%post
# setup zookeeper as a system service:
/sbin/chkconfig --add zookeeper
/sbin/chkconfig --level 345 zookeeper on

%preun
/sbin/service zookeeper stop
