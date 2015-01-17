#
FROM centos:centos6
MAINTAINER ccg <ccgdevops@googlegroups.com>

ENV HOME /root

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

RUN mkdir /app

RUN groupadd --gid 1000 ccg-user \
  && useradd --home-dir /data --no-create-home --system --uid 1000 --gid 1000 ccg-user \
  && mkdir /data \
  && chown ccg-user:ccg-user /data

VOLUME ["/app", "/data"]

CMD /bin/sh
