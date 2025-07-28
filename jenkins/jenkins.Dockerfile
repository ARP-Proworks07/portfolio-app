FROM jenkins/jenkins:lts

USER root

# Install Docker CLI
RUN apt-get update && apt-get install -y docker.io

# Match the Docker group ID from host
RUN groupadd -for -g 989 docker && usermod -aG docker jenkins

# Optional: Print groups for debugging
RUN id jenkins

USER jenkins

