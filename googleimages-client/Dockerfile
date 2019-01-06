FROM ubuntu:bionic

MAINTAINER Michael Boehm 

COPY starter.pl /var/

RUN cd /var/ \ 
&& export DEBIAN_FRONTEND=noninteractive \
&& apt-get update && apt-get install -y \
python3-pip \
libstring-random-perl \
&& pip3 install google_images_download \
&& chown www-data:www-data /var/starter.pl

USER www-data:www-data

WORKDIR "/var"

CMD /var/starter.pl
