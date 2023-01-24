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