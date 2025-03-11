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
                    def success = false
                    retry(3) {
                        try {
                            sh './src/flakey-deploy.sh'
                            success = true
                        } catch (Exception e) {
                            echo "Deployment failed! Retrying..."
                        }
                    }
                    if (!success) {
                        echo "❌ Deployment failed after 3 attempts. Continuing pipeline..."
                    }
                }

                timeout(time: 3, unit: 'MINUTES') {
                    sh './src/health-check.sh'
                }
            }
        }

        stage('Test') {
            steps {
                sh 'echo "Fail!"; exit 1' // This will fail intentionally
            }
        }
    }

    post {
        always {
            echo 'This will always run, no matter what'
        }
        success {
            echo 'Success! This runs only if the pipeline succeeds'
        }
        failure {
            echo 'Failure! This runs only if the pipeline fails'
        }
        unstable {
            echo 'Unstable! This runs only if the build is unstable'
        }
        changed {
            echo 'Changed! Runs if the pipeline’s status changed from the last run'
        }
    }
}
