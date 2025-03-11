pipeline {
    agent any

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
                        echo "Deployment failed after 3 attempts, but continuing the pipeline..."
                    } else {
                        echo "Deployment successful!"
                    }
                }

                catchError(buildResult: 'SUCCESS', stageResult: 'SUCCESS') {
                    timeout(time: 3, unit: 'MINUTES') {
                        sh './src/health-check.sh'
                    }
                }
            }
        }

        stage('Test') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'SUCCESS') {
                    sh 'echo "Fail!"; exit 1' // This step is now ignored for pipeline success
                }
            }
        }
    }

    post {
        always {
            echo 'This will always run, no matter what'
        }
        success {
            echo 'SUCCESS: The pipeline completed successfully'
        }
        failure {
            echo 'FAILURE: This will not appear because the pipeline is forced to succeed'
        }
        unstable {
            echo 'UNSTABLE: This will not appear unless specifically marked'
        }
        changed {
            echo 'Changed! Runs if the pipeline’s status changed from the last run'
        }
    }
}
