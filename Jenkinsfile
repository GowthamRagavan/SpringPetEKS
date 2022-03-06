node{
   stage('SCM Checkout'){
    sh 'rm -rf spring-petclinic'
    sh 'git clone https://github.com/GowthamRagavan/spring-petclinic.git'
    sh 'rsync -a spring-petclinic/ .'
   }
   
   stage('Compile-Package'){

      //def mvnHome =  tool name: 'maven3', type: 'maven'   
      //sh "${mvnHome}/bin/mvn clean package"
      sh './mvnw clean package'
	  sh 'mv target/spring-petclinic*.jar target/ramapp.jar'
   }
   stage('SonarQube Analysis') {
	                  
	        withSonarQubeEnv('sonar') { 
                   sh './mvnw  sonar:sonar'      
	          }
	    }
   stage('Build Docker Imager'){
   sh 'docker build -t gowthamragavan/ramweb:0.0.2 .'
   }
   
   stage('Docker Image Push'){
   withCredentials([string(credentialsId: 'dockerPass', variable: 'dockerPassword')]) {
   sh "docker login -u gowthamragavan -p ${dockerPassword}"
    }
   sh 'docker push gowthamragavan/ramweb:0.0.2'
   }
        
   stage('Nexus Image Push'){
   withCredentials([string(credentialsId: 'nexusPass', variable: 'nexusPassword')]) {
   sh "docker login -u admin -p ${nexusPassword} 18.132.40.184:8083"
   }
   sh "docker tag gowthamragavan/ramweb:0.0.2 18.132.40.184:8083/ramweb:1.0.0"
   sh 'docker push 18.132.40.184:8083/ramweb:1.0.0'
   }
        
   stage('Remove Previous Container'){
	try{
		sh 'docker rm -f tomcattest'
	}catch(error){
		//  do nothing if there is an exception
	}
	
   stage('Docker deployment'){
   sh 'docker run -d -p 9001:9001 --name tomcattest gowthamragavan/ramweb:0.0.2' 
   }   
   }
}
