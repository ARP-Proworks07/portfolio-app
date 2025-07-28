#!/bin/bash

# Get Docker group ID from host-mounted socket
DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)

# Create a docker group inside container with host's GID
groupadd -for -g "$DOCKER_GID" docker

# Add jenkins user to docker group
usermod -aG docker jenkins

echo "✅ Jenkins user added to Docker group with GID $DOCKER_GID"

# Execute original Jenkins startup
exec /usr/bin/tini -- /usr/local/bin/jenkins.sh
