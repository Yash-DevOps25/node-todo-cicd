pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'yashguj20/node-todo-cicd-image'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image'
                    sh 'docker build -t ${DOCKER_IMAGE}:latest .'
                }
            }
        }
        stage('Start Services with Docker Compose') {
            steps {
                script {
                    echo 'Starting services using Docker Compose'
                    sh 'docker-compose -f docker-compose.yml up -d'
                }
            }
        }
        stage('Run Tests') {
            steps {
                script {
                    echo 'Running tests on the application'
                    // You can run tests within the container if needed
                    sh 'docker-compose exec web npm test'  // Example for a Node.js app in a "web" service
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    echo 'Pushing image to Docker Hub'
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    sh 'docker push ${DOCKER_IMAGE}:latest'
                }
            }
        }
        stage('Deploy to EC2') {
            steps {
                script {
                    // Deploy to EC2 or another environment
                    echo 'Deploying to EC2'
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up'
            sh 'docker-compose down'  // Shut down the services after the pipeline is finished
            cleanWs()  // Clean workspace
        }
    }
}
