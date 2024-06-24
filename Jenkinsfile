pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = "https://index.docker.io/"
        DOCKERHUB_CREDENTIALS = 'test'
        DOCKER_CRED = credentials('test')
        DOCKER_IMAGE_NAME = "mkrishnavenkat/examplerepo"
    }
    stages {
        stage('build') {
            steps {
                sh'''
                    echo $DOCKER_CRED_PSW | docker login -u $DOCKER_CRED_USR --password-stdin
                    docker build -t "$DOCKER_IMAGE_NAME:latest" .
                    docker images
                    docker push "$DOCKER_IMAGE_NAME:latest"
                '''
            }
        }
        stage('analyze') {
            steps {
                
                sh '''
                   echo "docker.io/$DOCKER_IMAGE_NAME:latest `pwd`/Dockerfile" > anchore_images
                   cat anchore_images
                '''
                //bailOnFail: false - instead of failing just move forward with next steps.
                anchore name: 'anchore_images', forceAnalyze: true
            }
        }
        stage('Test') {
            steps {
                sh'''
                    echo "Testing Phase"
                '''
            }
        }
        stage('teardown') {
            steps {
                sh'''
                    for i in `cat anchore_images | awk '{print $1}'`;do docker rmi $i; done
                '''
            }
        }
    }
}
