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
    stage('Building image') {
      steps{
        script {
          def dockerHome = tool 'myDocker'
          env.PATH = "${dockerHome}/bin:${env.PATH}"
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
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
