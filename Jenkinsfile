pipeline {
    agent any
    stages {
        stage('Azure') {
            steps {
                script {
                    withCredentials([azureServicePrincipal(credentialsId: 'credentials_id', subscriptionIdVariable: 'AZURE_SUBSCRIPTION_ID', clientIdVariable: 'AZURE_CLIENT_ID', clientSecretVariable: 'AZURE_CLIENT_SECRET', tenantIdVariable: 'AZURE_TENANT_ID')]) {
                        sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
                }
                }
            }
        }
        stage('Checkout') {
            steps {
                git branch: 'dev', credentialsId: '581f41c0-594e-4cb6-80dd-c44cf5ea1393', url: 'https://github.com/AmitGujar/terraform-azure-svc'
            }
        }
        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=main.tfplan'
            }
        }
    }
}