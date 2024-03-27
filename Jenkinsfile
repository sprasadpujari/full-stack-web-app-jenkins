pipeline {
    agent any

       environment {
        DOCKER_CREDENTIALS = credentials('my-docker-registry-credentials')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sprasadpujari/full-stack-web-app-jenkins.git'
            }
        }

        stage('Build and Test') {
            parallel {
                stage('Build and Test Frontend') {
                    steps {
                      script {
                        docker.withRegistry('', DOCKER_CREDENTIALS) {
                        // Build and push Docker images to Docker Hub
                            }
                        dir('frontend') {
                            sh 'npm install'
                            sh 'npm run build'
                            sh 'npm test'
                        }
                      }
                    }
                }
                stage('Build and Test Backend') {
                    steps {
                      script {
                        docker.withRegistry('', DOCKER_CREDENTIALS) {
                        // Build and push Docker images to Docker Hub
                        }          
                        sh 'npm install'
                        sh 'npm run build'
                        sh 'npm test'
                    }
                }
                }
              
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    docker.withRegistry("https://${DOCKER_REGISTRY}", DOCKER_CREDENTIALS) {
                        def frontendImage = docker.build("${DOCKER_REGISTRY}/frontend:${env.BUILD_ID}", "./frontend")
                        def backendImage = docker.build("${DOCKER_REGISTRY}/backend:${env.BUILD_ID}", ".")
                        frontendImage.push()
                        backendImage.push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                sshagent(['your-server-credentials']) {
                    sh """
                        ssh user@your-server.com <<EOF
                        docker pull ${DOCKER_REGISTRY}/frontend:${env.BUILD_ID}
                        docker pull ${DOCKER_REGISTRY}/backend:${env.BUILD_ID}
                        docker pull mongo
                        docker-compose down
                        docker-compose up -d
                        EOF
                    """
                }
            }
        }
    }
}
