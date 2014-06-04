# Apache CloudStack Management Server - Database Backend
# 
# VERSION 0.1.0
#
FROM centos:6.4
MAINTAINER Jeff Moody <fifthecho@gmail.com>
RUN yum install -y --nogpgcheck http://fedora-epel.mirror.lstn.net/6/i386/epel-release-6-8.noarch.rpm
RUN yum install -y ansible
ADD build/ansible-hosts.ini /etc/ansible/hosts
ADD build/database-ansible.yml /etc/ansible/setup.yml
RUN ansible-playbook /etc/ansible/setup.yml -c local
ADD build/supervisord.conf /etc/supervisord.conf
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

EXPOSE 3306 22
CMD /usr/bin/supervisord