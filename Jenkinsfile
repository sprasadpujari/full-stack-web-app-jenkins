pipeline {
    agent any

    stages {
        stage('Checkout') {
             steps {
                git branch: 'main', url: 'https://github.com/sprasadpujari/full-stack-web-app-jenkins.git'
            }
        }

        stage('Build Backend') {
            steps {
                sh 'docker build -t my-backend -f Dockerfile .'
            }
        }

        stage('Build Frontend') {
            steps {
                sh 'docker build -t my-frontend -f frontend/Dockerfile .'
            }
        }

        stage('Run Tests') {
            steps {
                // Add your test commands here
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker-compose up -d'
            }
        }
    }

    post {
        always {
            sh 'docker-compose down'
        }
    }
}
