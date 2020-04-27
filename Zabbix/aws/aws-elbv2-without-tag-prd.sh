#!/bin/bash

###############################################################################
###############################################################################
# Script created by DevOps Team - 2020 
# Usage example: ./aws-elbv2-without-tag-prd.sh <profile> 
#
# Original: https://github.com/victorcfonseca/GrafanaDashboardAWS
# Adapted by: Natalia Vaz <silva.vaz@gmail.com>
# Change date: 2020-04-20
###############################################################################
###############################################################################
#set -x

profile=$1

declare -i count='0'
#declare -i count_total='0'

lista=$(aws elbv2 describe-load-balancers --profile $profile --query 'length(LoadBalancers[*].LoadBalancerArn)')

for OUTPUT in $(aws elbv2 describe-load-balancers --profile $profile --query 'LoadBalancers[*].LoadBalancerArn' | grep -v "\[" | grep -v "\]" | sed -e 's/\"//g' | sed -e 's/\,//g')
do
    
list_tag=""
list_tag=$(aws elbv2 describe-tags --profile $profile --resource-arns  $OUTPUT 2> /dev/null)


if [[ "${list_tag,,}" =~ "terraform" || "${list_tag,,}" =~ "name" ]];
    then
	#echo -e '\033[05;32mTem Tag - LoadBalancer Name: '$OUTPUT'\033[00;37m' 
	count=$count+1 
    #else
	#echo -e '\033[05;31mNão Tem Tag - LoadBalancer Name: '$OUTPUT'\033[00;37m'    


fi
#echo "========================================================================================"

done    

total=$(($lista - $count))
echo $total


