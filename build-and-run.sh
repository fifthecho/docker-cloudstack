#!/bin/bash
cd database-server-ubuntu
docker build -t cloudstack-management-database .
cd ..
cd management-server-ubuntu
docker build -t cloudstack-management-server .
cd ..
docker run -d --name cloudstack-db -p 3306:3306 cloudstack-management-database
docker run -d --link cloudstack-db:db --name cloudstack-mgmt -p 8080:8080 cloudstack-management-server