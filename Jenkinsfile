pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('gifs') // ID de las credenciales en Jenkins
        DOCKER_IMAGE = "arlexbeltran/gifs" // Reemplaza 'miusuario' con tu nombre de usuario de Docker Hub
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Angular App') {
            steps {
                sh 'npm install'
                sh 'npm run build -- --configuration production'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${env.DOCKER_IMAGE}:latest")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', env.DOCKERHUB_CREDENTIALS) {
                        docker.image("${env.DOCKER_IMAGE}:latest").push()
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
        success {
            echo 'La construcción y el despliegue fueron exitosos.'
        }
        failure {
            echo 'La construcción o el despliegue fallaron.'
        }
    }
}