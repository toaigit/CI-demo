#!/bin/bash
#  this script will run terraform on the gitlab-runner and create a servlet EC2...
 
echo "PWD:  $PWD"
mkdir tmp
cd tmp

# download the servlet terraform to create servlet EC2 instance
git config --global http.sslverify false
git clone https://github.com/toaigit/servlet.git
cd servlet

echo "DEBUG: Current Directory:  $PWD"
ls -ltr

export AWS_DEFAULT_REGION=us-west-2

echo "DEBUG: Run terraform init ..."
terraform init

echo "DEBUG: Run terraform apply to create EC2 instance ..."
terraform apply --auto-approve
