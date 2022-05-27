pipeline {
  agent {label 'yehia'}
  stages {
    stage('git checkout') {
      steps {
        echo "Cloning the repo..."
        git(url: 'https://github.com/yehias21/GoViolin.git')
      }
    }
    stage('Docker Build') {
      steps {
        echo "Building docker image..."
        script{
          try{
            sh 'docker build -t yehias21/goviolin .'
          }
          catch(e) {
           echo "Docker Imaged failed to build!"
            throw e
          }
        }
      }
    }
    stage('Docker Push') {
      steps {
        echo "Pushing image to dockerHub"
        withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
          sh "docker login -u '${env.dockerHubUser}' -p '${env.dockerHubPassword}'"
          sh 'docker push yehias21/goviolin'
        }
      }
    }
      stage('Deploy to Kubernetes')
        {
            steps
            {
                script
                {
                    sh "kubectl apply -f ./deployment.yaml"
                }
            }
        }
  }
    post{
       success {
         echo "${env.BUILD_URL} has result success :)"
          }
       failure {
         echo "${env.BUILD_URL} has result fail :("
          }
       }
}
