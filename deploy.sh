#!/bin/bash

set -e 

echo "Pulling latest changes from git"
git pull origin main

echo "Building docker image"
docker build -t rocketdex:latest .

echo "Loading docker image into minikube"
minikube image load rocketdex:latest

echo "Applying kubernetes deployment and service"
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

echo "Port forwarding to service"
kubectl port-forward service/rocketdex-service 8080:80