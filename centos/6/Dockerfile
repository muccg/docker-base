FROM centos:centos6
MAINTAINER ccg <ccgdevops@googlegroups.com>

RUN yum install -y \
  http://mirror.aarnet.edu.au/pub/epel/6/i386/epel-release-6-8.noarch.rpm \
  http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64/ius-release-1.0-13.ius.centos6.noarch.rpm \
  http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm \
  && yum clean all \
  && yum install -y \
  gcc \
  gcc-c++ \
  make \
  openssl-devel \
  && yum clean all
