pipeline {
    agent any

    environment {
        COMPOSE_FILE = 'docker-compose.yml'
        DOCKER_IMAGE = 'yashguj20/node-todo-cicd-image:latest'
    }

    stages {
        stage('Build and Deploy with Docker Compose') {
            steps {
                script {
                    echo 'Building and deploying services using Docker Compose...'
                    sh 'docker-compose -f ${COMPOSE_FILE} up -d --build'
                }
            }
        }

        stage('Push Docker Images to Docker Hub') {
            steps {
                script {
                    echo 'Pushing Docker images to Docker Hub...'
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                        sh 'docker-compose -f ${COMPOSE_FILE} push'
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed'
        }
        failure {
            echo 'Pipeline failed'
        }
    }
}
