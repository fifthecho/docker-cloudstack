#!/bin/bash
CLOUDSTACK_VERSION=4.3

check_container(){
  CHECK_FOR_CONTAINER=`docker images | grep -o cloudstack-$1 | uniq`
  if [[ $CHECK_FOR_CONTAINER == "cloudstack-$1" ]]; then
    CHECK_CONTAINER_VERSION=`docker images | grep cloudstack-$1 | awk '{ print $2 }'`
    if [[ $CHECK_CONTAINER_VERSION == *"$CLOUDSTACK_VERSION"* ]]; then
      echo "CloudStack $1 Container is up-to-date. Skipping build."
    else
      echo "CloudStack $1 Container is not up-to-date. Building."
      build_container $1
    fi
  else
    echo "CloudStack $1 Container does not exist. Building."
    build_container $1
  fi
}

build_container(){
  cd $1-server-ubuntu
  docker build -t cloudstack-$1:$CLOUDSTACK_VERSION .
  cd .. 
}

check_db_container_running(){
  CHECK_DB_RUNNING=`docker ps | grep -o cloudstack-database | uniq`
  if [[ $CHECK_DB_RUNNING == "cloudstack-database" ]]; then
    echo "CloudStack Database running. Not starting."
  else
    CHECK_DB_EXISTS=`docker ps -a | grep -o cloudstack-database`
    if [[ $CHECK_DB_EXISTS == "cloudstack-database" ]]; then
      echo "CloudStack Database Container exists, but not running. Starting it now."
      # For some reason, this container won't restart from stop, but DB data exists outside the container.
      docker rm cloudstack-db
      check_db_container_running
    else
      docker run -d --name cloudstack-db -p 3306:3306 cloudstack-database:$CLOUDSTACK_VERSION
    fi
  fi
}

check_mgmt_container_running(){
  CHECK_MGMT_RUNNING=`docker ps | grep -o cloudstack-management | uniq`
  if [[ $CHECK_MGMT_RUNNING == "cloudstack-management" ]]; then
    echo "CloudStack Management Server running. Not starting."
  else
    CHECK_DB_EXISTS=`docker ps -a | grep -o cloudstack-management`
    if [[ $CHECK_DB_EXISTS == "cloudstack-management" ]]; then
      echo "CloudStack Management Server Container exists, but not running. Starting it now."
      docker rm cloudstack-mgmt
      check_mgmt_container_running
    else
      docker run -d --name cloudstack-mgmt --link cloudstack-db:db -p 8080:8080 -p 8250:8250 -p 3922:3922 -p 9090:9090 -p 7080:7080 cloudstack-management:$CLOUDSTACK_VERSION
    fi
  fi
}

check_container "database"
check_container "management"
check_db_container_running
sleep 5
check_mgmt_container_running
