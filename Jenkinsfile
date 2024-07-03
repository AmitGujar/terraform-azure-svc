pipeline {
    agent any

    environment {
        STORAGE_ACCOUNT_NAME = 'tfstorageisgreat82'
        ACCESS_KEY = credentials('2')
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
                    // Assuming 'terraform' is the name of the Terraform tool configured in Jenkins
                    env.PATH = "${tool 'terraform'}/bin:" +
                               "${env.PATH}"
                    /* groovylint-disable-next-line LineLength */
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
                withCredentials([file(credentialsId: '1', variable: 'secretFile')]) {
                    // do something with the file, for instance
                    sh 'terraform plan -out main.tfplan -var-file=$secretFile'
                }
            }
        }
        stage('Deployment') {
            steps {
                sh 'terraform apply main.tfplan'
            }
        }
        stage('Destroy') {
            steps {
                sh 'terraform destroy -var-file=$secretFile'
            }
        }
    }
}
