pipeline {
    agent any

    environment {
        DEPLOY_ENV = 'staging'
        APP_NAME = 'BookTableApp'
    }

    stages {
        stage('Set Permissions') {
            steps {
                sh 'chmod +x src/flakey-deploy.sh src/health-check.sh'
            }
        }

        stage('Deploy') {
            steps {
                script {
                    def status = retry(3) {
                        return sh(script: './src/flakey-deploy.sh', returnStatus: true)
                    }
                    if (status != 0) {
                        echo "Deployment failed after 3 attempts, but continuing..."
                    } else {
                        echo "Successfully deployed to ${DEPLOY_ENV}!"
                    }
                }

                timeout(time: 3, unit: 'MINUTES') {
                    sh './src/health-check.sh'
                }
            }
        }

        stage('Run Tests') {
            steps {
                sh 'pytest --junitxml=results.xml'
            }
        }

        stage('Publish Test Results') {
            steps {
                junit 'results.xml'
            }
        }

        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: 'logs/*.log', fingerprint: true
            }
        }
    }

    post {
        always {
            echo "Pipeline complete for ${APP_NAME} in ${DEPLOY_ENV}."
        }
        success {
            echo "SUCCESS: Everything ran fine!"
        }
        failure {
            echo "FAILURE: Something went wrong!"
        }
    }
}


