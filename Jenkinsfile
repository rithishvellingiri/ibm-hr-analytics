pipeline {
    agent any

    triggers {
        pollSCM('* * * * *')
    }

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/rithishvellingiri/ibm-hr-analytics.git'
            }
        }

        stage('Lint') {
            steps {
                sh 'pip install flake8'
                sh 'flake8 . || true'
            }
        }

        stage('Unit Test') {
            steps {
                sh 'pip install pytest'
                sh 'pytest || true'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh '''
                    sonar-scanner \
                    -Dsonar.projectKey=hr-project \
                    -Dsonar.sources=. \
                    '''
                }
            }
        }
    }
}