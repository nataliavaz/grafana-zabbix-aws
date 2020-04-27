#!/bin/bash

###############################################################################
################################# Tracksale   #################################
# Script created by DevOps Team - 2020 
# Usage example: ./aws-s3-encrypt-prd.sh <profile> 
#
# Original: https://github.com/victorcfonseca/GrafanaDashboardAWS
# Adapted by: Natalia Vaz <silva.vaz@gmail.com>
# Change date: 2020-04-22
# Needs bucket permission: "s3:GetEncryptionConfiguration"
###############################################################################
###############################################################################
#set -x

profile=$1
declare -i count='0'
nocrypt="/tmp/output_nocrypt_$profile.txt"

lista=$(aws s3 ls --profile $profile | cut -c20-200 | wc -l)
for OUTPUT in $(aws s3 ls --profile $profile | cut -c20-400)
do
    
crypt=""
crypt=$(aws s3api get-bucket-encryption --profile $1 --bucket $OUTPUT 2> /dev/null)


if [[ $crypt =~ "AES256" || $crypt =~ "aws:kms" ]];
    then

	#echo -e '\033[05;32mTem Criptografia - Bucket Name: '$OUTPUT'\033[00;37m' 
	count=$count+1 
    else
	#echo -e '\033[05;31mNão Tem Criptografia - Bucket Name: '$OUTPUT'\033[00;37m'    
    	echo $OUTPUT >> $nocrypt

fi
#echo "========================================================================================"

done    

total=$(($lista - $count))
echo $total

buckets=`cat $nocrypt`
zabbix_sender -z 127.0.0.1 -s "AWS-$profile" -k aws.s3.noencrypt -o "$buckets" &>> /dev/null

rm $nocrypt
