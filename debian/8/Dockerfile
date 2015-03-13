#
FROM debian:jessie
MAINTAINER ccg <devops@ccg.murdoch.edu.au>

ENV HOME /root
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
  locales \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN dpkg-reconfigure locales && \
  locale-gen C.UTF-8 && \
  /usr/sbin/update-locale LANG=C.UTF-8

RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
  locale-gen

RUN apt-get update && apt-get install -y --no-install-recommends \
  apt-transport-https \
  ca-certificates \
  netcat \
  net-tools \
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
ONBUILD RUN echo -en "HEAD /\n\n\n" | nc -q -1 -n -v `cat ${BUILD_HOST_FILE}` 3128 | grep squid-deb-proxy \
  && (echo "Acquire::http::Proxy \"http://$(cat ${BUILD_HOST_FILE}):3128\";" > ${APT_PROXY_CONF}) \
  && (echo "Acquire::http::Proxy::ppa.launchpad.net DIRECT;" >> ${APT_PROXY_CONF}) \
  || echo "No squid-deb-proxy detected on docker host"
