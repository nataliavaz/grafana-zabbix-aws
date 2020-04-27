#!/bin/bash

###############################################################################
###############################################################################
# Script created by DevOps Team - 2020 
# Usage example: ./aws-ec2-without-tag-prd.sh <profile> 
#
# Created by: Natalia Vaz <silva.vaz@gmail.com>
# Change date: 2020-04-23
###############################################################################
###############################################################################
#set -x

profile=$1

declare -i count='0'

lista=$(aws ec2 describe-instances --profile $1 --query 'Reservations[*].Instances[*].InstanceId' | wc -w)

for OUTPUT in $(aws ec2 describe-instances --profile $1 --query 'Reservations[*].Instances[*].InstanceId')
do
    
list_tag=""
list_tag=$(aws ec2 describe-tags --profile $profile --filters Name=resource-id,Values=$OUTPUT 2> /dev/null)

if [[ "${list_tag,,}" =~ "terraform" || "${list_tag,,}" =~ "name" ]];
    then

#echo -e '\033[05;32mTem Tag : '$OUTPUT'\033[00;37m' 
count=$count+1
    #else
#echo -e '\033[05;31mNão Tem Tag: '$OUTPUT'\033[00;37m'    


fi
#echo "========================================================================================"

done    

total=$(($lista - $count))
echo $total
