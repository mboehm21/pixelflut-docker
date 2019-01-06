#!/bin/bash

xhost local:root
docker run -d --rm \
--name pxflut-srv-1 \
--hostname pxflut-srv-1 \
--net pixels \
-p 1000:1337 \
-e DISPLAY=$DISPLAY \
-e PXFLUT_PARAMS="--window" \
-v /tmp/.X11-unix:/tmp/.X11-unix \
--privileged \
pxflut_srv:latest

# -e DISPLAY=0.1
# -e PXFLUT_PARAMS="--window --hide_text" \
