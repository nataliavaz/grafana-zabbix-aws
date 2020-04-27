#!/bin/bash

###############################################################################
###############################################################################
# Script created by DevOps Team - 2020 
# Usage example: ./aws-check-s3-public.sh <profile> 
#
# Original: https://github.com/victorcfonseca/GrafanaDashboardAWS
# Adapted by: Natalia Vaz <silva.vaz@gmail.com>
# Change date: 2020-04-20
###############################################################################
###############################################################################
#set -x

PROFILE_AWS=$1 # AWS CLI Profile
#REGION=$2
PROFILE_FAKE="mm-s3-check" # AWS CLI Profile, fake account to check buckets

S3_OUTPUT_LIST="/tmp/bucket_list_$PROFILE_AWS.lst"
POC_FILE="/tmp/poc_$PROFILE_AWS.txt"
RESULT="/tmp/stdout_$PROFILE_AWS.txt"
OUTPUT="/tmp/output_$PROFILE_AWS.txt"
now=$(date '+%Y-%m-%d')
COUNT=0

function check_s3(){
  echo "PoC file - Squad Cloud - Security check - $now" > $POC_FILE
  aws s3 ls --profile $PROFILE_AWS | cut -d " " -f3 > $S3_OUTPUT_LIST
  while IFS= read -r line
    do
      aws s3 cp $POC_FILE s3://$line/poc.txt 1>> $RESULT 2>> /dev/null
      COUNT=$((COUNT + 1))
    done < "$S3_OUTPUT_LIST" # checking all buckets from list

    cat $RESULT | cut -d " " -f13 > $OUTPUT

    if grep -q "s3://" $OUTPUT
    then
      RESPONSE=$(cat $OUTPUT | wc -l)
      echo $RESPONSE # result output *** number only
    else
      echo 0
    fi

    # Remove files
    rm $S3_OUTPUT_LIST
    rm $POC_FILE
    rm $RESULT
   # rm $OUTPUT
}

check_s3

public=`cat $OUTPUT`
zabbix_sender -z 127.0.0.1 -s "AWS-$PROFILE_AWS" -k aws.s3.public -o "$public" &>> /dev/null

rm $OUTPUT
