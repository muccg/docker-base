FROM centos:centos6
MAINTAINER ccg <ccgdevops@googlegroups.com>

RUN yum install -y \
  http://mirror.aarnet.edu.au/pub/epel/6/i386/epel-release-6-8.noarch.rpm \
  && yum update

RUN yum install -y \
  http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64/ius-release-1.0-13.ius.centos6.noarch.rpm \
  && yum update

RUN yum clean all
