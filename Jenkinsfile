pipeline {
    agent any

    environment {
        IMAGE_NAME = "news-portal:latest"
        CONTAINER_NAME = "news-portal-container"
        PORT = "9090"
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo "📥 Checking out code from Git"
                checkout scm
            }
        }

        stage('Test Docker') {
            steps {
                echo "🛠 Checking Docker installation"
                bat "docker version"
                bat "docker info"
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "🖼 Building Docker image"
                bat """
                docker build --no-cache -t %IMAGE_NAME% .
                """
            }
        }

        stage('Stop Old Container') {
            steps {
                echo "🛑 Stopping old container (if exists)"
                bat """
                docker rm -f %CONTAINER_NAME% || echo No old container found
                """
            }
        }

        stage('Run New Container') {
            steps {
                echo "🚀 Running new container on port %PORT%"
                bat """
                docker run -d -p %PORT%:80 --name %CONTAINER_NAME% %IMAGE_NAME%
                """
            }
        }
    }

    post {
        success {
            echo "✅ News Portal deployed successfully on http://localhost:%PORT%"
        }
        failure {
            echo "❌ Pipeline failed. Check the logs above!"
        }
    }
}
