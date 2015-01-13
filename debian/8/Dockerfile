FROM debian:jessie
MAINTAINER ccg <ccgdevops@googlegroups.com>

ENV HOME /root
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
  locales \
  && locale-gen en_US \
  && apt-get update && apt-get install -y \
  apt-transport-https \
  build-essential \
  ca-certificates \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN env --unset=DEBIAN_FRONTEND
