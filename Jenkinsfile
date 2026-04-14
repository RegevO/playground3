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
        stage('Run Container') {
            steps {
                script {
                    // 1. Stop and remove any existing container with the same name to avoid conflicts
                    sh "docker rm -f ${IMAGE_NAME}-container || true"
                    
                    // 2. Run the new container
                    // -d: detached mode
                    // -p: mapping host port 8090 to container port 80 (change 80 to your app's port)
                    sh "docker run -d --name ${IMAGE_NAME}-container -p 8090:80 ${DOCKER_HUB_USER}/${IMAGE_NAME}:${TAG}"
                }
            }
        }
    }
}