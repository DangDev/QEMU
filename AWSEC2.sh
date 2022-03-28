#!/bin/bash
apt install awscli dialog -y
mkdir ~/.aws/
echo "[default]" > ~/.aws/config
echo "region = ap-southeast-1" >> ~/.aws/config
echo "[default]"  > ~/.aws/credentials
echo 'aws_access_key_id='$AWS_ACCESS_KEY_ID >> ~/.aws/credentials
echo 'aws_secret_access_key='$AWS_SECRET_ACCESS_KEY >> ~/.aws/credentials
clear
HEIGHT=21
WIDTH=56
CHOICE_HEIGHT=12
BACKTITLE="HaiDang"
TITLE="Image option"
MENU="Choose image you want:"
OPTIONS=(1 "Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type"
         2 "Amazon Linux 2 AMI (HVM) - Kernel 4.14, SSD Volume Type"
         3 "Red Hat Enterprise Linux 8 (HVM), SSD Volume Type"
         4 "SUSE Linux Enterprise Server 15 SP3 (HVM), SSD Volume Type"
         5 "Ubuntu Server 20.04 LTS (HVM), SSD Volume Type"
         6 "Ubuntu Server 18.04 LTS (HVM), SSD Volume Type"
         7 "Debian 10 (HVM), SSD Volume Type"
         8 "Microsoft Windows Server 2019 Base"
         9 "Microsoft Windows Server 2022 Base"
         10 "Microsoft Windows Server 2016 Base"
         11 "Microsoft Windows Server 2012 R2 Base"
         12 "Ubuntu Server 16.04 LTS (HVM), SSD Volume Type")
CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
clear
case $CHOICE in
        1)
            AMI="ami-0801a1e12f4a9ccc0"
            ;;
        2)
            AMI="ami-02c62c1cc162ef9a1"
            ;;
        3)
            AMI="ami-0cebc9110ef246a50"
            ;;
        4)
            AMI="ami-057f7e34dc12e5ca5"
            ;;
        5)
            AMI="ami-055d15d9cfddf7bd3"
            ;;
        6)
            AMI="ami-07315f74f3fa6a5a3"
            ;;
        7)
            AMI="ami-01aa83ab14b00e516"
            ;;
        8)
            AMI="ami-0986ce89f08af5d39"
            ;;
        9)
            AMI="ami-0828f782ee03b55e4"
            ;;
        10)
            AMI="ami-036af2516aed74eba"
            ;;
        11)
            AMI="ami-0cf4e8324c08f79ce"
            ;;
        12)
            AMI="ami-0f74c08b8b5effa56"
            ;;
esac

{
    i = 0
    aws ec2 create-key-pair --key-name haidangYAM --query 'KeyMaterial' --output text > haidangYAM.pem
    i += 6.5
    VPC=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query Vpc.VpcId --output text)
    i += 6.5
    SECURITY_ID=$(aws ec2 create-security-group --group-name HaiDangNe --description "Hehe" --vpc-id ${VPC} --output text)
    i += 6.5
    aws ec2 authorize-security-group-ingress --group-id $SECURITY_ID --protocol tcp --port 3389 --cidr 0.0.0.0/0
    i += 6.5
    aws ec2 create-subnet --vpc-id $VPC --cidr-block 10.0.0.0/24 > subnet.json
    i += 6.5
    SUBNET_ID=$(cat subnet.json | jq -r '.Subnet.SubnetId')
    i += 6.5
    INTERNET_GATE=$(aws ec2 create-internet-gateway --query InternetGateway.InternetGatewayId --output text)
    i += 6.5
    aws ec2 attach-internet-gateway --vpc-id $VPC --internet-gateway-id $INTERNET_GATE
    i += 6.5
    ROUTE_TABLE=$(aws ec2 create-route-table --vpc-id $VPC --query RouteTable.RouteTableId --output text)
    i += 6.5
    aws ec2 create-route --route-table-id $ROUTE_TABLE --destination-cidr-block 0.0.0.0/0 --gateway-id $INTERNET_GATE
    i += 6.5
    aws ec2 associate-route-table  --subnet-id $SUBNET_ID --route-table-id $ROUTE_TABLE
    i += 6.5
    aws ec2 modify-subnet-attribute --subnet-id $SUBNET_ID --map-public-ip-on-launch
    i += 6.5
    aws ec2 run-instances --image-id $AMI --instance-type m5.xlarge --key-name haidangYAM --security-group-ids $SECURITY_ID --subnet-id $SUBNET_ID > instances.json
    i += 6.5
    INSTANCE_ID=$(cat instances.json | jq -r '.Instances[0].InstanceId')
    i += 6.5
    aws ec2 describe-instances --instance-id $INSTANCE_ID --query "Reservations[*].Instances[*].{Address:PublicIpAddress}" > instance.json
    i += 6.5
} | dialog --gauge "Please wait while installing" 6 60 0
clear
echo Wait 2 minute to boot up
sleep 120
clear
aws ec2 get-password-data --instance-id $INSTANCE_ID --priv-launch-key haidangYAM.pem > pass.json
echo 'Public IP: ' $(cat instance.json |jq -r '.[0][0].Address')
echo 'Username: administrator'
echo 'Pass: ' $(cat pass.json | jq -r '.PasswordData')
