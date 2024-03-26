pipeline {
    agent any
     stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sprasadpujari/full-stack-web-app-jenkins.git'
            }
        }
         stage('Build') {
            parallel {
                stage('Build React') {
                    steps {
                        dir('frontend') {
                            sh 'npm install'
                            sh 'npm run build'
                        }
                    }
                }
                stage('Build Node.js') {
                    steps {
                        dir('backend') {
                            sh 'npm install'
                            sh 'npm run build'
                        }
                    }
                }
            }
        }

        stage('Test') {
            parallel {
                stage('Test React') {
                    steps {
                        dir('frontend') {
                            sh 'npm install'
                            sh 'npm test'
                        }
                    }
                }
                stage('Test Node.js') {
                    steps {
                        dir('backend') {
                            sh 'npm install'
                            sh 'npm test'
                        }
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
                dir('frontend') {
                    sh 'docker build -t react-app:${BUILD_NUMBER} .'
                }
                dir('backend') {
                    sh 'docker build -t node-app:${BUILD_NUMBER} .'
                }
                sh 'docker build -t mysql-db:${BUILD_NUMBER} ./database'
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    sh 'docker push react-app:${BUILD_NUMBER}'
                    sh 'docker push node-app:${BUILD_NUMBER}'
                    sh 'docker push mysql-db:${BUILD_NUMBER}'
                }
            }
        }

        stage('Deploy') {
            steps {
                sshagent(['deploy-server-credentials']) {
                    sh 'ssh user@remote-server "docker-compose -f /path/to/docker-compose.yml pull"'
                    sh 'ssh user@remote-server "docker-compose -f /path/to/docker-compose.yml up -d"'
                }
            }
        }
    }
}
