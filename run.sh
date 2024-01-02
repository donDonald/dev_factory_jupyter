#!/bin/bash

IMAGE_NAME=${1:-"dev_factory_jupyter"}
FLAGS=" $2 "

if [ -z $IMAGE_NAME ]; then
    echo "Where is mage name to run dude? Exiting" 1>&2
    exit
fi

docker run \
 -it \
 --rm \
 $FLAGS \
 --network=host \
 -p 8888:8888 \
 --mount type=bind,source="$(pwd)"/src,target=/home/dev_factory_jupyter/Jupyter/src \
 --name $IMAGE_NAME \
 $IMAGE_NAME

