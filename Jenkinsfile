pipeline{
   tools {
        maven 'Maven3'
    }
    agent any
    environment{
        VERSION = "${env.BUILD_ID}"
        url = "${env.BUILD_URL}"
    }

    stages{
         stage('Sonar and QG'){
            agent{
                docker {
                    image 'openjdk:8'
                  }
            }
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                        sh './mvn sonar:sonar'
                    }

                    timeout(time: 1, unit: 'HOURS') {
                      def qg = waitForQualityGate()
                      if (qg.status != 'OK') {
                           error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }   

                }
            }

        }
        stage("Compile-Package"){
           steps{
              script{
                    sh '''
                       chmod 777 ./mvnw
                       ./mvn clean package
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