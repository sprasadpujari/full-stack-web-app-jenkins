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
                 withCredentials([usernamePassword(credentialsId: 'my-docker-registry-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
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
