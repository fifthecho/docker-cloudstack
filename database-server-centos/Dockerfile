# Apache CloudStack Management Server - Database Backend
# 
# VERSION 0.1.0
#
FROM centos:6.4
MAINTAINER Jeff Moody <fifthecho@gmail.com>
RUN echo 'root:cloudstack' |chpasswd
RUN yum install -y --nogpgcheck http://fedora-epel.mirror.lstn.net/6/i386/epel-release-6-8.noarch.rpm
RUN yum install -y --nogpgcheck http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
RUN yum install -y ansible
# RUN ansible-playbook /etc/ansible/setup.yml -c local
EXPOSE 3306 22
CMD ["/usr/bin/supervisord"]