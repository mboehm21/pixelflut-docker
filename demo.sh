#!/bin/bash

/var/pixelflut-docker/pixelflut-srv/pixelflut-srv-run.sh
sleep 5s
/var/pixelflut-docker/googleimages-client/googleimages-client-run.sh
sleep 25s

for i in {1..25}; do
	/var/pixelflut-docker/sturmflut-client/sturmflut-client-run.sh
	sleep 1s
done

sleep 10m

/var/pixelflut-docker/twitter-client/twitter-client-run.sh
sleep 45s

service docker restart
