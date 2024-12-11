#!/usr/bin/env bash

echo admin | docker login $1 -u admin --password-stdin

echo "docker build --tag $2:$3 ."
docker build --tag $2:$3 .

echo "docker tag $2:$3 $1/$2:$3"
docker tag $2:$3 $1/$2:$3

echo "docker push $1/$2:$3"
docker push $1/$2:$3