#!/usr/bin/env bash


echo "Install AWS CLI, git, docker"
sudo yum update -y
sudo yum install wget unzip -y
sleep 5

echo "Installing AWS CLI v2"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo  ./aws/install -i /usr/local/aws-cli -b /usr/local/bin


sudo amazon-linux-extras install -y docker
systemctl enable docker
systemctl start docker
sudo usermod -aG docker ec2-user
sudo chkconfig docker on

docker --version


echo "Install SSM-Agent"
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent


echo "Install Terraform"
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_amd64.zip
unzip terraform_${TERRAFORM_VER}_linux_amd64.zip
mv terraform /usr/local/bin/
terraform version


sleep 10

echo "SUCCESS! Installation succeeded!"
