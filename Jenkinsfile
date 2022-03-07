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
                  docker.build register
              }
           }            
        }

        }
        
        
    }