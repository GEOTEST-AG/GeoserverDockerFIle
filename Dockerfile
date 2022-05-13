FROM tomcat:9.0.62-jre8-openjdk-bullseye

MAINTAINER christoph.suter@geotest.ch

RUN apt-get update


WORKDIR /usr/local/tomcat/webapps/
RUN curl -O -L https://sourceforge.net/projects/geoserver/files/GeoServer/2.20.4/geoserver-2.20.4-war.zip
RUN unzip geoserver-2.20.4-war.zip

RUN apt install  openssh-server sudo -y
# Install OpenSSH and set the password for root to "Docker!". In this example, "apk add" is the install instruction for an Alpine Linux-based image.
RUN echo "root:Docker!" | chpasswd 
RUN mkdir /run/sshd

# Copy the sshd_config file to the /etc/ssh/ directory
COPY sshd_config /etc/ssh/

# Copy and configure the ssh_setup file
RUN mkdir -p /tmp
COPY ssh_setup.sh /tmp
RUN chmod +x /tmp/ssh_setup.sh \
    && (sleep 1;/tmp/ssh_setup.sh 2>&1 > /dev/null)

ENV GEOSERVER_CSRF_WHITELIS=https://geogeoserver.azurewebsites.net/
ENV GEOSERVER_DATA_DIR=/data

COPY startup.sh /home

# Open port 2222 for SSH access
EXPOSE 8080 2222

CMD ["/home/startup.sh",""]
