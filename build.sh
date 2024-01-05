#!/bin/bash

IMAGE_NAME=${1:-"dev_factory_jupyter"}
DOCKER_FILE=${2:-"./Dockerfile"}
FLAGS=" $3 "

docker build -t $IMAGE_NAME $FLAGS -f $DOCKER_FILE  .

