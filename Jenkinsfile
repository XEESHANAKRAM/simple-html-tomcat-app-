pipeline {
    agent any

    tools {
        maven 'Maven'  // Configure Maven in Jenkins tools
        jdk 'JDK'      // Configure JDK in Jenkins tools
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

        stage('docker built and Push to Docker Hub') {
            steps {
                withDockerRegistry([ credentialsId: 'docker', url: '' ]) {
                    sh '''
                            docker build -t simple-app .
                            docker tag simple-app xeeshanakram/simple-app:latest
                            docker push xeeshanakram/simple-app:latest
                    '''
                }
            }
        }

        stage('Deploy to Docker') {
            steps {
                sh '''
                    docker run -d -p 8081:8080 --name simple-app XEESHANAKRAM/simple-app:${BUILD_NUMBER}
                '''
            }
        }
    }
}
