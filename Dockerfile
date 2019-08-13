FROM ubuntu:latest

MAINTAINER simojenki

ARG OVERLAY_VERSION="v1.22.1.0"
ARG PHP_VERSION=7.2
ARG POCKETMINE_VERSION=3.9.3

RUN mkdir -p /data /minecraft

ADD https://jenkins.pmmp.io/job/PHP-$PHP_VERSION-Aggregate/lastSuccessfulBuild/artifact/PHP-$PHP_VERSION-Linux-x86_64.tar.gz /tmp/
RUN gunzip -c /tmp/PHP-$PHP_VERSION-Linux-x86_64.tar.gz | tar -xf - -C /minecraft

ADD https://github.com/pmmp/PocketMine-MP/releases/download/$POCKETMINE_VERSION/PocketMine-MP.phar /minecraft

ADD https://raw.githubusercontent.com/pmmp/PocketMine-MP/master/start.sh /minecraft
RUN chmod +x /minecraft/start.sh

ADD https://github.com/just-containers/s6-overlay/releases/download/$OVERLAY_VERSION/s6-overlay-amd64.tar.gz /tmp/
RUN gunzip -c /tmp/s6-overlay-amd64.tar.gz | tar -xf - -C /

ADD src/etc /etc
ADD src/minecraft /minecraft

RUN rm /tmp/*

EXPOSE 19132/udp

VOLUME /data

ENTRYPOINT ["/init"]

