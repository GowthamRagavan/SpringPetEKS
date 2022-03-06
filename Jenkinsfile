pipeline{
    agent any
    environment{
        VERSION = "${env.BUILD_ID}"
        url = "${env.BUILD_URL}"
    }

    stages{
        stage("Compile-Package"){
            sh '''
            chmod 777 ./mvnw
            ./mvnw clean package
	          mv target/spring-petclinic*.jar target/ramapp.jar
             '''
        }

        stage("Build Docker Imager"){
            sh 'docker build -t gowthamragavan/ramweb:0.0.2 .'

        }
        stage('indentifying misconfigs using datree in helm charts'){
            agent{
                docker {
                    image 'openjdk:8'
                  }
            }
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                        sh './mvnw sonarqube'
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

        }
        
        
    }