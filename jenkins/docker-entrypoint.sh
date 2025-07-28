#!/bin/bash

# Get GID of Docker socket
DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)

# Create docker group with that GID if it doesn't exist
if ! getent group docker >/dev/null; then
    groupadd -g "$DOCKER_GID" docker
fi

# Add jenkins user to docker group
usermod -aG docker jenkins

echo "✅ Jenkins user added to Docker group with GID $DOCKER_GID"

# Run Jenkins using tini directly as PID 1
exec /usr/bin/tini -- /usr/local/bin/jenkins.sh