#!/bin/bash

# Get the GID of the Docker socket
DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)

# Create a group called docker with the same GID (if not exists)
if ! getent group docker >/dev/null; then
    echo "Creating docker group with GID $DOCKER_GID"
    groupadd -for -g "$DOCKER_GID" docker
fi

# Add jenkins user to docker group
usermod -aG docker jenkins

echo "✅ Jenkins user added to Docker group with GID $DOCKER_GID"

# Execute Jenkins (as jenkins user)
exec gosu jenkins /usr/local/bin/jenkins.sh
