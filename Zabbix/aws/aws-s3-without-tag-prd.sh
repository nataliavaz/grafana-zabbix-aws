#!/bin/bash

###############################################################################
###############################################################################
# Script created by DevOps Team - 2020 
# Usage example: ./aws-s3-without-tag-prd.sh <profile> 
#
# Original: https://github.com/victorcfonseca/GrafanaDashboardAWS
# Adapted by: Natalia Vaz <silva.vaz@gmail.com>
# Change date: 2020-04-24
###############################################################################
###############################################################################
#set -x

declare -i count='0'

profile=$1
notag="/tmp/output_notag_$profile.txt"

lista=$(aws s3 ls --profile $1 | wc -l)

for OUTPUT in $(aws s3 ls --profile $1 | cut -c20-80)
do

list_tag=""    
list_tag=$(aws s3api get-bucket-tagging --profile $1 --bucket $OUTPUT 2> /dev/null )

if [[ "${list_tag,,}" =~ "terraform" || "${list_tag,,}" =~ "name" ]]
then
    #echo -e '\033[05;31mTem Tag: '$OUTPUT'\033[00;37m' 
    count=$count+1      
else
    #echo -e '\033[05;32mNão Tem Tag: '$OUTPUT'\033[00;37m'  
 
    echo $OUTPUT >> $notag
   
fi
#echo "==============================================================================="
done
total=$(($lista - $count))
echo $total


buckets=`cat $notag`
zabbix_sender -z 127.0.0.1 -s "AWS-$profile" -k aws.s3.notag -o "$buckets" &>> /dev/null

rm $notag
