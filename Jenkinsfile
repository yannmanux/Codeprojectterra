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
             withAWS(credentials:'aws-credentials') {
            sh "aws iam list-users"  
            } 
           }
        } 
        stage ('check if terraform is installed') {
          steps{
            withAWS(credentials:'aws-credentials')
            sh "terraform --version"
            }  
        }
        stage ('run terraform init') {
            steps {
                withAWS(credentials:'aws-credentials')
                sh "terraform init"
            }
        }
         stage ('run terraform plan') {
        steps {
            withAWS(credentials:'aws-credentials')
            sh "terraform plan"
            }
        }
    }
   
}