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
                bat '''
                docker version
                docker info
                '''
            }
        }

        stage('Build Docker Image (No Cache)') {
            steps {
                echo "🖼 Building Docker image"
                bat '''
                docker build --no-cache -t %IMAGE_NAME% .
                '''
            }
        }

        stage('Stop Old Container') {
            steps {
                echo "🛑 Stopping old container if exists"
                bat '''
                docker ps -a -q --filter "name=%CONTAINER_NAME%" > tmp.txt
                set /p CID=<tmp.txt
                if NOT "%CID%"=="" docker rm -f %CONTAINER_NAME%
                del tmp.txt
                '''
            }
        }

        stage('Run New Container') {
            steps {
                echo "🚀 Running new container"
                bat '''
                docker run -d -p %PORT%:80 --name %CONTAINER_NAME% %IMAGE_NAME%
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Latest News Portal deployed successfully on PORT %PORT%"
        }
        failure {
            echo "❌ Docker build or run failed. Check logs above!"
        }
    }
}
