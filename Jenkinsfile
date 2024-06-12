pipeline{
    agent any

    stagets{
        stage('docker build'){
            steps {
                script {
                    sh "docker build -f gifs/dockerfile -t arlexbeltran/gifs:1.0.0-${BUILD_ID} gifs"
                }
            }
        }
        stage('docker push'){
            steps {
                script {
                    sh "docker push arlexbeltran/gifs:1.0.0-${BUILD_ID}"
                }
            }
        }
    }
}