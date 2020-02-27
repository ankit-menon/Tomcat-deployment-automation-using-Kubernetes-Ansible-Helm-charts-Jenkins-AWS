# we are extending everything from tomcat:8.0 image ...
FROM tomcat:8.0

MAINTAINER Ankit
# COPY path-to-your-application-war path-to-webapps-in-docker-tomcat

COPY /var/jenkins_home/workspace/tomcat_deployment /usr/local/tomcat/webapps/
