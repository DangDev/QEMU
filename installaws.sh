#!/bin/bash
apt update
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
read -p "Enter ARN: " ARN
mkdir ~/.aws/
echo "[default]" > ~/.aws/config
echo "region = us-east-1" >> ~/.aws/config
echo "[default]"  > ~/.aws/credentials
echo 'aws_access_key_id='$AWS_ACCESS_KEY_ID >> ~/.aws/credentials
echo 'aws_secret_access_key='$AWS_SECRET_ACCESS_KEY >> ~/.aws/credentials
aws configure set default.region us-east-2
aws sagemaker create-notebook-instance --notebook-instance-name learn1 --instance-type ml.t2.medium --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1
