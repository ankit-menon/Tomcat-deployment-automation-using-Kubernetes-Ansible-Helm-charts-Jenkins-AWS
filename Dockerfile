# we are extending everything from tomcat:8.0 image ...

RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz
  
FROM tomcat:8.0

MAINTAINER Ankit
# COPY path-to-your-application-war path-to-webapps-in-docker-tomcat

COPY helloworld.war /usr/local/tomcat/webapps/
