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
RUN apt-get update && apt-get install -y language-pack-ja nkf && \
  update-locale LANG=ja_JP.UTF-8 && \
  rm -rf /var/lib/apt/lists/*
ENV LANG ja_JP.UTF-8

WORKDIR /root/writing
