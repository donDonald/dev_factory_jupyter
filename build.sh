#!/bin/bash

IMAGE_NAME=${1:-"dev_factory_jupyter"}
DOCKER_FILE=${2:-"./Dockerfile"}
FLAGS=" $3 "
if [ -z $IMAGE_NAME ]; then
    echo "Where is image name to build dude? Exiting" 1>&2
    exit
fi

docker build -t $IMAGE_NAME $FLAGS -f $DOCKER_FILE  .

