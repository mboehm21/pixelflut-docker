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
cd /var/pixelflut-docker/sturmflut-client-build.sh
./sturmflut-client-build.sh
cd /var/pixelflut-docker/googleimages-client/googleimages-build.sh
```

## Make sure, the images are there

```
root@pc:/var/pixelflut-docker# docker images
REPOSITORY            TAG                 IMAGE ID            CREATED             SIZE
googleimages_client   latest              5ac636cd9a83        21 minutes ago      491MB
sturmflut_client      latest              8bce8545f20e        About an hour ago   526MB
pxflut_srv            latest              257194699ecd        About an hour ago   798MB
pxnuke_srv            latest              93a2156310ef        2 hours ago         493MB
ubuntu                bionic              1d9c17228a9e        8 days ago          86.7MB

```
