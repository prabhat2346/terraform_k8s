#!/bin/bash
set -e

TAG=3.1.1
NAME=hdfs
IMAGE=$NAME:$TAG
echo $IMAGE
docker build -f Dockerfile.pipeline --no-cache --squash -t $IMAGE .
# docker build -f Dockerfile.pipeline -t $IMAGE .
