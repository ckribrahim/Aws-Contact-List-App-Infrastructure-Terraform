#! /bin/bash
yum update -y
yum install python3 -y
pip3 install flask
pip3 install flask_mysql
pip3 install cryptography
yum install git -y
cd /home/ec2-user
USER=${user-data-git-name}
git clone https://github.com/$USER/Aws-Contact-List-App-Infrastructure-Terraform.git
cd Aws-Contact-List-App-Infrastructure-Terraform
python3 contact-list-app.py
