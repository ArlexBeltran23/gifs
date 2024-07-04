pipeline {
    agent any

    environment {
        registry = "arlexbeltran/gifs"
        dockerImage = 'pipe_angular'
    }

    stages {
        stage('Clean Up') {
            steps {
                sh 'rm -rf node_modules/ dist/'

                sh 'npm ci'

                sh 'docker container prune -f'
                sh 'docker image prune -af'
                sh 'docker network prune -f'
            }
        }
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Setup') {
            steps {
                sh 'npm install'
               
            }
        }
        //   stage('Test') {
        //     steps {
        //         sh 'npm run test -- --watch=false --code-coverage --browsers=ChromeHeadless'
        //     }
        // }
        stage('PR Validation') {
            when {
                expression { return env.CHANGE_ID != null }
            }
            steps {
                script {
                    def prN = env.CHANGE_ID
                    echo "Validado PR #${prN}..."
                }
            }
        }
        stage('Build Angular App') {
            steps {
                sh 'npm run build --prod'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build(registry, "-f dockerfile .")
                }
            }
        }
        stage('Publish to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'AngularHub') {
                        dockerImage.push("${env.BUILD_NUMBER}")
                        dockerImage.push("latest")
                    }
                }
            }
        }
    }
}