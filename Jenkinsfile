pipeline {
    agent any

    environment {
        PATH = "/var/lib/jenkins/.local/bin:/opt/sonar-scanner/bin:${env.PATH}"
    }

    triggers {
        pollSCM('* * * * *')
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/rithishvellingiri/ibm-hr-analytics.git'
            }
        }

        stage('Lint') {
            steps {
                sh 'pip install flake8 --break-system-packages'
                sh 'flake8 . || true'
            }
        }

        stage('Unit Test') {
            steps {
                sh 'pip install pytest --break-system-packages'
                sh 'pytest || true'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh '''
                    /opt/sonar-scanner/bin/sonar-scanner \
                    -Dsonar.projectKey=hr-project \
                    -Dsonar.sources=.
                    '''
                }
            }
        }
    }
}
