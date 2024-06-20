#!/bin/bash

echo "build an image"
docker build -t hirodaridevdock/charity-website-image:3.0 .

echo "login to docker hub"
echo "$DOCKER_TOKEN" | docker login -u "$DOCKER_USERNAME" --password-stdin

echo "push the image in the docker hub"
docker push hirodaridevdock/charity-website-image:3.0
