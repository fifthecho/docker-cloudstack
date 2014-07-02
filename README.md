Apache CloudStack in Docker
--------------------

HOWTO:

1. git clone the file to your computer  
  git clone https://github.com/fifthecho/docker-cloudstack.git

2. Set up Ansible [http://docs.ansible.com/intro_installation.html]

3. Execute ./build-and-run.sh

  3. The first Playbook (build-docker-container.yml) is executed to create the Dockerfile and builds the container. This playbook also ensures that NFS is installed and creates /opt/storage/primary, /opt/storage/secondary adds them to /etc/exports, restarts the NFS server. Once all that is done, the playbook starts the container with Secondary Storage mounted.

  3. The second Playbook (configure-environment.yml) is executed to set everything up on your host and create an Ansible host inventory for the Docker container

  3. The third Playbook (setup-cloudstack.yml) does the "heavy lifting" of getting ACS management up and running. This includes setting up the ACS database, starting ACS, and installing the system vm templates for KVM and XenServer.

4. Access the CloudStack management interface via http://localhost:8080/client

5. Cloud!


Additonal work is forthcoming to provide a HTTP server to proxy traffic to prevent the ugly jetty errors you get if you hit http://localhost:8080/

The supervisord web interface is exposed on port 9001 from the container (local port can be fetched by running "docker port cloudstack 9001") for viewing CloudStack logs. I may move to Circus from Supervisord to provide the ACS logs in the "docker logs" output. Username and password are both "cloudstack"

Additionally, this is raw, OSS Apache CloudStack built from source and not a noredist build (like the RPMs/DEBs), so it won't work with things like VMware, Netscaler, etc., but I may fix that too.

Pull requests are very welcome.
