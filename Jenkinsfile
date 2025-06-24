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

        stage('git') {
            steps {
                git branch: 'main', url: 'https://github.com/XEESHANAKRAM/simple-html-tomcat-app-.git'
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
                    docker built -t simple-html-app .
                }
            }
        }

       stage('Push to Docker Hub') {
    steps {
        withDockerRegistry([ credentialsId: 'docker', url: '' ]) {
            sh '''
                docker tag simple-html-app XEESHANAKRAM/simple-html-app:${BUILD_NUMBER}
                docker push XEESHANAKRAM/simple-html-app:${BUILD_NUMBER}
            '''
        }
    }
}

        stage('Deploy to Docker') {
            steps {
                sh '''
                    docker rm -f simple-html-app || true
                    docker run -d -p 8081:8081 --name simple-html-app XEESHANAKRAM/simple-html-app:${BUILD_NUMBER}
                '''
            }
        }
    }
}
