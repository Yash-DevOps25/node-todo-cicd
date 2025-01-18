pipeline {
    agent any
    environment {
        SKIP_TESTS = 'true' // Set to 'false' if you want to run tests
    }
    stages {
        stage('Build') {
            steps {
                script {
                    echo 'Building the Docker image'
                    sh 'docker build -t docker.io/yashguj20/node-todo-cicd-image:latest .'
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    echo 'Pushing the Docker image to Docker Hub'
                    sh 'docker push docker.io/yashguj20/node-todo-cicd-image:latest'
                }
            }
        }
        stage('Run Tests') {
            when {
                expression { return env.SKIP_TESTS != 'true' }
            }
            steps {
                script {
                    echo 'Running tests on the application'
                    sh 'docker-compose exec web npm test'
                }
            }
        }
        stage('Deploy to EC2') {
            steps {
                script {
                    echo 'Deploying Docker image to EC2 instance'
                    // EC2 deployment commands here
                }
            }
        }
        stage('Clean Up') {
            steps {
                script {
                    echo 'Cleaning up Docker resources'
                    sh 'docker system prune -f'
                }
            }
        }
    }
}
