#!/bin/sh
export GEOSERVER_CSRF_WHITELIS=https://geogeoserver.azurewebsites.net/
export GEOSERVER_DATA_DIR=/data
echo "Start sshd"
/usr/sbin/sshd
echo "Start Tomcat"
/usr/local/tomcat/bin/catalina.sh run