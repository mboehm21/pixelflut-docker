#!/bin/bash

xhost local:root
number=$(shuf -i 2000-65000 -n 1)

name="twitter-client"$number

docker run -d --rm \
--name $name \
--hostname $name \
-e TWITTER_CONSUMER_KEY \
-e TWITTER_CONSUMER_SECRET \
-e TWITTER_ACCESS_TOKEN \
-e TWITTER_ACCESS_TOKEN_SECRET \
-e TWITTER_TEXT='automated #pixelflut image' \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
--privileged \
twitter_client:latest
