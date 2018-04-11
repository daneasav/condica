#!groovy


pipeline {
    agent any

    stages {
        node ("docker") {
            timestamps {
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