#!groovy

pipeline {
    agent any
    options {
        timestamps()
        ansiColor('xterm')
    }

    stages {
        stage("scm") {
            steps {
                checkout scm
            }
        }
        stage('terraform') {
            steps {
                sh returnStdout: true, script: './terraform.sh'
            }
        }
    }
}