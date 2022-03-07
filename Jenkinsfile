pipeline{

    agent any
    environment{
        VERSION = "${env.BUILD_ID}"
        url = "${env.BUILD_URL}"
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
                  sh '''
                     docker build -t docker_hosted_private/springapp:${VERSION} .

                     '''
                  docker.build register
              }
           }            
        }
        
        stage("Push Docker Imager "){
           steps{
              script{
                  sh '''
                     aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 964874103124.dkr.ecr.us-east-2.amazonaws.com
                     docker push 964874103124.dkr.ecr.us-east-2.amazonaws.com/docker_hosted_private/springapp:${VERSION}
                     '''
              }
           }            
        }
        stage("K8S deploy"){
           steps{
              withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'K8S', namespace: '', serverUrl: '') {
                 sh ('kubectl apply -f  eks-deploy-k8s.yaml')                                      
                  }
           }
        }
        }
        
        
    }