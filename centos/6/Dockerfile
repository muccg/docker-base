#
FROM centos:centos6
MAINTAINER https://github.com/muccg

ENV HOME /root

RUN yum install -y \
  http://mirror.aarnet.edu.au/pub/epel/6/i386/epel-release-6-8.noarch.rpm \
  http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64/ius-release-1.0-14.ius.centos6.noarch.rpm \
  http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm \
  http://repo.ccgapps.com.au/repo/ccg/centos/6/os/noarch/CentOS/RPMS/ccg-release-6-2.noarch.rpm \
  && yum clean all

RUN mkdir /app

RUN groupadd --gid 1000 ccg-user \
  && useradd --home-dir /data --no-create-home --system --uid 1000 --gid 1000 ccg-user \
  && mkdir /data \
  && chown ccg-user:ccg-user /data

ENV BUILD_HOST_FILE /data/build_host.txt
ENV YUM_CONF /etc/yum.conf

CMD /bin/sh

# Determine build host
ONBUILD RUN netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2}' > ${BUILD_HOST_FILE}

# squid proxy if available
ONBUILD RUN curl -v -I -H "HEAD /" `cat ${BUILD_HOST_FILE}`:3128 | grep squid-deb-proxy \
  && (echo "proxy=http://$(cat ${BUILD_HOST_FILE}):3128" >> ${YUM_CONF}) \
  || echo "No squid-deb-proxy detected on docker host"
