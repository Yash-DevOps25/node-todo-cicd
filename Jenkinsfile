pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'yashguj20/node-todo-cicd-image:latest'
    }

    stages {
        stage('Build') {
            steps {
                script {
                    echo 'Building the Docker image...'
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                    echo 'Logging into Docker Hub and pushing the image...'
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                        sh 'docker push ${DOCKER_IMAGE}'
                    }
                }
            }
        }

        // Skipping the "Run Tests" stage
        stage('Run Tests') {
            steps {
                echo 'Skipping tests stage.'
            }
        }

        stage('Deploy to EC2') {
            steps {
                script {
                    echo 'Deploying to EC2...'
                    // Add EC2 deployment steps here
                }
            }
        }

        stage('Clean Up') {
            steps {
                script {
                    echo 'Cleaning up Docker resources...'
                    sh 'docker system prune -f'
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished'
        }
    }
}
