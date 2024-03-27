 pipeline {
    agent any
      stages{
         stage("Clone Code"){
             steps{
                 git url: "https://github.com/sprasadpujari/full-stack-web-app-jenkins.git", branch: "main"
             }
         }
         stage("Build and Test"){
             steps{
                 sh "docker build . -t sprasadpujari/full-stack-new:latest"
             }
         }
         stage("Push to Docker Hub"){
             steps{
               withCredentials([usernamePassword(credentialsId :'my-docker-registry-credentials',passwordVariable:'dockerHubPassword',usernameVariable: 'dockerHubUser')]) {
            	  sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
               sh "docker push sprasadpujari/full-stack-new:latest"
                
                 }
             }
         }
         stage("Deploy"){
             steps{
                 sh "docker-compose down && docker-compose up -d"
             }
         }
     }
 }
