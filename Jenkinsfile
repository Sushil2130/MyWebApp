pipeline {
    agent any

    environment {
        IMAGE_NAME = "news-portal:latest"
        CONTAINER_NAME = "news-portal-container"
        BUILD_CONTEXT = "." // Dockerfile location
        DOCKER_BUILDKIT = "0" // MUST be string for Windows CMD
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
                bat 'docker version'
                bat 'docker info'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "🖼 Building Docker image"
                // Windows CMD friendly
                bat 'docker build --no-cache -t %IMAGE_NAME% %BUILD_CONTEXT%'
            }
        }

        stage('Stop Old Container') {
            steps {
                echo "🛑 Stopping old container if exists"
                bat """
                docker stop %CONTAINER_NAME% || echo No running container
                docker rm %CONTAINER_NAME% || echo No container to remove
                """
            }
        }

        stage('Run New Container') {
            steps {
                echo "🏃 Running new container"
                bat 'docker run -d -p 9090:80 --name %CONTAINER_NAME% %IMAGE_NAME%'
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline succeeded! Your site should be running on port 9090"
        }
        failure {
            echo "❌ Pipeline failed. Check logs above!"
        }
    }
}
