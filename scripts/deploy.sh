#!/bin/bash

## If the current GIT SHA value is not set, set it
if [ -z "$SHA" ]
then
      SHA=$(git rev-parse HEAD)
fi

####
#
# Docker Image Build
#
####
docker build -t pburris/multi-client:latest -t pburris/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t pburris/multi-server:lastest -t pburris/multi-server:$SHA -f ./client/Dockerfile.dev ./server
docker build -t pburris/multi-worker:latest -t pburris/multi-worker:$SHA -f ./client/Dockerfile.dev ./worker

####
#
# Docker Image Deploy
#
####
docker push pburris/multi-client:latest
docker push pburris/multi-server:latest
docker push pburris/multi-worker:latest

docker push pburris/multi-client:$SHA
docker push pburris/multi-server:$SHA
docker push pburris/multi-worker:$SHA

####
#
# Kubernetes Deploy
#
####
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=pburris/multi-client:$SHA
kubectl set image deployments/server-deployment server=pburris/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=pburris/multi-worker:$SHA