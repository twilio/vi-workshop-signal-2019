#!/bin/bash -x

# Reference: 
# - https://docs.docker.com/engine/userguide/containers/dockerimages/
# - https://github.com/dockerfile/java/blob/master/oracle-java8/Dockerfile

imageTag=vi/docker-spark-zeppelin

ZEPPELIN_DOWNLOAD_URL=http://apache.cs.utah.edu/zeppelin
ZEPPELIN_VERSION=0.8.1 
ZEPPELIN_PORT=8080 
ZEPPELIN_INSTALL_DIR=/usr/lib 



## USE THIS COMMAND if you want to rebuild zeppelin container
#docker build --rm -t ${imageTag} . \

## Builds once
docker build . -t ${imageTag}

#	--build-arg ZEPPELIN_VERSION=${ZEPPELIN_VERSION} \
#	--build-arg ZEPPELIN_DOWNLOAD_URL=${ZEPPELIN_DOWNLOAD_URL} \
#	--build-arg ZEPPELIN_PORT=${ZEPPELIN_PORT} \
#	--build-arg ZEPPELIN_INSTALL_DIR=${ZEPPELIN_INSTALL_DIR} \
#	.

echo "----> To run in interactive mode: "
echo "  docker run --name <some-name> -it ${imageTag}:${version} /bin/bash"
echo "e.g."
echo "  docker run it ${imageTag}:${version} "
echo "  docker run --name "my-$(basename $imageTag)_${version}" -it ${imageTag}:${version} "

echo "----> Docker Images"
echo "To build again: (there is a dot at the end of the command!)"
echo "  docker build -t ${imageTag}:$version -t ${imageTag}:latest . "
echo
docker images |grep "$imageTag"
