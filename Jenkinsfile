pipeline {
   agent any
     stages {
        stage ('check if aws is installed') {
          steps {
            sh " aws --version"
          }
        }
        stage ('check acces to aws') {
           steps { 
             sh "aws iam list-users"
           }
        } 
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