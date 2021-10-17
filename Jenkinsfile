pipeline {
	agent none
	stages {
		stage ('Build docker image webapp & push nexus') {
			agent {
				docker {
					args '-v /var/run/docker.sock:/var/run/docker.sock -u root'
					image 'build'
					registryCredentialsId '642e0ecf-859e-4a08-bc5a-c56e1cc89ac8'
					registryUrl 'http://89.208.222.153:8123'
				}
			}
			steps {
				sh 'git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git /home/app'
				sh 'mvn package -f /home/app'
				sh 'docker build /home --tag="89.208.222.153:8123/webapp"'
				sh 'docker push 89.208.222.153:8123/webapp'
			}
		}
		stage ('ssh connect & docker run') {
			agent any
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