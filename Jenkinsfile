pipeline {
    agent any

    environment {
        COMPOSE_FILE = 'docker-compose.yml'
        DOCKER_IMAGE = 'yashguj20/node-todo-cicd-image:latest'
    }

    stages {
        stage('Free Port 8000') {
            steps {
                script {
                    echo 'Freeing up port 8000...'
                    sh '''
                        CONTAINER_ID=$(docker ps -q --filter "ancestor=${DOCKER_IMAGE}" --filter "publish=8000")
                        if [ ! -z "$CONTAINER_ID" ]; then
                          docker stop $CONTAINER_ID
                          docker rm $CONTAINER_ID
                        fi
                    '''
                }
            }
        }

        stage('Build and Deploy with Docker Compose') {
            steps {
                script {
                    echo 'Building and deploying services using Docker Compose...'
                    sh 'docker-compose -f ${COMPOSE_FILE} up -d --build'
                }
            }
        }

        // Stage 'Run Tests' is skipped by commenting it out or removing it
        // stage('Run Tests') {
        //     steps {
        //         script {
        //             echo 'Skipping tests...'
        //         }
        //     }
        // }

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

        stage('Clean Up') {
            steps {
                script {
                    echo 'Cleaning up Docker resources...'
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
