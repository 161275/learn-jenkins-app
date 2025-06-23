pipeline {
    agent any

    stages {
        stage('w/o Docker') {
            steps {
                echo 'w/o Docker...'
                sh '''
                   ls -la
                   touch container-no.txt
                '''
            }
        }
        stage('with Docker') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                echo 'with Docker...'
                sh '''
                   ls -la
                   touch container-yes.txt
                '''
                sh 'npm --version'
            }
        }
    }
}
