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

        GITHUB_REPO = 'ahmedrabe33/flutter-pipeline'
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

                    echo "===== GITHUB CLI ====="
                    gh --version
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
                echo 'Running static analysis...'
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

                sh '''
                    flutter build apk --release

                    echo "===== APK ====="
                    ls -lh build/app/outputs/flutter-apk/app-release.apk
                '''
            }
        }

        stage('Archive APK') {
            steps {
                echo 'Archiving APK in Jenkins...'

                archiveArtifacts(
                    artifacts: 'build/app/outputs/flutter-apk/app-release.apk',
                    fingerprint: true
                )
            }
        }

        stage('GitHub Release') {
            steps {

                withCredentials([
                    string(
                        credentialsId: 'github-token',
                        variable: 'GH_TOKEN'
                    )
                ]) {

                    sh '''
                        TAG="v1.0.${BUILD_NUMBER}"
                        APK="build/app/outputs/flutter-apk/app-release.apk"
                        COMMIT=$(git rev-parse HEAD)

                        echo "Creating GitHub Release..."
                        echo "Tag: $TAG"
                        echo "Commit: $COMMIT"

                        gh release create "$TAG" "$APK" \
                            --repo "$GITHUB_REPO" \
                            --target "$COMMIT" \
                            --title "Flutter App $TAG" \
                            --generate-notes
                    '''
                }
            }
        }

    }

    post {

        success {
            echo '================================='
            echo 'Flutter CI/CD Pipeline SUCCESS ✅'
            echo "Release version: v1.0.${BUILD_NUMBER}"
            echo '================================='
        }

        failure {
            echo 'Flutter CI/CD Pipeline FAILED ❌'
        }

        always {
            echo 'Pipeline finished.'
        }
    }
}
