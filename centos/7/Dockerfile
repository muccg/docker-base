#
FROM centos:centos7
MAINTAINER https://github.com/muccg

ENV HOME /root

RUN yum install -y \
  epel-release \
  http://dl.iuscommunity.org/pub/ius/stable/CentOS/7/x86_64/ius-release-1.0-14.ius.centos7.noarch.rpm \
  http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-1.noarch.rpm \
  && yum clean all

RUN mkdir /app

RUN groupadd --gid 1000 ccg-user \
  && useradd --home-dir /data --no-create-home --system --uid 1000 --gid 1000 ccg-user \
  && mkdir /data \
  && chown ccg-user:ccg-user /data

CMD /bin/sh
