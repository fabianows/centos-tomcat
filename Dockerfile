# Centos based container with Java and Tomcat
FROM centos:7
MAINTAINER fabianows
ENV container docker

# Install prepare infrastructure
RUN yum -y update && \
 yum install -y vim-enhanced.x86_64 && \
 yum -y install wget && \
 yum -y install tar

# Prepare environment 
ENV JAVA_HOME /usr/local/java
ENV CATALINA_HOME /usr/local/tomcat 
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin:$CATALINA_HOME/scripts

# Install Oracle Java8
ENV JAVA_VERSION 8u131
ENV JAVA_BUILD 8u131-b11
ENV JAVA_DL_HASH d54c1d3a095b4ff2b6607d096fa80163

RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
 http://download.oracle.com/otn-pub/java/jdk/${JAVA_BUILD}/${JAVA_DL_HASH}/jdk-${JAVA_VERSION}-linux-x64.tar.gz && \
 tar -xvf jdk-${JAVA_VERSION}-linux-x64.tar.gz && \
 rm jdk*.tar.gz && \
 mv jdk* ${JAVA_HOME}

# Install Tomcat
ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.5.15

RUN wget http://mirror.nbtelecom.com.br/apache/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/src/apache-tomcat-${TOMCAT_VERSION}-src.tar.gz && \
 tar -xvf apache-tomcat-${TOMCAT_VERSION}-src.tar.gz && \
 rm apache-tomcat*.tar.gz

RUN mv apache-tomcat-${TOMCAT_VERSION}-src /usr/local/tomcat

RUN groupadd tomcat && \
 useradd -s /bin/bash -g tomcat tomcat && \
 chown -Rf tomcat.tomcat /usr/local/tomcat

RUN ls /usr/local/tomcat/conf

#setting tomcat
ADD settings.xml /usr/local/tomcat/conf/
ADD tomcat-users.xml /usr/local/tomcat/conf/
ADD server.xml /usr/local/tomcat/conf/

# Add Projeto 
##ADD src/index.html $CATALINA_HOME/webapps/index.html

# expose tomcat port
EXPOSE 8081

#run tomcat
CMD ["catalina.sh", "run"]
