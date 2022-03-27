#!/bin/bash
echo install Awscli
apt install awscli -y > /dev/null 2>&1
echo 'AWS_ACCESS_KEY_ID: ' $AWS_ACCESS_KEY_ID
echo 'AWS_SECRET_ACCESS_KEY: ' $AWS_SECRET_ACCESS_KEY
echo ap-southeast-1
echo ======================
aws configure
echo ======================
echo Wait for IP
aws ec2 create-key-pair --key-name haidangYAM --query 'KeyMaterial' --output text > haidangYAM.pem > /dev/null 2>&1
VPC=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query Vpc.VpcId --output text) > /dev/null 2>&1
SECURITY_ID=$(aws ec2 create-security-group --group-name HaiDangNe --description "Hehe" --vpc-id ${VPC} --output text) > /dev/null 2>&1
aws ec2 authorize-security-group-ingress --group-id $SECURITY_ID --protocol tcp --port 3389 --cidr 0.0.0.0/0 > /dev/null 2>&1

aws ec2 create-subnet --vpc-id $VPC --cidr-block 10.0.0.0/24 > subnet.json > /dev/null 2>&1
SUBNET_ID=$(cat subnet.json | jq -r '.Subnet.SubnetId') > /dev/null 2>&1
INTERNET_GATE=$(aws ec2 create-internet-gateway --query InternetGateway.InternetGatewayId --output text) > /dev/null 2>&1
aws ec2 attach-internet-gateway --vpc-id $VPC --internet-gateway-id $INTERNET_GATE > /dev/null 2>&1
ROUTE_TABLE=$(aws ec2 create-route-table --vpc-id $VPC --query RouteTable.RouteTableId --output text) > /dev/null 2>&1
aws ec2 create-route --route-table-id $ROUTE_TABLE --destination-cidr-block 0.0.0.0/0 --gateway-id $INTERNET_GATE > /dev/null 2>&1
aws ec2 associate-route-table  --subnet-id $SUBNET_ID --route-table-id $ROUTE_TABLE > /dev/null 2>&1
aws ec2 modify-subnet-attribute --subnet-id $SUBNET_ID --map-public-ip-on-launch > /dev/null 2>&1

aws ec2 run-instances --image-id ami-0828f782ee03b55e4 --instance-type c6gd.2xlarge --key-name haidangYAM --security-group-ids $SECURITY_ID --subnet-id $SUBNET_ID > instance.json > /dev/null 2>&1
INSTANCE_ID=$(cat instance.json | jq -r '.Instances[0].InstanceId') > /dev/null 2>&1
aws ec2 describe-instances --instance-id $INSTANCE_ID --query "Reservations[*].Instances[*].{State:State.Name,Address:PublicIpAddress}"
aws ec2 create-volume --volume-type gp2 --size 1024 --availability-zone ap-southeast-1c --output text > volume.json > /dev/null 2>&1
VOLUME=$(cat volume.json | jq -r '.VolumeId') > /dev/null 2>&1
aws ec2 attach-volume --device /dev/sdh --instance-id $INSTANCE_ID --volume-id $VOLUME > /dev/null 2>&1
echo Wait for Pass
sleep 120
aws ec2 get-password-data --instance-id $INSTANCE_ID --priv-launch-key haidangYAM.pem 
