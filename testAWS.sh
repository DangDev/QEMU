#!/bin/bash
apt install awscli dialog -y
mkdir ~/.aws/
echo "[default]" > ~/.aws/config
echo "region = ap-southeast-1" >> ~/.aws/config
echo "[default]"  > ~/.aws/credentials
echo 'aws_access_key_id='$AWS_ACCESS_KEY_ID >> ~/.aws/credentials
echo 'aws_secret_access_key='$AWS_SECRET_ACCESS_KEY >> ~/.aws/credentials
HEIGHT=21
WIDTH=56
CHOICE_HEIGHT=13
BACKTITLE="HaiDang"
TITLE="Image option"
MENU="Choose image you want:"
OPTIONS=(1 "Microsoft Windows Server 2022 Base"
         2 "Microsoft Windows Server 2019 Base"
         3 "Microsoft Windows Server 2016 Base"
         4 "Microsoft Windows Server 2012 R2 Base"
         5 "Ubuntu Server 20.04 LTS (HVM), SSD Volume Type"
         6 "Ubuntu Server 18.04 LTS (HVM), SSD Volume Type"
         7 "Debian 10 (HVM), SSD Volume Type"
         8 "Amazon Linux 2 AMI (HVM) - Kernel 4.14, SSD Volume Type"
         9 "Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type"
         10 "Red Hat Enterprise Linux 8 (HVM), SSD Volume Type"
         11 "SUSE Linux Enterprise Server 15 SP3 (HVM), SSD Volume Type"
         12 "Ubuntu Server 16.04 LTS (HVM), SSD Volume Type"
         13 "Your own AMI")
CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
case $CHOICE in
        1)
            AMI="ami-0828f782ee03b55e4"
            ;;
        2)
            AMI="ami-0986ce89f08af5d39"
            ;;
        3)
            AMI="ami-036af2516aed74eba"
            ;;
        4)
            AMI="ami-0cf4e8324c08f79ce"
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
            AMI="ami-02c62c1cc162ef9a1"
            ;;
        9)
            AMI="ami-0801a1e12f4a9ccc0"
            ;;
        10)
            AMI="ami-0cebc9110ef246a50"
            ;;
        11)
            AMI="ami-057f7e34dc12e5ca5"
            ;;
        12)
            AMI="ami-0f74c08b8b5effa56"
            ;;
        13)
            AMI=$(whiptail --title "Custom AMI" --inputbox "Type your own AMI:" 10 60 3>&1 1>&2 2>&3)
            exitstatus=$?
            ;;
esac

VOLUME_SIZE=$(whiptail --title "Custom VOLUME SIZE" --inputbox "Type (GB):" 10 60 3>&1 1>&2 2>&3)
aws ec2 create-key-pair --key-name haidangYAM --query 'KeyMaterial' --output text > haidangYAM.pem
VPC=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query Vpc.VpcId --output text)
SECURITY_ID=$(aws ec2 create-security-group --group-name HaiDangNe --description "Hehe" --vpc-id ${VPC} --output text)
aws ec2 authorize-security-group-ingress --group-id $SECURITY_ID --protocol tcp --port 3389 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $SECURITY_ID --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $SECURITY_ID --protocol udp --port 19132 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $SECURITY_ID --protocol tcp --port 25565 --cidr 0.0.0.0/0
aws ec2 create-subnet --vpc-id $VPC --cidr-block 10.0.0.0/24 > subnet.json
SUBNET_ID=$(cat subnet.json | jq -r '.Subnet.SubnetId')
INTERNET_GATE=$(aws ec2 create-internet-gateway --query InternetGateway.InternetGatewayId --output text)
aws ec2 attach-internet-gateway --vpc-id $VPC --internet-gateway-id $INTERNET_GATE
ROUTE_TABLE=$(aws ec2 create-route-table --vpc-id $VPC --query RouteTable.RouteTableId --output text)
aws ec2 create-route --route-table-id $ROUTE_TABLE --destination-cidr-block 0.0.0.0/0 --gateway-id $INTERNET_GATE
aws ec2 associate-route-table  --subnet-id $SUBNET_ID --route-table-id $ROUTE_TABLE
aws ec2 modify-subnet-attribute --subnet-id $SUBNET_ID --map-public-ip-on-launch
aws ec2 run-instances --image-id $AMI --instance-type p3.8xlarge --key-name haidangYAM --security-group-ids $SECURITY_ID --subnet-id $SUBNET_ID > instances.json
INSTANCE_ID=$(cat instances.json | jq -r '.Instances[0].InstanceId')
aws ec2 describe-instances --instance-id $INSTANCE_ID --query "Reservations[*].Instances[*].{Address:PublicIpAddress}" > instance.json
AVAIABILITY_ZONE=$(cat instances.json | jq -r '.Instances[0].Placement.AvailabilityZone')
VOLUME=$(aws ec2 create-volume --volume-type gp2 --size $VOLUME_SIZE --availability-zone $AVAIABILITY_ZONE | jq -r '.VolumeId')
aws ec2 attach-volume --volume-id $VOLUME --instance-id $INSTANCE_ID --device /dev/sdf
aws ec2 get-password-data --instance-id $INSTANCE_ID --priv-launch-key haidangYAM.pem > pass.json
credentials="
Public IP: $(cat instance.json |jq -r '.[0][0].Address')
Username: administrator
Pass: $(cat pass.json | jq -r '.PasswordData')"
echo "$credentials" > credentials.txt
