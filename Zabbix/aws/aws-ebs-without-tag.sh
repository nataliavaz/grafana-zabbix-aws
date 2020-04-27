#!/bin/bash

###############################################################################
###############################################################################
# Script created by DevOps Team - 2020 
# Usage example: ./aws-ebs-without-tag.sh <profile> 
#
# Created by: Natalia Vaz <silva.vaz@gmail.com>
# Change date: 2020-04-24
###############################################################################
###############################################################################
#set -x

profile=$1
notag="/tmp/ebsnotag_$profile.txt"

declare -i count='0'

lista=$(aws ec2 describe-volumes --profile $1 --query 'length(Volumes[*].VolumeId)')

for OUTPUT in $(aws ec2 describe-volumes --profile $1 --query 'Volumes[*].VolumeId')
do
    
list_tag=""
list_tag=$(aws ec2 describe-tags --profile $profile  --filters Name=resource-id,Values=$OUTPUT 2> /dev/null)


if [[ "${list_tag,,}" =~ "terraform" || "${list_tag,,}" =~ "name" ]];
    then

	#echo -e '\033[05;32mTem Tag : '$OUTPUT'\033[00;37m' 
	count=$count+1 
    else
	#echo -e '\033[05;31mNão Tem Tag e: '$OUTPUT'\033[00;37m'    
	 echo $OUTPUT >> $notag

fi
#echo "========================================================================================"

done    

total=$(($lista - $count))
echo $total

ebs=`cat $notag`
zabbix_sender -z 127.0.0.1 -s "AWS-$profile" -k aws.ebs.notag -o "$ebs" &>> /dev/null

rm $notag
