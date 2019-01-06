#!/bin/bash

number=$(shuf -i 2000-65000 -n 1)

name="sturmflut_client"$number

docker run -d --rm \
--name $name \
--hostname $name \
-e PXFLUT_SRV='pxflut-srv-1.pixels' \
-e PXFLUT_PORT='1337' \
-e PXFLUT_DIR='/var/sturmflut/media-in' \
-e PXFLUT_TIMEOUT='10' \
-e PXFLUT_REFRESH='2' \
-e PXFLUT_DEBUG='0' \
-e PXFLUT_X='rand' \
-e PXFLUT_Y='rand' \
-v /tmp/media-in:/var/sturmflut/media-in \
--net pixels sturmflut_client:latest
