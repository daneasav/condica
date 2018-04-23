#!groovy

pipeline {
    agent any

    options {
        timestamps()
    }

    environment {
        azure_subscription_id = credentials('azure_subscription_id')
        azure_client_id       = credentials('azure_client_id')
        azure_client_secret   = credentials('azure_client_secret')
        azure_tenant_id       = credentials('azure_tenant_id')
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
                script {
                    sh './terraform/terraform.sh'
                }
            }
        }
    }
}