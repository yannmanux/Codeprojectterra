pipeline {
   agent any
     stages {
        stage ('check if terraform is installed') {
          steps{
            sh "terraform --version"
            }  
        }
        stage ('run terraform init') {
            steps {
                sh "terraform init"
            }
        }
         stage ('run terraform plan') {
        steps {
            sh "terraform plan"
            }
        }
    }
   
}