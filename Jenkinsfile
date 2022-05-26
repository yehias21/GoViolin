pipeline {
    agent any
    stages {
        stage('build using dockerfile') {
            steps {
                echo 'Building the application...'
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
