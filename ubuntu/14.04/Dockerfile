FROM ubuntu:14.04
MAINTAINER ccg <ccgdevops@googlegroups.com>

ENV HOME /root
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
  language-pack-en \
  && locale-gen en_US \
  && apt-get update && apt-get install -y --no-install-recommends \
  apt-transport-https \
  ca-certificates \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN env --unset=DEBIAN_FRONTEND

RUN mkdir /app

RUN addgroup --gid 1000 ccg-user \
  && adduser --disabled-password --home /data --no-create-home --system -q --uid 1000 --ingroup ccg-user ccg-user \
  && mkdir /data \
  && chown ccg-user:ccg-user /data

ENV BUILD_HOST_FILE /data/build_host.txt
ENV APT_PROXY_CONF /etc/apt/apt.conf.d/30proxy

CMD /bin/sh

# Determine build host
ONBUILD RUN netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2}' > ${BUILD_HOST_FILE}

# squid proxy if available
ONBUILD RUN echo "HEAD /" | nc -q -1 -n -v  `cat ${BUILD_HOST_FILE}` 3128 | grep squid-deb-proxy \
  && (echo "Acquire::http::Proxy \"http://$(cat ${BUILD_HOST_FILE}):3128\";" > ${APT_PROXY_CONF}) \
  && (echo "Acquire::http::Proxy::ppa.launchpad.net DIRECT;" >> ${APT_PROXY_CONF}) \
  || echo "No squid-deb-proxy detected on docker host"
