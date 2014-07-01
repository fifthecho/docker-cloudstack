#!/bin/bash
cd /home/cloudstack/cloudstack
mvn -Pdeveloper,systemvm -DskipTests clean install