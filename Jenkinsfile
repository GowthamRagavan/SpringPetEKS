pipeline{

    agent any
    environment{
        VERSION = "${env.BUILD_ID}"
        url = "${env.BUILD_URL}"
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
                  sh 'docker build -t gowthamragavan/ramweb:0.0.2 .'
              }
           }            
        }

        }
        
        
    }