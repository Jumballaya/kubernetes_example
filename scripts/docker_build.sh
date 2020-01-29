#!/bin/bash

## Client
docker build -t pburris/multi-client -f ./client/Dockerfile.dev ./client

## Server
docker build -t pburris/multi-server -f ./client/Dockerfile.dev ./server

## Worker
docker build -t pburris/multi-worker -f ./client/Dockerfile.dev ./worker
