#!/bin/bash

set -e 

echo "Pulling latest changes from git"
git pull origin main

echo "Building docker image"
docker build -t rocketdex:latest .

echo "Checking if Minikube is running"
if ! minikube status > /dev/null 2>&1; then
  echo "Starting Minikube"
  minikube start
fi

echo "Loading docker image into Minikube"
minikube image load rocketdex:latest

echo "Applying Kubernetes deployment and service"
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

echo "Waiting for pod to be in Running state"
while [[ $(kubectl get pods -l app=rocketdex -o 'jsonpath={..status.phase}') != "Running" ]]; do
  echo "Waiting for pod..."
  sleep 5
done

echo "Checking if port 8080 is already in use"
if lsof -i :8080; then
  echo "Port 8080 is already in use, skipping port forwarding"
else
  echo "Port forwarding to service"
  kubectl port-forward service/rocketdex-service 8080:80 &
fi