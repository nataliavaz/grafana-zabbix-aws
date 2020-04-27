#!/bin/bash

###############################################################################
###############################################################################
# Script created by DevOps Team - 2020 
# Usage example: ./aws-eip-without-tag.sh <profile> 
#
# Created by: Natalia Vaz <silva.vaz@gmail.com>
# Change date: 2020-04-23
###############################################################################
###############################################################################
#set -x

profile=$1

declare -i count='0'

lista=$(aws ec2 describe-addresses --profile $1 --query 'length(Addresses[*].AllocationId)')

for OUTPUT in $(aws ec2 describe-addresses --profile $1 --query 'Addresses[].AllocationId')
do
    
list_tag=""
list_tag=$(aws ec2 describe-tags --profile $profile --filters Name=resource-id,Values=$OUTPUT 2> /dev/null)


if [[ "${list_tag,,}" =~ "terraform" || "${list_tag,,}" =~ "name" ]];
    then
	#echo -e '\033[05;32mTem Tag : '$OUTPUT'\033[00;37m' 
	count=$count+1 
    #else
	#echo -e '\033[05;31mNão Tem Tag e: '$OUTPUT'\033[00;37m'    

fi
#echo "========================================================================================"

done    

total=$(($lista - $count))
echo $total
