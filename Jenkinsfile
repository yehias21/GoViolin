pipeline {
  agent any
  stages {
    stage('Docker Build') {
      agent any
      steps {
        sh 'docker build -t yehias21/goviolan'
      }
    }
    stage('Docker Push') {
      agent any
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
          sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
          sh 'docker push yehias21/goviolan'
        }
      }
    }
  }
    post{
        failure{
            mail to: 'yehia.salah.ms@alexu.edu.eg',
             subject:"The ${currentBuild.fullDisplayName} pipeline has failed:(",
             body: "Error can be found in: ${env.BUILD_URL}"
        }
    }
}
