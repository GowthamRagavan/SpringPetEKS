FROM openjdk:8
WORKDIR /
# Take the war and copy to webapps of tomcat
ADD target/ramapp.jar ramapp.jar
EXPOSE 9001
CMD java - jar ramapp.jar