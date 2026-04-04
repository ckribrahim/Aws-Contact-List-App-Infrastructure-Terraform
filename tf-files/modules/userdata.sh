#!/bin/bash
yum update -y
yum install python3 -y
yum install python3-devel -y
yum install gcc -y
yum install git -y
pip3 install flask
pip3 install flask_mysql
pip3 install pymysql
pip3 install cryptography
cd /home/ec2-user
USER=${user-data-git-name}
git clone https://github.com/$USER/Aws-Contact-List-App-Infrastructure-Terraform.git
cd Aws-Contact-List-App-Infrastructure-Terraform
python3 contact-list-app.py
python3 contact-list-app.py

