#!/bin/bash

###############################################################################
###############################################################################
# Script created by DevOps Team - 2020 
# Usage example: ./aws-sns-without-tag-prd.sh <profile> 
#
# Original: https://github.com/victorcfonseca/GrafanaDashboardAWS
# Adapted by: Natalia Vaz <silva.vaz@gmail.com>
# Change date: 2020-04-20
###############################################################################
###############################################################################
#set -x

profile=$1
declare -i count='0'

lista=$(aws sns list-topics --profile $1 | grep -v "\[" | grep -v "\]" | grep -v "\{" | grep -v "\}" | sed -e 's/\"//g' | sed -e 's/\TopicArn://g' | wc -l)
for OUTPUT in $(aws sns list-topics --profile $1 | grep -v "\[" | grep -v "\]" | grep -v "\{" | grep -v "\}" | sed -e 's/\"//g' | sed -e 's/\TopicArn://g')
do

	list_tag=""    
	list_tag=$(aws sns list-tags-for-resource --profile $1 --resource-arn $OUTPUT  2> /dev/null )

		if [[ "${list_tag,,}" =~ "terraform" || "${list_tag,,}" =~ "name" ]]
		then
    			#echo -e '\033[05;32mTem Tag: '$OUTPUT'\033[00;37m' 
  			count=$count+1
		#else
    			#echo -e '\033[05;31mNão Tem Tag: '$OUTPUT'\033[00;37m'  
fi
#echo "==============================================================================="
done
total=$(($lista - $count))
echo $total
