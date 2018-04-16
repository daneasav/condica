#!groovy

pipeline {
    agent any
    options {
        timestamps()
    }

    stages {
        // this step is needed as the project clones the repo on master and not in the build workspace
        stage('scm') {
            steps {
                checkout scm
            }
        }
        stage('terraform') {
            steps {
                sh returnStdout: true, script: './terraform/terraform.sh'
            }
        }
    }
}