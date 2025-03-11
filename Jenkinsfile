pipeline {
    agent any

    stages {
        stage('Deploy') {
            steps {
                retry(3) {
                    sh './src/flakey-deploy.sh'
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
            echo 'Unstable! This runs only if the build is unstable (e.g., some tests fail but not the entire pipeline)'
        }
        changed {
            echo 'Changed! This runs if the pipeline’s status changed from the last run'
        }
    }
}
