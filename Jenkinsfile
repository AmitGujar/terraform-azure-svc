pipeline {
    agent any

    environment {
        STORAGE_ACCOUNT_NAME = 'tfstorageisgreat82'
        ACCESS_KEY = credentials('2')
        SECRET_FILE = credentials('1')
    }

    stages {
        // stage('Azure') {
        //     steps {
        //         script {
        //             withCredentials([azureServicePrincipal(credentialsId: 'a42e24d7-6a93-4112-b60a-cdd2476f0ca1', subscriptionIdVariable: 'AZURE_SUBSCRIPTION_ID', clientIdVariable: 'AZURE_CLIENT_ID', clientSecretVariable: 'AZURE_CLIENT_SECRET', tenantIdVariable: 'AZURE_TENANT_ID')]) {
        //                 sh 'echo hello world'
        //                 sh 'echo $AZURE_SUBSCRIPTION_ID'
        //             }
        //         }
        //     }
        // }
        stage('Setup') {
            steps {
                script {
                    env.PATH = "${tool 'terraform'}/bin:" +
                               "${env.PATH}"
                    env.PATH = "/home/jenkins/agent/tools/org.jenkinsci.plugins.terraform.TerraformInstallation/terraform:${env.PATH}"
                    sh '''
                    sed -i 's|__STORAGE_ACCOUNT_NAME__|'${STORAGE_ACCOUNT_NAME}'|g' providers.tf
                    sed -i 's|__ACCESS_KEY__|'${ACCESS_KEY}'|g' providers.tf
                    '''
                }
            }
        }
        stage('Init') {
            steps {
                sh 'terraform init --upgrade'
                sh 'terraform validate'
            }
        }
        stage('Plan') {
            steps {
                    sh 'terraform plan -out main.tfplan -var-file=$SECRET_FILE'
            }
        }
        stage('Deployment') {
            steps {
                sh 'terraform apply main.tfplan'
            }
        }
        stage('Destroy') {
            steps {
                sh 'terraform destroy --auto-approve -var-file=$SECRET_FILE'
            }
        }
    }
}
