#!/bin/bash

IMAGE_NAME=${1:-"dev_factory_jupyter"}
FLAGS=" $2 "

docker run \
 -it \
 --rm \
 $FLAGS \
 --network=host \
 -p 8888:8888 \
 --mount type=bind,source="$(pwd)"/src,target=/home/dev_factory_jupyter/Jupyter/src \
 --name $IMAGE_NAME \
 $IMAGE_NAME

