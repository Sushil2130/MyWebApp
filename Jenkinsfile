pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t news-portal .'
            }
        }

        stage('Run Docker Container') {
            steps {
                bat '''
                docker rm -f news-portal-container || echo container_not_found
                docker run -d -p 9090:80 --name news-portal-container news-portal
                '''
            }
        }
    }

    post {
        success {
            echo '✅ News Portal running on PORT 9090'
        }
        failure {
            echo '❌ Pipeline failed'
        }
    }
}
