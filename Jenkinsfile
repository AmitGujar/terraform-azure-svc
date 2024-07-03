pipeline {
    agent any

    environment {
        TF_VERSION = '1.9.0'
    }

    stages {
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
                sh 'terraform --version'
            }
        }
    }
}
