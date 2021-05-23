#!/bin/bash
# tag
TAG=3.1.1
NAME=hdfs
IMAGE=$NAME:$TAG
docker tag ${IMAGE} globaldevopsreg11.azurecr.io/${IMAGE}
# push
docker push globaldevopsreg11.azurecr.io/${IMAGE}
