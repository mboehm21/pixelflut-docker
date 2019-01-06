pixelflut-docker
================

I have added a few implementations of pixelflut-clients and -servers to docker-images for making them portable and easy to setup with all dependencies in the image. This is especially interesting for the client-implementation to spawn many clients on different hosts at will. There is also a container that allows the download of images from Google that are found by keywords to create cool random glitch-art with pixelflut.

# Used software

- pixelflut (server, https://github.com/larsmm/pixelflut)
- pixelnuke (server, https://github.com/defnull/pixelflut/tree/master/pixelnuke)
- sturmflut (client, https://github.com/TobleMiner/sturmflut)
- google-images-download (google-client, https://github.com/hardikvasa/google-images-download)

# Intended workflow

## Build the images

```
cd /var
git clone https://github.com/mboehm21/pixelflut-docker
cd /var/pixelflut-docker/pixelflut-srv
./pixelflut-srv-build.sh
cd /var/pixelflut-docker/pixelnuke-srv
./pixelnuke-srv-build.sh
cd /var/pixelflut-docker/sturmflut-client
./sturmflut-client-build.sh
cd /var/pixelflut-docker/googleimages-client
./googleimages-build.sh
```

## Validate images

```
root@pc:/var/pixelflut-docker# docker images
REPOSITORY            TAG                 IMAGE ID            CREATED             SIZE
googleimages_client   latest              5ac636cd9a83        21 minutes ago      491MB
sturmflut_client      latest              8bce8545f20e        About an hour ago   526MB
pxflut_srv            latest              257194699ecd        About an hour ago   798MB
pxnuke_srv            latest              93a2156310ef        2 hours ago         493MB
ubuntu                bionic              1d9c17228a9e        8 days ago          86.7MB

```

## Start a pixelflut-server in a container

I prefer the pixelflut-implementation over pixelnuke as it supports full-hd. You might have to adapt hostnames or ports in the run-scripts beforehand. Also you might need to create a docker-network for interconnecting clients and server when everything is running on the same machine. In default this network is called 'pixels'.

```
/var/pixelflut-docker/pixelflut-srv/pixelflut-srv-run.sh
### OR ###
/var/pixelflut-docker/pixelnuke-srv/pixelnuke-srv-run.sh
```

## Download images from Google

Next you may use googleimages_client to fetch random images from Google. Of course you can also feed the clients with your own pictures. Before you'll have to create the images-folder on the host and make sure that the user in the docker-container (default: www-data) has write permissions. You might as well adapt the run-script to search for another keyword or to mount another folder. The container will terminate after fetching the images.

```
mkdidr /tmp/media-in
chown www-data:www-data/tmp/media-in
/var/pixelflut-docker/googleimages-client/googleimages-client-run.sh
```
