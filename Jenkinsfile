#!groovy

timestamps {
    pipeline {
        agent any

        stages {
            node ("docker") {
                stage("scm") {
                    checkout scm
                }
                stage('terraform') {
                    sh returnStdout: true, script: 'terraform.sh'
                }
            } 
        }
    }
}