#!/bin/bash

echo "build an image"
docker build -t 181224260758.dkr.ecr.us-east-1.amazonaws.com/charity:1.0 .

echo "login to docker hub"
aws ecr get-login-password | docker login --username AWS --password-stdin \
	181224260758.dkr.ecr.us-east-1.amazonaws.com

echo "push the image in the docker hub"
docker push 181224260758.dkr.ecr.us-east-1.amazonaws.com/charity:1.0
