pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'yashguj20/node-todo-cicd-image'
        MAVEN_HOME = tool name: 'Maven3', type: 'ToolLocation'
    }

    stages {
        stage('Build') {
            steps {
                script {
                    // Node.js build (for example)
                    sh 'docker build -t ${DOCKER_IMAGE}:latest .'
                }
            }
        }
        stage('Maven Build') {
            steps {
                script {
                    // Assuming you're using Maven to build a Java project
                    sh '"${MAVEN_HOME}/bin/mvn" clean install'
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    sh 'docker push ${DOCKER_IMAGE}:latest'
                }
            }
        }
        stage('Deploy to EC2') {
            steps {
                script {
                    // Your EC2 deployment steps
                }
            }
        }
    }

    post {
        always {
            cleanWs()  // Clean workspace after the build
        }
    }
}
