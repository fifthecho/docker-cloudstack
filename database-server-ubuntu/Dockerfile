# Apache CloudStack Management Server - Database Backend
# 
# VERSION 0.1.0
#
FROM ubuntu:12.04
MAINTAINER Jeff Moody <fifthecho@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN echo "mysql-server mysql-server/root_password password cloud" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password cloud" | debconf-set-selections
RUN apt-get install -y mysql-server
ADD build/cloudstack.cnf /etc/mysql/conf.d/cloudstack.cnf
RUN chmod 664 /etc/mysql/conf.d/cloudstack.cnf
ADD build/run_mysql.sh /usr/local/bin/run_mysql.sh
RUN chmod +x /usr/local/bin/run_mysql.sh
VOLUME ["/var/lib/mysql"]
EXPOSE 3306
CMD ["/usr/local/bin/run_mysql.sh"]