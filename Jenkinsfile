#!groovy

pipeline {
    agent any

    options {
        timestamps()
    }

    parameters {
        string(name: 'azure_resource_group', defaultValue: 'condik', description: 'Azure Resource Group')
        string(name: 'git_branch', defaultValue: 'master', description: 'The function GIT branch to deploy')
    }

    environment {
        // azure credentials
        azure_subscription_id = credentials('azure_subscription_id')
        azure_client_id       = credentials('azure_client_id')
        azure_client_secret   = credentials('azure_client_secret')
        azure_tenant_id       = credentials('azure_tenant_id')

        // git credentials
        git_url               = credentials('git_url')
        git_token             = credentials('git_token')
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
                    sh "./terraform/terraform.sh ${params.azure_resource_group}"
                }
            }
        }
        stage('azure deployment') {
            steps {
                script {
                    sh "./azure/azure.sh ${params.azure_resource_group} ${params.git_branch}"
                }
            }
        }
    }
}