#!/bin/bash
apt install awscli -y
echo $AWS_ACCESS_KEY_ID
echo $AWS_SECRET_ACCESS_KEY
echo ap-southeast-1
aws configure
aws ec2 create-key-pair --key-name haidangYAM --query 'KeyMaterial' --output text > haidangYAM.pem
VPC=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query Vpc.VpcId --output text)
SECURITY_ID=$(aws ec2 create-security-group --group-name HaiDangNe --description "Hehe" --vpc-id ${VPC} --output text)
aws ec2 describe-vpcs
aws ec2 describe-security-groups
aws ec2 authorize-security-group-ingress --group-id $SECURITY_ID --protocol tcp --port 3389 --cidr 0.0.0.0/0

aws ec2 create-subnet --vpc-id $VPC --cidr-block 10.0.0.0/24 > subnet.json
SUBNET_ID=$(cat subnet.json | jq -r '.Subnet.SubnetId')
INTERNET_GATE=$(aws ec2 create-internet-gateway --query InternetGateway.InternetGatewayId --output text)
aws ec2 attach-internet-gateway --vpc-id $VPC --internet-gateway-id $INTERNET_GATE
ROUTE_TABLE=$(aws ec2 create-route-table --vpc-id $VPC --query RouteTable.RouteTableId --output text)
aws ec2 create-route --route-table-id $ROUTE_TABLE --destination-cidr-block 0.0.0.0/0 --gateway-id $INTERNET_GATE
aws ec2 associate-route-table  --subnet-id $SUBNET_ID --route-table-id $ROUTE_TABLE
aws ec2 modify-subnet-attribute --subnet-id $SUBNET_ID --map-public-ip-on-launch

aws ec2 run-instances --image-id ami-0986ce89f08af5d39 --instance-type m5.xlarge --key-name haidangYAM --security-group-ids $SECURITY_ID --subnet-id $SUBNET_ID > instance.json
INSTANCE_ID=$(cat instance.json | jq -r '.Instances[0].InstanceId')
aws ec2 describe-instances --instance-id INSTANCE_ID --query "Reservations[*].Instances[*].{State:State.Name,Address:PublicIpAddress}"
aws ec2 get-password-data --instance-id INSTANCE_ID --priv-launch-key haidangYAM.pem
