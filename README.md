Apache CloudStack in Docker
--------------------

HOWTO:

1. git clone the file to your computer  
    $ git clone https://github.com/fifthecho/docker-cloudstack.git

2. Set up Ansible [http://docs.ansible.com/intro_installation.html]

3. Execute ./build-and-run.sh

3a. The first Playbook (build-docker-container.yml) is executed to create the Dockerfile and build the container.

3b. The second Playbook (configure-environment.yml) is executed to set everything up on your host and create an Ansible host inventory for the Docker container

3c. The third Playbook (setup-cloudstack.yml) does the "heavy lifting" of getting ACS management up and running.

4. Access the CloudStack management interface via http://localhost:8080/client

5. Cloud!


Additonal work is forthcoming to provide persistence to the database (using a Docker volume and Ansible tests before running the DB init script) and a HTTP server to proxy traffic to prevent the ugly jetty errors you get if you hit http://localhost:8080/

The supervisord web interface is exposed on port 9001 from the container (local port can be fetched by running ) for viewing CloudStack logs. I may move to Circus from Supervisord to provide the ACS logs in the "docker logs" output.

Additionally, this is raw, OSS Apache CloudStack built from source and not a noredist build (like the RPMs/DEBs), so it won't work with things like VMware, Netscaler, etc., but I may fix that too.

Pull requests are very welcome.
