// pipeline {
//     agent any

//     stages {
//         stage('Checkout') {
//             steps {
//                 checkout([$class: 'GitSCM', branches: [[name: 'main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/vastevenson/pytest-intro-vs.git']]])
//             }
//         }
//         stage('Build') {
//             steps {
//                 git branch: 'main', url: 'https://github.com/vastevenson/pytest-intro-vs.git'
//                 sh 'python3 ops.py'
//             }
//         }
//         stage('Test') {
//             steps {
//                 sh 'python3 -m pytest'
//             }
//         }

//         // stage('Deploy') {
//         //     steps {
//         //         sh 'gcp terraform infrastructure building'
//         //     }
//         // }
//     }
// }


pipeline {
    agent any
    environment {
        CLOUDSDK_CORE_PROJECT='jovial-atlas-375801'
        CLIENT_EMAIL='jenkins-gcloud@jovial-atlas-375801.iam.gserviceaccount.com'
        GCLOUD_CREDS=credentials('gcloud-creds')
    }
    stages {
        stage('test') {
            steps {
                sh '''
                     gcloud version
                     gcloud auth activate-service-account --key-file="$GCLOUD_CREDS"
                     gcloud compute zones list
                    '''
                /*
                withCredentials([file(credentialsId: 'gcloud-creds', variable: 'GCLOUD_CREDS')]) {
                    // some block
                    sh '''
                     gcloud version
                     gcloud auth activate-service-account --key-file="$GCLOUD_CREDS"
                     gcloud compute zones list
                    '''
                }
                */
            }
        }
    }
    post {
        always {
            sh 'gcloud auth revoke $CLIENT_EMAIL'
        }
    }
}