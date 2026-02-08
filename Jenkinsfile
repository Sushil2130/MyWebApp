pipeline {
    agent any

    environment {
        IMAGE_NAME = "news-portal:latest"
        CONTAINER_NAME = "news-portal-container"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image (No Cache)') {
            steps {
                // Build image without cache
                bat "docker build --no-cache -t %IMAGE_NAME% ."
            }
        }

        stage('Stop Old Container') {
            steps {
                // Remove old container if exists
                bat '''
                docker rm -f %CONTAINER_NAME% || echo no_container
                '''
            }
        }

        stage('Run New Container') {
            steps {
                // Run new container on port 9090
                bat '''
                docker run -d -p 9090:80 --name %CONTAINER_NAME% %IMAGE_NAME%
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Latest News Portal deployed on PORT 9090"
        }
        failure {
            echo "❌ Docker build or run failed"
        }
    }
}
