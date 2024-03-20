FROM maven:3.6.3-jdk-11 as build 

MAINTAINER "Najam Rizvi"

WORKDIR /app1

COPY pom.xml pom.xml
COPY /src ./src

RUN mvn clean package

FROM tomcat:9.0-jdk11-openjdk
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app1/target/*.war /usr/local/tomcat/webapps/ROOT.war

CMD ["catalina.sh", "run"]