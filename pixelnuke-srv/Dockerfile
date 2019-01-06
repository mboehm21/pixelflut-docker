FROM ubuntu:bionic

MAINTAINER Michael Boehm 

RUN export DEBIAN_FRONTEND=noninteractive \
&& apt-get update && apt-get install -y \
git \
x11-apps \
build-essential \
libevent-dev \
libglew-dev \
libglfw3-dev \
gcc  \
make \
&& cd /var \
&& git clone https://github.com/defnull/pixelflut/ \
&& mv /var/pixelflut/pixelnuke /var/pixelnuke \
&& rm -r /var/pixelflut \
&& cd /var/pixelnuke \
&& make \
&& chown -R www-data:www-data /var/pixelnuke \
&& apt-get remove -y \
git \
gcc \
make \
&& apt-get clean

WORKDIR "/var/pixelnuke/"

ENTRYPOINT "./pixelnuke"

USER www-data:www-data

EXPOSE 1337
