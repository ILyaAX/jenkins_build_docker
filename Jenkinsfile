pipeline {
	agent {
		docker {
		args '-v /var/run/docker.sock:/var/run/docker.sock -u root'
		image 'build'
		registryCredentialsId '642e0ecf-859e-4a08-bc5a-c56e1cc89ac8'
		registryUrl 'http://89.208.222.153:8123'
		}
	}
		stages {
			stage ('Copy source from github') {
				steps {
					sh 'git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git /home/app'
				}
			}
			stage ('Build webapp') {
				steps {
					sh 'mvn package -f /home/app'
				}
			}
			stage ('Build docker-image with webapp') {
				steps {
					sh 'docker build /home --tag="89.208.222.153:8123/webapp"'
				}
			}
			stage ('Push image') {
				steps {
					sh 'docker push 89.208.222.153:8123/webapp'
				}
			}
		}
	agent any
		stages {
			stage ('ssh connect & docker run') {
				steps {
					sh 'scp /var/lib/jenkins/workspace/jenkins_build_docker/docker-compose.yml jenkins@89.208.229.53:/home/jenkins/'
					sh '''ssh jenkins@89.208.229.53 << EOF
					cd /home/jenkins/
					docker-compose up -d
					EOF'''
				}
			}
		}
}