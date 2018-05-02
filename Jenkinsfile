#!groovy

pipeline {
    agent any

    options {
        timestamps()
    }

    parameters {
        string(name: 'azure_resource_group', defaultValue: 'condik', description: 'Azure Resource Group')
        string(name: 'azure_cosmosdb_name', defaultValue: 'condik-db', description: 'Azure Cosmos DB name')
        string(name: 'azure_function_name', defaultValue: 'condik-record-entry', description: 'Azure Function Name')
        string(name: 'git_branch', defaultValue: 'master', description: 'The function GIT branch to deploy')
    }

    environment {
        // azure credentials
        azure_subscription_id = credentials('azure_subscription_id')
        azure_client_id       = credentials('azure_client_id')
        azure_client_secret   = credentials('azure_client_secret')
        azure_tenant_id       = credentials('azure_tenant_id')

        // git credentials
        git_repo_url          = credentials('git_repo_url')
        git_token             = credentials('git_token')
    }

    stages {
        // this step is needed as the project clones the repo (for the Jenkins file only) on master and not in the build workspace/slaves
        stage('scm') {
            steps {
                checkout scm
            }
        }
        stage('terraform') {
            steps {
                echo "teraform"
                script {
                    sh "./terraform/terraform.sh ${params.azure_resource_group} ${azure_function_name}"
                }
            }
        }
        stage('azure deployment') {
            steps {
                script {
                    sh "./azure/azure.sh ${params.azure_resource_group} ${params.azure_function_name} ${params.git_branch}"
                }
            }
        }
        stage('cosmos db') {
            steps {
                script {
                    sh "./cosmosdb/cosmosdb.sh ${params.azure_resource_group} ${params.azure_cosmosdb_name} ${params.azure_function_name}"
                }
            }
        }
    }
}