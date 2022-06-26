#!/bin/bash
yum update
yum install unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
clear
echo "https://us-east-1.console.aws.amazon.com/iamv2/home#/roles/create?step=selectEntities"
echo $AWS_ACCOUNT_ID
echo $AWS_ACCOUNT_USERNAME
echo $AWS_ACCOUNT_PASSWORD
echo "Login and create ARN"
read -p "Enter ARN: " ARN
mkdir ~/.aws/
echo "[default]" > ~/.aws/config
echo "region = us-east-1" >> ~/.aws/config
echo "[default]"  > ~/.aws/credentials
echo 'aws_access_key_id='$AWS_ACCESS_KEY_ID >> ~/.aws/credentials
echo 'aws_secret_access_key='$AWS_SECRET_ACCESS_KEY >> ~/.aws/credentials
aws sagemaker create-notebook-instance --notebook-instance-name learn1 --instance-type ml.p3.2xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker create-notebook-instance --notebook-instance-name learn2 --instance-type ml.g4dn.xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker describe-notebook-instance --notebook-instance-name learn1 | jq -r '.Url' > haidang.txt
aws sagemaker describe-notebook-instance --notebook-instance-name learn2 | jq -r '.Url' >> haidang.txt
aws configure set default.region us-east-2
aws sagemaker create-notebook-instance --notebook-instance-name learn1 --instance-type ml.p3.2xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker create-notebook-instance --notebook-instance-name learn2 --instance-type ml.g4dn.xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker describe-notebook-instance --notebook-instance-name learn1 | jq -r '.Url' >> haidang.txt
aws sagemaker describe-notebook-instance --notebook-instance-name learn2 | jq -r '.Url' >> haidang.txt
aws configure set default.region us-west-1
aws sagemaker create-notebook-instance --notebook-instance-name learn1 --instance-type ml.p3.2xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker create-notebook-instance --notebook-instance-name learn2 --instance-type ml.g4dn.xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker describe-notebook-instance --notebook-instance-name learn1 | jq -r '.Url' >> haidang.txt
aws sagemaker describe-notebook-instance --notebook-instance-name learn2 | jq -r '.Url' >> haidang.txt
aws configure set default.region us-west-2
aws sagemaker create-notebook-instance --notebook-instance-name learn1 --instance-type ml.p3.2xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker create-notebook-instance --notebook-instance-name learn2 --instance-type ml.g4dn.xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker describe-notebook-instance --notebook-instance-name learn1 | jq -r '.Url' >> haidang.txt
aws sagemaker describe-notebook-instance --notebook-instance-name learn2 | jq -r '.Url' >> haidang.txt
aws configure set default.region ca-central-1
aws sagemaker create-notebook-instance --notebook-instance-name learn1 --instance-type ml.p3.2xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker create-notebook-instance --notebook-instance-name learn2 --instance-type ml.g4dn.xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker describe-notebook-instance --notebook-instance-name learn1 | jq -r '.Url' >> haidang.txt
aws sagemaker describe-notebook-instance --notebook-instance-name learn2 | jq -r '.Url' >> haidang.txt
aws configure set default.region eu-north-1
aws sagemaker create-notebook-instance --notebook-instance-name learn1 --instance-type ml.p3.2xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker create-notebook-instance --notebook-instance-name learn2 --instance-type ml.g4dn.xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker describe-notebook-instance --notebook-instance-name learn1 | jq -r '.Url' >> haidang.txt
aws sagemaker describe-notebook-instance --notebook-instance-name learn2 | jq -r '.Url' >> haidang.txt
aws configure set default.region eu-west-3
aws sagemaker create-notebook-instance --notebook-instance-name learn1 --instance-type ml.p3.2xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker create-notebook-instance --notebook-instance-name learn2 --instance-type ml.g4dn.xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker describe-notebook-instance --notebook-instance-name learn1 | jq -r '.Url' >> haidang.txt
aws sagemaker describe-notebook-instance --notebook-instance-name learn2 | jq -r '.Url' >> haidang.txt
aws configure set default.region eu-west-2 
aws sagemaker create-notebook-instance --notebook-instance-name learn1 --instance-type ml.p3.2xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker create-notebook-instance --notebook-instance-name learn2 --instance-type ml.g4dn.xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker describe-notebook-instance --notebook-instance-name learn1 | jq -r '.Url' >> haidang.txt
aws sagemaker describe-notebook-instance --notebook-instance-name learn2 | jq -r '.Url' >> haidang.txt
aws configure set default.region eu-west-1
aws sagemaker create-notebook-instance --notebook-instance-name learn1 --instance-type ml.p3.2xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker create-notebook-instance --notebook-instance-name learn2 --instance-type ml.g4dn.xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker describe-notebook-instance --notebook-instance-name learn1 | jq -r '.Url' >> haidang.txt
aws sagemaker describe-notebook-instance --notebook-instance-name learn2 | jq -r '.Url' >> haidang.txt
aws configure set default.region eu-central-1
aws sagemaker create-notebook-instance --notebook-instance-name learn1 --instance-type ml.p3.2xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker create-notebook-instance --notebook-instance-name learn2 --instance-type ml.g4dn.xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker describe-notebook-instance --notebook-instance-name learn1 | jq -r '.Url' >> haidang.txt
aws sagemaker describe-notebook-instance --notebook-instance-name learn2 | jq -r '.Url' >> haidang.txt
aws configure set default.region eu-south-1 
aws sagemaker create-notebook-instance --notebook-instance-name learn1 --instance-type ml.p3.2xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker create-notebook-instance --notebook-instance-name learn2 --instance-type ml.g4dn.xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker describe-notebook-instance --notebook-instance-name learn1 | jq -r '.Url' >> haidang.txt
aws sagemaker describe-notebook-instance --notebook-instance-name learn2 | jq -r '.Url' >> haidang.txt
aws configure set default.region ap-south-1 
aws sagemaker create-notebook-instance --notebook-instance-name learn1 --instance-type ml.p3.2xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker create-notebook-instance --notebook-instance-name learn2 --instance-type ml.g4dn.xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker describe-notebook-instance --notebook-instance-name learn1 | jq -r '.Url' >> haidang.txt
aws sagemaker describe-notebook-instance --notebook-instance-name learn2 | jq -r '.Url' >> haidang.txt
aws configure set default.region ap-northeast-1
aws sagemaker create-notebook-instance --notebook-instance-name learn1 --instance-type ml.p3.2xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker create-notebook-instance --notebook-instance-name learn2 --instance-type ml.g4dn.xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker describe-notebook-instance --notebook-instance-name learn1 | jq -r '.Url' >> haidang.txt
aws sagemaker describe-notebook-instance --notebook-instance-name learn2 | jq -r '.Url' >> haidang.txt
aws configure set default.region ap-northeast-2
aws sagemaker create-notebook-instance --notebook-instance-name learn1 --instance-type ml.p3.2xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker create-notebook-instance --notebook-instance-name learn2 --instance-type ml.g4dn.xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker describe-notebook-instance --notebook-instance-name learn1 | jq -r '.Url' >> haidang.txt
aws sagemaker describe-notebook-instance --notebook-instance-name learn2 | jq -r '.Url' >> haidang.txt
aws configure set default.region ap-southeast-1
aws sagemaker create-notebook-instance --notebook-instance-name learn1 --instance-type ml.p3.2xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker create-notebook-instance --notebook-instance-name learn2 --instance-type ml.g4dn.xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker describe-notebook-instance --notebook-instance-name learn1 | jq -r '.Url' >> haidang.txt
aws sagemaker describe-notebook-instance --notebook-instance-name learn2 | jq -r '.Url' >> haidang.txt
aws configure set default.region ap-southeast-2 
aws sagemaker create-notebook-instance --notebook-instance-name learn1 --instance-type ml.p3.2xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker create-notebook-instance --notebook-instance-name learn2 --instance-type ml.g4dn.xlarge --role-arn $ARN --direct-internet-access Enabled --root-access Enabled --platform-identifier notebook-al2-v1 >nul
aws sagemaker describe-notebook-instance --notebook-instance-name learn1 | jq -r '.Url' >> haidang.txt
aws sagemaker describe-notebook-instance --notebook-instance-name learn2 | jq -r '.Url' >> haidang.txt
clear
cat haidang.txt
