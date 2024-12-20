pipeline {
    agent any
    environment {
         KUBE_CONFIG_PATH = "/var/lib/jenkins/.kube/config"
        SCANNER_HOME = tool 'sonar-scanner'
    }
    stages {
        stage('clean workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Checkout from Git') {
            steps {
                git branch: 'Obed-patch', url: 'https://github.com/obedfavour01/weather-app.git'
            }
        }
        stage("Sonarqube Analysis") {
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh '''$SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=weather-app \
                    -Dsonar.projectKey=weather-app'''
                }
            }
        }
       
        stage('OWASP FS SCAN') {
            steps {
                dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit', odcInstallation: 'OWASP DP-Check'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        stage('TRIVY FS SCAN') {
            steps {
                script {
                    try {
                        sh "trivy fs . > trivyfs.txt" 
                    }catch(Exception e){
                        input(message: "Are you sure to proceed?", ok: "Proceed")
                    }
                }
            }
        }
        stage("Docker Build Image"){
            steps{
                   
                sh "docker build -t weather-app ."
            }
        }
        stage("TRIVY"){
            steps{
                sh "trivy image weather-app > trivyimage.txt"
                script{
                    input(message: "Are you sure to proceed?", ok: "Proceed")
                }
            }
        }
        stage("Docker Push"){
            steps{
                script {
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker'){   
                    sh "docker tag weather-app obedfavour01/weather-app:latest "
                    sh "docker push obedfavour01/weather-app:latest"
                    }
                }
            }
        }
        
        
        stage('Pull Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                        sh "docker pull obedfavour01/weather-app:latest"
                    }
                }   
            }
        }
        stage('Deploy to EKS') {
            steps {
                echo "Deploying to EKS cluster"
                 sh """
                kubectl set image deployment/weather-app-deployment weather-app-container=obedfavour01/weather-app:latest --kubeconfig=${KUBE_CONFIG_PATH}
                kubectl rollout status deployment/weather-app-deployment --kubeconfig=${KUBE_CONFIG_PATH}
             """                 
            }
        }
    }
}