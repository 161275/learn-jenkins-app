pipeline {
    agent any
    environment {
        NETLIFY_SITE_ID = '6e92f3a3-0f41-4fd1-b86f-4a04c91b8aba'
        NETLIFY_AUTH_TOKEN = credentials('netlify-token')
        REACT_APP_VERSION = "1.2.$BUILD_ID"
        AWS_DEFAULT_REGION = "ap-south-1"
        AWS_ECS_CLUSTER = "learn-jenkins-app-prod"
        AWS_ECS_SERVICE_PROD = "jenkins-app-prod-service-yuctno1d"
    }

    stages {
        
        // stage('Build') {
        //     agent {
        //         docker {
        //         image 'my-playwright'
        //         reuseNode true
        //         }
        //     }
        //     steps {
        //         sh '''
        //         ls -la
        //         node --version
        //         npm --version
        //         npm ci
        //         npm test
        //         npm run build
        //         ls -la
        //         '''
        //     }
        // }
        // stage('Local build Test'){
        //     agent {
        //         docker {
        //             image 'my-playwright'
        //             reuseNode true
        //         }
        //     }
        //     steps {
        //         sh '''
        //         test -f build/index.html
        //         npm test
        //         serve -S build &
        //         sleep 10
        //         npx playwright test --reporter=html
        //         '''
        //     }
        //     post {
        //         always {
        //             junit 'jest-results/junit.xml'
        //             publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, icon: '', keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'HTML Report Local', reportTitles: '', useWrapperFileDirectly: true])
                
        //         }
        //     }
        // }
        stage ('dockerimage') {
            steps {
                sh 'docker build -t my-jenkinsapp .'
            }
        }
        stage ('aws deploy'){
            agent {
                docker {
                    image 'amazon/aws-cli'
                    args '-u root --entrypoint=""'
                    reuseNode true
                }
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'my-aws', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                    sh '''
                        aws --version
                        yum install jq -y
                        # aws s3 cp build/index.html s3://jekins-test/index.html
                        #aws s3 sync build s3://jekins-test
                        #aws s3 ls
                        aws ecs register-task-definition --cli-input-json file://AWS/task-def.json > task-def-new.json
                        #task_version = $(jq -r '.taskDefinition.revision' task-def-new.json)
                        aws ecs update-service --cluster $AWS_ECS_CLUSTER --service $AWS_ECS_SERVICE_PROD --task-definition jenkins-app-prod:$(jq -r '.taskDefinition.revision' task-def-new.json)
                        aws ecs wait services-stable --cluster $AWS_ECS_CLUSTER --service $AWS_ECS_SERVICE_PROD
                    '''
                }
            }
        }
        // stage('deploy stage'){
        //     agent {
        //         docker {
        //             image 'my-playwright'
        //             reuseNode true
        //         }
        //     }
        //     environment {
        //         CI_ENVIRONMENT_URL = "to_be_set"
        //     }
        //     steps {
        //         sh '''
        //         netlify --version 
        //         netlify status
        //         netlify deploy --dir=build --json > deploy_stage.json
        //         CI_ENVIRONMENT_URL=$(jq -r '.deploy_url' deploy_stage.json)
        //         npx playwright test --reporter=html
        //         '''
        //     }
        //     post {
        //         always {
        //             publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, icon: '', keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'HTML Report staging', reportTitles: '', useWrapperFileDirectly: true])
        //         }
        //     }
        // }
        // // stage('Approval') {
        // //     steps {
        // //         timeout(time: 1, unit: 'MINUTES') {
        // //             input 'ready to deploy?'
        // //         }
                
        // //     }
        // // }
        // stage('Prod Deploy'){
        //     agent {
        //         docker {
        //             image 'my-playwright'
        //             reuseNode true
        //         }
        //     }
        //     environment {
        //         CI_ENVIRONMENT_URL = 'https://dulcet-cheesecake-60d93a.netlify.app'
        //     }
        //     steps {
        //         sh '''
        //         netlify --version
        //         netlify status
        //         netlify deploy --dir=build --prod
        //         npx playwright test --reporter=html
        //         '''
        //     }
        //     post {
        //         always {
        //             publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, icon: '', keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'HTML Report Prod', reportTitles: '', useWrapperFileDirectly: true])
        //         }
        //     }
        // }


    }
}