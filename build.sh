#!/bin/bash
POSTGRES_PASSWORD=$1
echo $POSTGRES_PASSWORD
docker-compose build --build-arg SSH_PRIVATE_KEY="`echo "$(cat ~/.ssh/id_rsa)"`" --build-arg POSTGRES_PASSWORD=$POSTGRES_PASSWORD
docker-compose up -d