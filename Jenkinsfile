pipeline{

  agent {label 'linux'}
  
  triggers {
    pollSCM('*/2 * * * *')
  }

  stages {
      
      stage('gitclone') {

      steps {
        git 'https://github.com/mach1el/docker-rtpproxy.git'
      }
    }

    stage('Build') {

      steps {
        sh 'docker build -t mich43l/rtpproxy:latest .'
      }
    }

    stage('Login') {
      steps {
        withCredentials([
          usernamePassword(
            credentialsId: 'dockerhub', 
            usernameVariable: 'USER', 
            passwordVariable: 'PASS'
            )]) {
          sh '''
          docker login -u ${USER} -p ${PASS}
          '''
        }
      }
    }

    stage('Push') {

      steps {
        sh 'docker push mich43l/rtpproxy:latest'
      }
    }

    stage('Clean') {

      steps {
        sh 'docker rmi mich43l/rtpproxy:latest'
      }
    }
  }

  post {
    always {
      sh 'docker logout'
    }
  }

}