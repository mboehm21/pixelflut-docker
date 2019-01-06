FROM ubuntu:bionic

MAINTAINER Michael Boehm 

RUN export DEBIAN_FRONTEND=noninteractive \
&& apt-get update && apt-get install -y \
git \
netcat \
libevent-pthreads-2.1-6 \
imagemagick \
libmagickwand-dev \
gcc  \
make \
&& cd /var \
&& git clone https://github.com/TobleMiner/sturmflut \
&& cd sturmflut \
&& make \
&& chown -R www-data:www-data /var/sturmflut \
&& apt-get remove -y \
git \
gcc \
make \
&& apt-get clean

COPY starter.pl /var/sturmflut/

USER www-data:www-data

WORKDIR "/var/sturmflut/"

ENTRYPOINT ./starter.pl
