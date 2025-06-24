pipeline {
    agent any

    tools {
        maven 'Maven'  // Ensure Maven is configured in Jenkins
        jdk 'JDK'      // Ensure JDK 17 is configured in Jenkins
    }

    environment {
        IMAGE_NAME = "xeeshanakram/simple-app"
    }

    stages {
        stage('Clean') {
            steps {
                cleanWs()
            }
        }

        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/XEESHANAKRAM/simple-html-tomcat-app-.git'
            }
        }

        stage('Build WAR') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                withDockerRegistry([ credentialsId: 'docker', url: '' ]) {
                    sh '''
                        docker build -t $IMAGE_NAME:${BUILD_NUMBER} .
                        docker tag $IMAGE_NAME:${BUILD_NUMBER} $IMAGE_NAME:latest
                        docker push $IMAGE_NAME:${BUILD_NUMBER}
                        docker push $IMAGE_NAME:latest
                    '''
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                sh '''
                    docker rm -f simple-app || true
                    docker run -d -p 8081:8080 --name simple-app $IMAGE_NAME:${BUILD_NUMBER}
                '''
            }
        }
    }
}
