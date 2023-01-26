FROM jenkins/jenkins:latest
# Is important add "user 0" in order to install dependecies over jenkins images
# USER 0
USER root
# Is important add "-y" to without confirmation https://stackoverflow.com/questions/54352416/unable-to-build-docker-container
RUN apt-get -y update
RUN apt-get -y install python3 python3-pip

# install gcp sdk https://github.com/hostirosti/jenkins-gcloud-sdk-docker/blob/master/Dockerfile
RUN apt-get update && apt-get install -y -qq --no-install-recommends wget unzip openssh-client && apt-get clean
RUN wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.zip && unzip google-cloud-sdk.zip && rm google-cloud-sdk.zip
RUN google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=/.bashrc --disable-installation-options
RUN yes | google-cloud-sdk/bin/gcloud components update preview pkg-go pkg-python pkg-java
RUN mkdir /.ssh
ENV PATH /google-cloud-sdk/bin:$PATH
# VOLUME ["/.config"]

# Install Terraform

RUN wget https://releases.hashicorp.com/terraform/1.3.7/terraform_1.3.7_linux_amd64.zip
RUN unzip terraform_1.3.7_linux_amd64.zip
RUN mv terraform /usr/bin
# which terraform && terraform version

# Install docker

# RUN apt-get update && \
#     apt-get -qy full-upgrade && \
#     apt-get install -qy curl && \
#     apt-get install -qy curl && \
#     curl -sSL https://get.docker.com/ | sh

COPY requirements.txt .
RUN pip install -r requirements.txt
USER jenkins

# https://www.oreilly.com/library/view/practical-mlops/9781098103002/ch01.html