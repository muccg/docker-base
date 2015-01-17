#
FROM debian:jessie
MAINTAINER ccg <ccgdevops@googlegroups.com>

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
  build-essential \
  ca-certificates \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN env --unset=DEBIAN_FRONTEND

RUN mkdir /app

RUN addgroup --gid 1000 ccg-user \
  && adduser --disabled-password --home /data --no-create-home --system -q --uid 1000 --ingroup ccg-user ccg-user \
  && mkdir /data \
  && chown ccg-user:ccg-user /data

VOLUME ["/app", "/data"]

CMD /bin/sh
