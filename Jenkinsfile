pipeline {
    agent any

    environment {
        COMPOSE_FILE = 'docker-compose.yml'  // Your Docker Compose file
    }

    stages {
        // Stage 1: Build and Start Services using Docker Compose
        stage('Build and Deploy with Docker Compose') {
            steps {
                script {
                    echo 'Building and deploying services using Docker Compose...'
                    // Build and start the containers using Docker Compose
                    sh 'docker-compose -f ${COMPOSE_FILE} up -d --build'
                }
            }
        }

        // Stage 2: Run Tests using Docker Compose
        stage('Run Tests') {
            steps {
                script {
                    echo 'Running tests using Docker Compose...'
                    // Add your test commands here, assuming your service is named 'web' in docker-compose.yml
                    sh 'docker-compose -f ${COMPOSE_FILE} exec web npm test'
                }
            }
        }

        // Stage 3: Push Images to Docker Hub
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

        // Stage 4: Clean Up Docker Resources
        stage('Clean Up') {
            steps {
                script {
                    echo 'Cleaning up Docker resources...'
                    // Bring down the services and clean up any stopped containers
                    sh 'docker-compose -f ${COMPOSE_FILE} down'
                    sh 'docker system prune -f'
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
