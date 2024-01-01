#!/bin/bash

IMAGE_NAME=${1:-"dev_factory_jupyter"}
if [ -z $IMAGE_NAME ]; then
    echo "Where is mage name to run dude? Exiting" 1>&2
    exit
fi

docker run -it --rm --network=host -p 8888:8888 \
 $IMAGE_NAME

