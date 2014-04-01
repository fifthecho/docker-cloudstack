Docker-CloudStack-Management
============

## Description

This is a [https://www.docker.io/](Docker) setup to build and run an Apache CloudStack Management Server. 

To start, you will need to execute the build-and-run script which will go through the process of building and running a MySQL 5.5 container (running under Ubuntu) (with many thanks from [https://github.com/orchardup/docker-mysql](Orchard) for the MySQL build process) and an Apache CloudStack Management Server (running under CentOS).
Once the Management Systems are done, you still need to have a Secondary Storage Location and seed it with the [http://docs.cloudstack.apache.org/projects/cloudstack-installation/en/latest/installation.html#prepare-the-system-vm-template](System VM Templates). For convenience of not needing to try and climb into the Management Server Container, I've dropped the cloud-install-sys-tmplt script under "tools" but you will need a MySQL client on your Docker host for the database inserts that script makes to the Database once the seed is complete. You will also need to copy the "db.properties" file from the "tools" directory to /etc/cloudstack/management/ on your Docker host so that your host has the keys into the database.

This is DEFINITELY not ment for production as the encryption and passwords are very basic (cloud / cloudstack)