FROM ubuntu:latest

MAINTAINER simojenki

# Install dependencies
RUN apt-get update && \
	apt-get -y install wget sudo && \
	rm -rf /var/lib/apt/lists/*

RUN	mkdir -p /data /minecraft
WORKDIR /minecraft

RUN wget -q -O - https://jenkins.pmmp.io/job/PHP-7.2-Aggregate/lastSuccessfulBuild/artifact/PHP-7.2-Linux-x86_64.tar.gz > /minecraft/PHP-7.2-Linux-x86_64.tar.gz && \
  cd /minecraft && \
	tar -xvf PHP-7.2-Linux-x86_64.tar.gz && \
	rm PHP-7.2-Linux-x86_64.tar.gz

RUN wget -q -O - https://github.com/pmmp/PocketMine-MP/releases/download/3.9.3/PocketMine-MP.phar > /minecraft/PocketMine-MP.phar

RUN wget -q -O - https://raw.githubusercontent.com/pmmp/PocketMine-MP/master/start.sh > /minecraft/start.sh && \
  chmod +x /minecraft/start.sh

ADD server.properties.default /minecraft/server.properties.default
ADD pocketmine.yml.default /minecraft/pocketmine.yml.default

ADD init.sh /init.sh

EXPOSE 19132/udp

VOLUME /data

ENV PUID 971
ENV PGID 971

CMD [ "bash", "/init.sh" ]
