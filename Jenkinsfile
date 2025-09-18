pipeline {
    agent any
    environment {
        AWS_REGION = 'eu-north-1'
        ECR_REGISTRY = '646578602604.dkr.ecr.eu-north-1.amazonaws.com'
        IMAGE_NAME = "${ECR_REGISTRY}/financial-microservice-app"
        GITOPS_REPO = 'git@github.com:davidbulke/financial-microservice-gitops.git'
    }
    stages {
        stage('Checkout Application Code') {
            steps {
                git(
                  url: 'git@github.com:davidbulke/financial-microservice-app.git',
                  credentialsId: 'git'
                )
            }
        }
        stage('Build and Push Docker Image') {
            steps {
                script {
                    sh '$(aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REGISTRY)'
                    sh 'docker build -t $IMAGE_NAME:$BUILD_NUMBER .'
                    sh 'docker push $IMAGE_NAME:$BUILD_NUMBER'
                }
            }
        }
        stage('Update GitOps Repo Image Tag') {
            steps {
                git(
                  url: "${GITOPS_REPO}",
                  credentialsId: 'git',
                  branch: 'main'
                )
                script {
                    // Use sed or similar to update deployment.yaml with $BUILD_NUMBER or latest
                    sh "sed -i 's|image: .*\$|image: ${IMAGE_NAME}:${BUILD_NUMBER}|' dev/deployment.yaml"
                    sh 'git config user.email "ci@example.com"'
                    sh 'git config user.name "ci-bot"'
                    sh 'git add dev/deployment.yaml'
                    sh 'git commit -m "Update image tag to $BUILD_NUMBER [ci skip]" || true'
                    sh 'git push origin main'
                }
            }
        }
    }
}
