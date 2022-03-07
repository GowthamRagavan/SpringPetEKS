pipeline{

    agent any
    environment{
        VERSION = "${env.BUILD_ID}"
        url = "${env.BUILD_URL}"
        register = "964874103124.dkr.ecr.us-east-2.amazonaws.com/springapp"
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
                  sh '''
                     docker build -t springapp .
                     docker tag springapp:latest 964874103124.dkr.ecr.us-east-2.amazonaws.com/springapp:${VERSION}

                     '''
              }
           }            
        }
        
        stage("Push Docker Imager "){
           steps{
              script{
                  sh '''
                     aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 964874103124.dkr.ecr.us-east-2.amazonaws.com
                     docker push 964874103124.dkr.ecr.us-east-2.amazonaws.com/springapp:${VERSION}
                     '''
              }
           }            
        }

         stage('indentifying misconfigs using datree in helm charts'){
            steps{
                script{

                    dir('kubernetes/') {
                        withEnv(['DATREE_TOKEN=fsQNDSGM8uAhuLwXfsuSWU']) {
                              sh 'helm datree test myapp/'
                        }
                    }
                }
            }
        }

         stage("K8S deploy"){
           steps{
               script{
                        withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'K8S', namespace: '', serverUrl: '') {
                            dir('kubernetes/') {
                                sh 'helm upgrade --install --set image.repository="964874103124.dkr.ecr.us-east-2.amazonaws.com/springapp" --set image.tag="${VERSION}" myjavaapp myapp/ ' 
                                }                         
                        }

               }
          }

        }
        
        
    }