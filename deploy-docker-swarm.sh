#!/bin/bash
apt-get remove docker docker-engine docker.io containerd runc
apt-get update
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io
docker version
apt install net-tools
IP_ADDR=$(ifconfig eth0 | grep inet | head -n 1 | cut -d: -f2 | awk '{ print $2}')
docker swarm init --advertise-addr $IP_ADDR
curl -L https://downloads.portainer.io/agent-stack-ee210.yml -o agent-stack.yml && docker stack deploy --compose-file=agent-stack.yml portainer-agent


echo ------------------

echo [addr] $IP_ADDR:9001

echo ------------------
