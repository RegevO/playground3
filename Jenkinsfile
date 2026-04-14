pipeline {
    agent any
    
    // This makes DOCKER_HOST available to all stages automatically
    environment {
        DOCKER_HOST = 'tcp://host.docker.internal:2375'
        DOCKER_HUB_USER = 'regev987'
        IMAGE_NAME = 'test'
        TAG = '1.0'
    }

    stages {
        stage('Code Checkout') {
            steps {
                git url: 'https://github.com/RegevO/playground3.git', branch: 'main'
            }
        }

        stage('Check Docker Version') {
            steps {
                sh 'docker --version'
            }
        }
        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'Doker_hub_PAT', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                // Now you don't need to export anything!
                sh "docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:${TAG} ."
                sh "docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:${TAG}"
            }
        }
    }
}