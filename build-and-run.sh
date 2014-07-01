#!/bin/bash
ansible-playbook ./build-docker-container.yml && sleep 5 && ansible-playbook ./configure-environment.yml && sleep 5 && ansible-playbook -i ./hosts ./setup-cloudstack.yml