pipeline {
    agent any

    environment {
        TF_VERSION = '1.9.0'
    }

    stages {
        stage('Azure') {
            steps {
                script {
                    withCredentials([azureServicePrincipal(credentialsId: 'a42e24d7-6a93-4112-b60a-cdd2476f0ca1', subscriptionIdVariable: 'AZURE_SUBSCRIPTION_ID', clientIdVariable: 'AZURE_CLIENT_ID', clientSecretVariable: 'AZURE_CLIENT_SECRET', tenantIdVariable: 'AZURE_TENANT_ID')]) {
                        sh 'echo hello world'
                    }
                }
            }
        }
        stage('Setup') {
            steps {
                script {
                    // Assuming 'terraform' is the name of the Terraform tool configured in Jenkins
                    env.PATH = "${tool 'terraform'}/bin:" +
                               "${env.PATH}"
                    /* groovylint-disable-next-line LineLength */
                    env.PATH = "/home/jenkins/agent/tools/org.jenkinsci.plugins.terraform.TerraformInstallation/terraform:${env.PATH}"
                }
            }
        }
        stage('Init') {
            steps {
                sh 'terraform init --upgrade'
            }
        }
        stage('Validate') {
            steps {
                sh 'terraform validate'
            }
        }
        stage('Plan') {
            withCredentials([file(credentialsId: 'ad9d92b4-cc86-4fce-b4f6-132b082e6179', variable: 'secretFile')]) {
                // do something with the file, for instance
                steps {
                    sh 'terraform plan -out main.tfplan -var-file=$secretFile'
                }
            }
        }
    }
}
