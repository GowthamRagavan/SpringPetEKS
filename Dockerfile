FROM openjdk:8-jre
# Take the war and copy to webapps of tomcat
ADD target/ramapp.jar ramapp.jar
EXPOSE 8085
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom","-jar", "ramapp.jar"]