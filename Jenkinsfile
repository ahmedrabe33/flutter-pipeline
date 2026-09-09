pipeline {

    agent {
        label 'flutter'
    }

    options {
        skipDefaultCheckout(true)
    }

    environment {
        FLUTTER_HOME = '/opt/flutter'
        ANDROID_HOME = '/opt/android-sdk'
        ANDROID_SDK_ROOT = '/opt/android-sdk'
        JAVA_HOME = '/usr/lib/jvm/java-17-openjdk-amd64'

        PATH = "${JAVA_HOME}/bin:${FLUTTER_HOME}/bin:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools:${env.PATH}"
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                checkout scm
            }
        }

        stage('Check Environment') {
            steps {
                sh '''
                    whoami
                    java -version
                    flutter --version
                    echo "ANDROID_HOME=$ANDROID_HOME"
                    git --version
                '''
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing Flutter dependencies...'
                sh 'flutter pub get'
            }
        }

        stage('Analyze Code') {
            steps {
                echo 'Running Flutter static analysis...'
                sh 'flutter analyze'
            }
        }

    }

    post {
        success {
            echo 'Step 3 completed successfully ✅'
        }

        failure {
            echo 'Pipeline failed ❌'
        }
    }
}
