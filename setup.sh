# install  jenkins
# docker pull jenkins/jenkins

# Create a bridge network in Docker using the following docker network create command:
# docker network create jenkins


# docker run \
#   --name jenkins-docker \
#   --rm \
#   --detach \
#   --privileged \
#   --network jenkins \
#   --network-alias docker \
#   --env DOCKER_TLS_CERTDIR=/certs \
#   --volume jenkins-docker-certs:/certs/client \
#   --volume jenkins-data:/var/jenkins_home \
#   --publish 2376:2376 \
#   docker:dind \
#   --storage-driver overlay2


# docker build -t mlops .
# docker run -p 8080:8080 -p 50000:50000 -v /home/serendipita:/var/jenkins_home --name jenkins jenkins/jenkins:latest
# docker exec -it jenkins /bin/bash

# Reading package lists... Done
# E: List directory /var/lib/apt/lists/partial is missing. - Acquire (13: Permission denied)

# is important to add "-u 0"


# docker exec -it -u 0 92f
# docker exec -it -u 0 jenkins /bin/bash


# docker build -t mlops .
# docker run -p 8080:8080 -p 50000:50000 -v /home/serendipita/mlops:/var/jenkins_home --name mlops mlops





# Build
# *******

# Test
# IAC (infraestructure as code)
# Deploy




# check  os linux
# uname -a  or uname -m
# dpkg --print-arquitecture


# wget https://releases.hashicorp.com/terraform/1.3.7/terraform_1.3.7_linux_amd64.zip
# unzip terraform_1.3.7_linux_amd64.zip
# mv terraform /usr/bin/