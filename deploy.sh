#!/bin/bash

set -e 

git pull origin main

docker build -t rocketdex:latest .
minikube image load rocketdex:latest

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

kubectl port-forward service/rocketdex-service 8080:80