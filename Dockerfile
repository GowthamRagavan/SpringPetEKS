FROM openjdk:8
# Take the war and copy to webapps of tomcat
ADD target/ramapp.jar ramapp.jar
EXPOSE 9001
ENTRYPOINT ["java", "-jar", "ramapp.jar"]
