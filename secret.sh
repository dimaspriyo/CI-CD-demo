#!/bin/bash

kubectl create secret docker-registry my-registry-secret --docker-server=HOST_IP:3010 --docker-username=admin --docker-password=admin --docker-email=myemail@example.com