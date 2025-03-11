pipeline {
agent {
        docker { image 'python:3.8' }  // Use Python Docker image
    }
    stages {
        stage('Setup') {
            steps {
                echo "Installing dependencies..."
                sh 'pip install --user -r requirements.txt'
            }
        }

        stage('Run Tests') {
            steps {
                echo "Running tests..."
                sh 'pytest tests/test_sample.py --junitxml=test-results.xml'
            }
        }

        stage('Publish Test Results') {
            steps {
                echo "Publishing test results..."
                catchError(buildResult: 'SUCCESS', stageResult: 'UNSTABLE') {
                    junit 'test-results.xml'
                }
            }
        }

        stage('Archive Artifacts') {
            steps {
                echo "Archiving logs and test reports..."
                archiveArtifacts artifacts: 'logs/test.log, reports/report.html', fingerprint: true
            }
        }
    }

    post {
        always {
            echo "Pipeline execution complete!"
        }
        success {
            echo "SUCCESS: Tests executed, results published, and artifacts stored!"
        }
        unstable {
            echo "Some tests failed, but results and artifacts are available."
        }
    }
}
