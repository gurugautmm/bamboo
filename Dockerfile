FROM atlassian/bamboo-agent-base:7.2.1
USER root
RUN apt-get update \
&& apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common \
&& curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" \
&& apt-get -y update \
&& apt-get -y install docker-ce docker-ce-cli containerd.io \
&& systemctl enable docker \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*
ARG DOCKERGID=119
RUN groupmod -g ${DOCKERGID} docker
RUN usermod -aG docker ${BAMBOO_USER}
USER ${BAMBOO_USER}
