# Apache CloudStack Management Server - Database Backend
# 
# VERSION 0.1.0
#
FROM ubuntu:12.04
MAINTAINER Jeff Moody <fifthecho@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
RUN echo 'root:cloudstack' |chpasswd
RUN apt-get update
RUN apt-get install -y openssh-server python-pip python-dev supervisor
RUN mkdir -p /var/log/supervisor
RUN mkdir /var/run/sshd
RUN mkdir /etc/ansible
RUN pip install ansible
ADD build/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD build/database-ansible.yml /etc/ansible/setup.yml
ADD build/ansible-hosts.ini /etc/ansible/hosts
VOLUME ["/var/lib/mysql"]
RUN ansible-playbook /etc/ansible/setup.yml -c local
EXPOSE 3306 22
CMD ["/usr/bin/supervisord"]