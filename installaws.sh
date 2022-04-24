#!/bin/bash
apt install awscli dialog -y
mkdir ~/.aws/
echo "[default]" > ~/.aws/config
echo "region = ap-southeast-1" >> ~/.aws/config
echo "[default]"  > ~/.aws/credentials
echo 'aws_access_key_id='$AWS_ACCESS_KEY_ID >> ~/.aws/credentials
echo 'aws_secret_access_key='$AWS_SECRET_ACCESS_KEY >> ~/.aws/credentials
read -p "Enter ARN: " ARN
aws sagemaker create-notebook-instance --notebook-instance-name learn1 --instance-type ml.p3.2xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1
