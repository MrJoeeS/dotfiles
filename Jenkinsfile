pipeline {
    agent any
 
    stages {
        stage('Setup') {
            steps {
                echo 'Setting up environment...'
            }
        }
 
        stage('Build') {
            steps {
                echo 'Building project...'
            }
        }
 
        stage('Test') {
            steps {
                echo 'Running tests...'
            }
        }
 
        stage('Deploy') {
            steps {
                echo 'Deploying application...'
            }
        }
 
        stage('Sleep') {
            steps {
                echo 'Sleeping for 5 seconds...'
                sleep 5
            }
        }
    }
}
