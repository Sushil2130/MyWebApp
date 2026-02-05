pipeline {
    agent any
    stages {
        stage('Checkout Code') { steps { checkout scm } }
        stage('Build Docker Image') { steps { sh 'docker build -t mywebapp-image .' } }
        stage('Run Docker Container') {
            steps {
                sh '''
                    docker stop mywebapp-container || true
                    docker rm mywebapp-container || true
                    docker run -d -p 9090:80 --name mywebapp-container mywebapp-image
                '''
            }
        }
        stage('Post Actions') { steps { echo 'Website is live on port 9090' } }
    }
}
