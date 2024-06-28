pipeline {
    agent any

    environment {
        registry = "arlexbeltran/authApp"
        dockerImage = 'pipe_angular'
         LD_LIBRARY_PATH = "/snap/ubuntu-desktop-installer/1286/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"
        CHROME_BIN = '/usr/bin/google-chrome-stable'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Setup') {
            steps {
                sh 'npm install'
                sh 'npm run test'
            }
        }
        // stage('PR Validation') {
        //     when {
        //         expression { return env.CHANGE_ID != null }
        //     }
        //     steps {
        //         script {
        //             def prN = env.CHANGE_ID
        //             echo "Validado PR #${prN}..."
        //         }
        //     }
        // }
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
    // post {
    //     always {
    //         script {
    //             // Asegúrate de tener el plugin de ESLint instalado y configurado correctamente
    //             recordIssues tools: [eslint(pattern: 'eslint-report.json')]
    //         }
    //     }
    // }
}
