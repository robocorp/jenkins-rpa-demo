pipeline {
    agent {
        docker { image 'ubuntu:18.04' }
    }
    options {
        timestamps()
    }
    stages {
        stage('Setup environment') {
            steps {
                sh "./install_rcc.sh"
            }
        }
        stage('Run Robot Tasks') {
            steps {
                ws("${env.WORKSPACE}/example-activities") {
                    git branch: "master", poll: false, url: "https://github.com/robocorp/example-activities.git"
                    sh """
                    cd google-image-search
                    rcc conda check --install
                    rcc task run -r robot.yaml
                    """
                }
            }
            post {
                always {
                    robot passThreshold: 100.0, outputPath: "example-activities/google-image-search/output", otherFiles: '**/*.png'
                }
            }
        }
    }
}