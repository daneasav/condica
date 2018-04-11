#!groovy

timestamps{
    node {
        stage("scm") {
            checkout scm
        }

        stage('terraform') {
            sh returnStdout: true, script: 'terrafor.sh'
        }
    }
}