pipeline {
    agent any
    tools {
        terraform 'terraform'
    }
    stages {
        stage('Checking Out') {
            steps {
                echo 'Pulling Repository'
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/jamesbarker15/ansible-minecraft.git']])
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform init'
                sh 'terraform apply -auto-approve'

                script {
                    EC2_PUBLIC_IP = sh(returnStdout: true, script: 'terraform output -raw ec2_public_ip').trim()
                    
                echo 'Waiting for 15 seconds for SSH to boot...'
                sleep time: 15, unit: 'SECONDS'
                echo 'Done waiting!'
                }
            }
        }
        stage('Ansible Configure Minecraft Server') {
            steps {
                script {
              
                    def ec2_public_ip = sh(script: "terraform output -raw ec2_public_ip", returnStdout: true).trim()

                    def ansibleHostsContent = "[aws]\naws-host ansible_host=${ec2_public_ip} ansible_user=ubuntu ansible_private_key_file=/var/jenkins_home/workspace/minecraft-server/minecraft ansible_ssh_common_args='-o StrictHostKeyChecking=accept-new'"

                    writeFile file: 'ansible_hosts', text: ansibleHostsContent

                    sh "ansible-playbook -i ansible_hosts minecraft-server.yaml"
                }
            }
        }
        stage('Send IP Via Email') {
            steps {
                script {
                    emailext (
                        body: "The public IP address is ${EC2_PUBLIC_IP}", 
                        subject: 'Minecraft Server Created Successfully.', 
                        to: "${EMAIL_ADDRESS}" )
                }
            }
        }
    }
}
