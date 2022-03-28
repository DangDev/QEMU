#!/bin/bash
echo off
echo install Awscli
apt install awscli -y
echo 'AWS_ACCESS_KEY_ID: ' $AWS_ACCESS_KEY_ID
echo 'AWS_SECRET_ACCESS_KEY: ' $AWS_SECRET_ACCESS_KEY
echo ap-southeast-1
echo ======================
aws configure
aws ec2 create-key-pair --key-name haidangYAM --query 'KeyMaterial' --output text > haidangYAM.pem
VPC=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query Vpc.VpcId --output text) > haidang.txt
SECURITY_ID=$(aws ec2 create-security-group --group-name HaiDangNe --description "Hehe" --vpc-id ${VPC} --output text) >> haidang.txt
aws ec2 authorize-security-group-ingress --group-id $SECURITY_ID --protocol tcp --port 3389 --cidr 0.0.0.0/0

aws ec2 create-subnet --vpc-id $VPC --cidr-block 10.0.0.0/24 > subnet.json
SUBNET_ID=$(cat subnet.json | jq -r '.Subnet.SubnetId') >> haidang.txt
INTERNET_GATE=$(aws ec2 create-internet-gateway --query InternetGateway.InternetGatewayId --output text) >> haidang.txt
aws ec2 attach-internet-gateway --vpc-id $VPC --internet-gateway-id $INTERNET_GATE
ROUTE_TABLE=$(aws ec2 create-route-table --vpc-id $VPC --query RouteTable.RouteTableId --output text) >> haidang.txt
aws ec2 create-route --route-table-id $ROUTE_TABLE --destination-cidr-block 0.0.0.0/0 --gateway-id $INTERNET_GATE
aws ec2 associate-route-table  --subnet-id $SUBNET_ID --route-table-id $ROUTE_TABLE
aws ec2 modify-subnet-attribute --subnet-id $SUBNET_ID --map-public-ip-on-launch

aws ec2 run-instances --image-id ami-0828f782ee03b55e4 --instance-type m5.xlarge --key-name haidangYAM --security-group-ids $SECURITY_ID --subnet-id $SUBNET_ID > instance.json
INSTANCE_ID=$(cat instance.json | jq -r '.Instances[0].InstanceId') >> haidang.txt
aws ec2 describe-instances --instance-id $INSTANCE_ID --query "Reservations[*].Instances[*].{State:State.Name,Address:PublicIpAddress}"
echo Wait 2 minute to boot up
sleep 120
aws ec2 get-password-data --instance-id $INSTANCE_ID --priv-launch-key haidangYAM.pem
