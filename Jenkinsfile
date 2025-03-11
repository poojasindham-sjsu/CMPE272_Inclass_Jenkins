pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/poojasindham-sjsu/CMPE272_Inclass_Jenkins.git'
            }
        }

        stage('Deploy to AWS') {
            steps {
                script {
                    sshagent(['aws-ssh-key']) {
                        sh '''
                        echo "Deploying HTML to AWS..."

                        scp -o StrictHostKeyChecking=no index.html ubuntu@http://3.145.75.19:/var/www/html/

                        echo "Deployment Completed!"
                        '''
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Deployment successful!"
        }
        failure {
            echo "Deployment failed!"
        }
    }
}
