#!groovy

pipeline {
    agent any
    options {
        timestamps()
    }

    stages {
        stage("scm") {
            checkout scm
        }
        stage('terraform') {
            sh returnStdout: true, script: 'terraform.sh'
        }
    }
}