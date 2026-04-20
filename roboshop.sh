#!/bin/bash

AMI_ID="ami-098e39bafa7e7303d"
SG_ID="sg-0c1572c17ec6ecf2f" # replace with your SG ID
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")
ZONE_ID="Z016724622CXQDS2CP51J" # replace with your ZONE ID
DOMAIN_NAME="daws-sunny.site"   # replace with your domain

#for instance in ${INSTANCES[@]}
for instance in $@; do
	INSTANCE_ID=$(aws ec2 run-instances --image-id ami-098e39bafa7e7303d --instance-type t3.micro --security-group-ids sg-0c1572c17ec6ecf2f --tag-specifications "ResourceType=instance,Tags=[{Key=Name, Value=$instance}]" --query "Instances[0].InstanceId" --output text)
	if [ $instance != "frontend" ]; then
		IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
		RECORD_NAME="$instance.$DOMAIN_NAME"
	else
		IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PublicIpAddress" --output text)
		RECORD_NAME="$DOMAIN_NAME"
	fi
	echo "$instance IP address: $IP"

	aws route53 change-resource-record-sets \
		--hosted-zone-id $ZONE_ID \
		--change-batch '
    {
        "Comment": "Creating or Updating a record set for cognito endpoint"
        ,"Changes": [{
        "Action"              : "UPSERT"
        ,"ResourceRecordSet"  : {
            "Name"              : "'$RECORD_NAME'"
            ,"Type"             : "A"
            ,"TTL"              : 1
            ,"ResourceRecords"  : [{
                "Value"         : "'$IP'"
            }]
        }
        }]
    }'
done
