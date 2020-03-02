pipeline {
  environment {
    registry = "ankitmnn7/menzy_007"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/ankit-menon/Tomcat-deployment.git'
      }
    }
    stage('deployment') {
      steps{
          script{
                  def image_id = registry + ":$BUILD_NUMBER"
                  sh "ansible-playbook  playbook.yml --extra-vars \"image_id=${image_id}\""
               }
      }
  }
  }     
}
