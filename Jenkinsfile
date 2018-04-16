#!groovy

pipeline {
    agent any
    options {
        timestamps()
    }

    stages {
        stage('terraform') {
            steps {
                sh returnStdout: true, script: './terraform/terraform.sh'
            }
        }
    }
}