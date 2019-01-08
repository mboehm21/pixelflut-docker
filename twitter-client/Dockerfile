FROM ubuntu:bionic

MAINTAINER Michael Boehm 

COPY starter.pl /var/

RUN cd /var/ \ 
&& export DEBIAN_FRONTEND=noninteractive \
&& apt-get update && apt-get install -y \
libnet-twitter-lite-perl \
x11-apps \
xorg \
scrot \
libstring-random-perl \
&& chown www-data:www-data /var/starter.pl \
&& apt-get clean

USER www-data:www-data

WORKDIR "/var"

ENTRYPOINT ./starter.pl
