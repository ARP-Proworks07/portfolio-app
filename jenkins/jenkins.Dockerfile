FROM jenkins/jenkins:lts

USER root

# Install Docker CLI
RUN apt-get update && apt-get install -y docker.io

# Dynamically get Docker socket GID inside container and create group
RUN DOCKER_GID=$(stat -c '%g' /var/run/docker.sock) && \
    groupadd -g $DOCKER_GID docker || true && \
    usermod -aG docker jenkins

USER jenkins

