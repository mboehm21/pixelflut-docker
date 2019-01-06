FROM ubuntu:bionic

MAINTAINER Michael Boehm 

RUN export DEBIAN_FRONTEND=noninteractive \
&& apt-get update && apt-get install -y \
git \
x11-apps \
build-essential \
xorg \
pkg-config \
libsdl2-dev \
gcc  \
make \
&& cd /var \
&& git clone https://github.com/larsmm/pixelflut \
&& cd pixelflut \
&& make \
&& chown -R www-data:www-data /var/pixelflut \
&& apt-get remove -y \
git \
gcc \
make \
&& apt-get clean

WORKDIR "/var/pixelflut/"

ENTRYPOINT ./pixelflut $PXFLUT_PARAMS --port 1337

USER www-data:www-data

EXPOSE 1337
