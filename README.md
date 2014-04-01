Docker-CloudStack-Management
============

## Description

This is a [Docker](https://www.docker.io/) setup to build and run an Apache CloudStack Management Server. 

To start, you will need to execute the build-and-run script which will go through the process of building and running a MySQL 5.5 container (running under Ubuntu 12.04) (with many thanks from [Orchard](https://github.com/orchardup/docker-mysql) for the MySQL build process) and an Apache CloudStack Management Server (running under Ubuntu 12.04).
Once the Management Systems are done, you still need to have a Secondary Storage Location and seed it with the [System VM Templates](http://docs.cloudstack.apache.org/projects/cloudstack-installation/en/latest/installation.html#prepare-the-system-vm-template). For convenience of not needing to try and climb into the Management Server Container, I've dropped the cloud-install-sys-tmplt script under "tools" but you will need a MySQL client on your Docker host for the database inserts that script makes to the Database once the seed is complete. You will also need to copy the "db.properties" file from the "tools" directory to /etc/cloudstack/management/ on your Docker host so that your host has the keys into the database.

This is DEFINITELY not ment for production as the encryption and passwords are very basic (cloud / cloudstack) and as of this initial release, the CloudStack database is flushed and re-written on a restart of the Management Server container.

## Use

Clone. Run the ./build-and-run.sh script. Connect to localhost on port 8080 for the CloudStack Management UI.
