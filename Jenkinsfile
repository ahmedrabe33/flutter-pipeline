pipeline {
    agent {
        label 'flutter'
    }

    stages {
        stage('Check Agent') {
            steps {
                sh 'whoami'
                sh 'java -version'
                sh '/opt/flutter/bin/flutter --version'
                sh 'echo $ANDROID_HOME'
                sh 'echo $ANDROID_SDK_ROOT'
            }
        }
    }
}
