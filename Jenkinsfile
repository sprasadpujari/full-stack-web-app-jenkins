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
                 sh "docker build . -t full-stack-app"
             }
         }
         stage("Push to Docker Hub"){
             steps{
                 withCredentials([usernamePassword(credentialsId: 'my-docker-registry-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                    sh "docker tag full-stack-app $DOCKER_USERNAME/full-stack-app:latest"
                    sh "docker push $DOCKER_USERNAME/full-stack-app:latest"
                 }
             }
         }
         stage("Deploy"){
             steps{
                 sh "docker-compose up -d"
             }
         }
     }
 }
