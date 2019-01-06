#!/bin/bash

xhost local:root
docker run -d --rm \
--name pxnuke-srv-1 \
--hostname pxnuke-srv-1 \
--net pixels \
-p 1001:1337 \
-e DISPLAY=$DISPLAY \
--privileged \
-v /tmp/.X11-unix:/tmp/.X11-unix \
pxnuke_srv:latest
