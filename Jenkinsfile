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

        stage('Run Tests') {
            steps {
                echo 'Running Flutter tests...'
                sh 'flutter test'
            }
        }

        stage('Build APK') {
            steps {
                echo 'Building release APK...'
                sh 'flutter build apk --release'
            }
        }

        stage('Archive APK') {
            steps {
                echo 'Archiving APK artifact...'

                archiveArtifacts(
                    artifacts: 'build/app/outputs/flutter-apk/app-release.apk',
                    fingerprint: true
                )
            }
        }

    }

    post {

        success {
            echo 'Flutter CI pipeline completed successfully ✅'
        }

        failure {
            echo 'Flutter CI pipeline failed ❌'
        }

        always {
            echo 'Pipeline finished.'
        }
    }
}
