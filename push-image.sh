#!/bin/bash

CHARITY_IMAGE="charity-website-image:4.0"
echo "build an image"
docker build -t hirodaridevdock/$CHARITY_IMAGE .

echo "login to docker hub"
echo "$DOCKER_TOKEN" | docker login -u "$DOCKER_USERNAME" --password-stdin

echo "push the image in the docker hub"
docker push hirodaridevdock/$CHARITY_IMAGE

echo "$CHARITY_IMAGE pushed"
