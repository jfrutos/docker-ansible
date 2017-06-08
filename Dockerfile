FROM ubuntu:trusty
MAINTAINER JAFB <jfrutos@gmail.com>

#Prevent dpkg errors
ENV TERM=xterm-256color

#Set mirrors to ES
RUN sed -i "s/http:\/\/archive./http:\/\/es.archive./g" /etc/apt/sources.list

#Install Python runtime
RUN apt-get update -qy && \
    apt-get install -qy software-properties-common && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update -qy && \
    apt-get install -qy ansible

# Copy backed in playbooks
COPY ansible /ansible
# Add volume for ansible playbooks
VOLUME /ansible
WORKDIR /ansible


# Add entrypoint script
ENTRYPOINT ["ansible-playbook"]
CMD ["site.yml"]
