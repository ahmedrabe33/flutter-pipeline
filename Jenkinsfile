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

        // Flutter/Gradle build uses Java 17
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
                    echo "===== USER ====="
                    whoami

                    echo "===== HOST ====="
                    hostname

                    echo "===== JAVA ====="
                    java -version

                    echo "===== FLUTTER ====="
                    flutter --version

                    echo "===== ANDROID SDK ====="
                    echo "ANDROID_HOME=$ANDROID_HOME"
                    echo "ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT"

                    echo "===== GIT ====="
                    git --version
                '''
            }
        }

    }

    post {

        success {
            echo 'Step 1 completed successfully ✅'
        }

        failure {
            echo 'Step 1 failed ❌'
        }

        always {
            echo 'Pipeline finished.'
        }
    }
}
