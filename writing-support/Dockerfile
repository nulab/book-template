# writing
#
# VERSION               0.0.1

FROM       ubuntu:trusty
MAINTAINER Tomonari Nakamura <nakamura@nulab-inc.com>

ENV DEBIAN_FRONTEND noninteractive

# pandoc & latex
RUN apt-get update && apt-get install -y pandoc texlive-full && \
  rm -rf /var/lib/apt/lists/*

# gnuplot
RUN apt-get update && apt-get install -y gnuplot && \
  rm -rf /var/lib/apt/lists/*

# lang
# workarround : https://bugs.launchpad.net/ubuntu-jp-improvement/+bug/1508796
# RUN apt-get update && apt-get install -y language-pack-ja nkf && \
RUN apt-get update && apt-get install -y language-pack-ja=1:14.04+20140410 nkf && \
  update-locale LANG=ja_JP.UTF-8 && \
  rm -rf /var/lib/apt/lists/*
ENV LANG ja_JP.UTF-8

WORKDIR /root/writing
