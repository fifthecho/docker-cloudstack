#!/bin/bash
ansible-playbook -i ./local-hosts ./build-docker-container.yml && sleep 15 \
&& ansible-playbook -i ./local-hosts ./configure-environment.yml && sleep 5 \
&& ansible-playbook -i ./hosts ./setup-cloudstack.yml
