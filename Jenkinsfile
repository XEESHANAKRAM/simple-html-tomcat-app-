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

        stage('Checkout') {
            steps {
                git 'https://github.com/your-username/simple-html-tomcat-app.git'
            }
        }

        stage('Build WAR') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("yourdockerhub/simple-html-app:${BUILD_NUMBER}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry([ credentialsId: 'dockerhub-creds', url: '' ]) {
                    script {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy to Docker') {
            steps {
                sh '''
                    docker rm -f simple-html-app || true
                    docker run -d -p 8080:8080 --name simple-html-app yourdockerhub/simple-html-app:${BUILD_NUMBER}
                '''
            }
        }
    }
}
