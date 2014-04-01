# Apache CloudStack Management Server - Management Server
# 
# VERSION 0.1.0
#
FROM ubuntu:12.04
MAINTAINER Jeff Moody <fifthecho@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y wget hostname mysql-client
RUN echo "deb http://cloudstack.apt-get.eu/ubuntu precise 4.3" > /etc/apt/sources.list.d/cloudstack.list
RUN wget -O - http://cloudstack.apt-get.eu/release.asc|apt-key add -
RUN apt-get update
RUN apt-get install -y cloudstack-management libmysql-java
RUN wget http://download.cloud.com.s3.amazonaws.com/tools/vhd-util -O /usr/share/cloudstack-common/scripts/vm/hypervisor/xenserver/vhd-util
ADD build/run_cloudstack.sh /usr/local/bin/run_cloudstack.sh
RUN chmod 755 /usr/local/bin/run_cloudstack.sh
ADD build/cloudstack-setup-databases /usr/bin/cloudstack-setup-databases
RUN chmod 755 /usr/bin/cloudstack-setup-databases
EXPOSE 8080
CMD ["/usr/local/bin/run_cloudstack.sh"]