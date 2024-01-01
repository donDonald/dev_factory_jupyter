#!/bin/bash

IMAGE=$1
TAG=$2
REGISTRY=$3
PORT=$4

if [ -z $IMAGE ]; then
    echo "Where is image name dude? Exiting" 1>&2
    exit
fi

if [ -z $TAG ]; then
    TAG=latest
    echo "Tag is not given, using default one:$TAG" 1>&2
fi

if [ -z $REGISTRY ]; then
    REGISTRY=localhost
    echo "Registry is not given, using default one:$REGISTRY" 1>&2
fi

if [ -z $PORT ]; then
    PORT=5000
    echo "Port is not given, using default one:$PORT" 1>&2
fi


docker tag $IMAGE:$TAG $REGISTRY:$PORT/$IMAGE:$TAG \
 && docker push $REGISTRY:$PORT/$IMAGE:$TAG

