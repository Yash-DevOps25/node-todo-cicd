pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "node-todo-cicd-image"
        DOCKER_REGISTRY = "docker.io"
        DOCKER_REPO = "yashguj20" // Replace with your Docker Hub username
    }

    stages {
        stage('Build') {
            steps {
                script {
                    echo "Building the Docker image"
                    sh 'docker build -t ${DOCKER_REGISTRY}/${DOCKER_REPO}/${DOCKER_IMAGE}:latest .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    echo "Logging into Docker Hub"
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USER --password-stdin'
                    }
                    echo "Pushing image to Docker Hub"
                    sh 'docker push ${DOCKER_REGISTRY}/${DOCKER_REPO}/${DOCKER_IMAGE}:latest'
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                script {
                    echo "Deploying to EC2"
                    // Add your EC2 deployment commands here
                }
            }
        }
    }

    post {
        always {
            echo "Cleaning up"
            sh 'docker system prune -f'
        }
    }
}
