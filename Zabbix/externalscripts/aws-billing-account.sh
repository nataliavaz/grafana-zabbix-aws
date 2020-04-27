#!/bin/bash

###############################################################################
###############################################################################
# Script created by DevOps Team - 2020 
# Usage example: ./aws-billing-account.sh <profile> 
#
# Created by: Natalia Vaz <silva.vaz@gmail.com>
# Change date: 2020-04-23
###############################################################################
###############################################################################
#set -x

profile=$1
account=$2 #"735668364794"

DAY=$(date +"%d")
MONTH=$(date +"%m")
YEAR=$(date +"%Y")
filter=/etc/zabbix/scripts/externalscripts/filter.json

#HOJE=$ANO"-"$MES"-"$DIA"T02:00:00"
#FIM=$ANO"-"$MES"-"$DIA"T11:59:59"

cat <<EOF >$filter
{
	"Dimensions": {
		"Key": "LINKED_ACCOUNT",
		"Values": [
			"$account"
		]	
	}
} 
EOF

cost=$(aws ce get-cost-and-usage --profile $1 --time-period Start=$YEAR-$MONTH-01,End=$YEAR-$MONTH-$DAY --granularity MONTHLY --metrics BlendedCost --filter file://$filter | grep BLENDEDCOST | awk '{print $2}')

echo $cost
