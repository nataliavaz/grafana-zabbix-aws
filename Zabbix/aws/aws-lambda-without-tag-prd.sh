#!/bin/bash

###############################################################################
################################# Tracksale  #################################
# Script created by DevOps Team - 2020 
# Usage example: ./aws-lambda-without-tag-prd.sh <profile> 
#
# Original: https://github.com/victorcfonseca/GrafanaDashboardAWS
# Adapted by: Natalia Vaz <silva.vaz@gmail.com>
# Change date: 2020-04-23
###############################################################################
###############################################################################
#set -x

profile=$1

declare -i count='0'
lista=$(aws lambda list-functions --profile $profile --query 'Functions[].FunctionArn' | grep -v "\[" | grep -v "\]" | wc -l)
for OUTPUT in $(aws lambda list-functions --profile $profile --query 'Functions[].FunctionArn' | grep -v "\[" | grep -v "\]" | sed -e 's/\"//g' | sed -e 's/\,//g')
do
	list_tag=""    
	list_tag=$(aws lambda list-tags --profile $profile --resource $OUTPUT --output json  2> /dev/null)

	if [[ "${list_tag,,}" =~ "terraform" || "${list_tag,,}" =~ "name" ]];
		then
    			#echo -e '\033[00;32mTem Tag: '$OUTPUT'\033[00;37m' 
  
		#else
    			#echo -e '\033[00;31mNão Tem Tag: '$OUTPUT'\033[00;37m'  
			count=$count+1    
       
	fi
#echo "=============================================================================================================================================="
done

total=$(($lista - $count))
echo $total
