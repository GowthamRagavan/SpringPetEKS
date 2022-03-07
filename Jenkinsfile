pipeline{

    agent any
    environment{
        VERSION = "${env.BUILD_ID}"
        register = "964874103124.dkr.ecr.us-east-2.amazonaws.com/docker_hosted_private"
    }




    stages{
         stage("Compile-Package"){
           steps{
              script{
                    sh '''
                       chmod 777 ./mvnw
                       ./mvnw clean package
	                    mv target/spring-petclinic*.jar target/ramapp.jar
                       '''
                   }
              }
          }

        stage("Build Docker Imager"){
           steps{
              script{
                  docker.build -t docker_springpet
                  docker tag docker_springpet:${VERSION} 964874103124.dkr.ecr.us-east-2.amazonaws.com/docker_springpet:${VERSION}
              }
           }            
        }
        
        stage("Push Docker Imager "){
           steps{
              script{
                  sh '''
                     aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 964874103124.dkr.ecr.us-east-2.amazonaws.com
                     docker push 964874103124.dkr.ecr.us-east-2.amazonaws.com/docker_hosted_private:latest
                     '''
              }
           }            
        }
        }
        
        
    }