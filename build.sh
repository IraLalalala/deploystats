#!/bin/bash
wget -O carstats.env https://www.dropbox.com/s/6qbyczs8ucub4hk/carstats.env?dl=1
docker-compose build
docker-compose up -d
rm carstats.env