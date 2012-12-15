Summary: ZooKeeper Build and Comprehension Tool

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
# Overlay the source package contents with the customized files and directories:
#cp -R $RPM_SOURCE_DIR/%{name}-%{version}/* $RPM_BUILD_DIR/%{name}-%{version}

%build
 
%install
# setup the target directory hierarchy:
rm -rf %{buildroot}
install -d -m 755 %{buildroot}/usr/share/zookeeper
mv * %{buildroot}/usr/share/zookeeper
mv %{buildroot}/usr/share/zookeeper/lib/*.jar %{buildroot}/usr/share/zookeeper

mkdir -p %{buildroot}/usr/bin
(cd %{buildroot}/usr/bin && ln -s ../share/zookeeper/bin/zkServer.sh)
(cd %{buildroot}/usr/bin && ln -s ../share/zookeeper/bin/zkEnv.sh)
(cd %{buildroot}/usr/bin && ln -s ../share/zookeeper/bin/zkCli.sh)
(cd %{buildroot}/usr/bin && ln -s ../share/zookeeper/bin/zkCleanup.sh)

install -d -m 755 %{buildroot}/etc/zookeeper
(cd %{buildroot}/etc/zookeeper && ln -s ../../usr/share/zookeeper/conf/configuration.xsl)
(cd %{buildroot}/etc/zookeeper && ln -s ../../usr/share/zookeeper/conf/log4j.properties)
#(cd %{buildroot}/etc/zookeeper && ln -s ../../usr/share/zookeeper/conf/zoo.cfg)

install -d -m 750 %{buildroot}/var/zookeeper
install -d -m 750 %{buildroot}/var/log/zookeeper


%clean

%files
%defattr(-,zookeeper,zookeeper)
%attr(755,root,root) /usr/bin/zkServer.sh
%attr(755,root,root) /usr/bin/zkEnv.sh
%attr(755,root,root) /usr/bin/zkCli.sh
%attr(755,root,root) /usr/bin/zkCleanup.sh
%attr(644,zookeeper,zookeeper) /etc/zookeeper/configuration.xsl
%attr(644,zookeeper,zookeeper) /etc/zookeeper/log4j.properties

%dir %attr(-,zookeeper,zookeeper) /usr/share/zookeeper
%attr(-,zookeeper,zookeeper) /usr/share/zookeeper/*
%dir %attr(-,zookeeper,zookeeper) /etc/zookeeper
%attr(-,zookeeper,zookeeper) /etc/zookeeper/*

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
  useradd -rd /usr/share/zookeeper -g zookeeper zookeeper
  passwd -l zookeeper
fi

%post

%preun
