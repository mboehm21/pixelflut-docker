#!/bin/bash

number=$(shuf -i 2000-65000 -n 1)

name="igrabber"$number

docker run -it --rm \
--name $name \
--hostname $name \
-e GRAB_KEYWORD='test images' \
-e GRAB_DIR='/var/media-in' \
-e GRAB_COUNT='50' \
-e GRAB_SIZE='medium' \
-e GRAB_PROXY='""' \
-e GRAB_MISC='' \
-e GRAB_FLUSH='1' \
-e GRAB_DEBUG='0' \
-v /tmp/media-in:/var/media-in \
googleimages_client:latest
