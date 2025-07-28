FROM jenkins/jenkins:lts

USER root

# Install Docker CLI
RUN apt-get update && apt-get install -y docker.io && apt-get clean

# Copy custom entrypoint
COPY jenkins/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Use the modified entrypoint (but keep Jenkins startup intact)
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
