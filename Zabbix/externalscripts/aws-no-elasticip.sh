#!/bin/bash

###############################################################################
###############################################################################
# Script created by DevOps Team - 2020
# Usage example: ./aws-no-elasticip.sh <profile>
#
# Original: https://github.com/victorcfonseca/GrafanaDashboardAWS
# Adapted by: Natalia Vaz <silva.vaz@gmail.com>
# Change date: 2020-04-22
###############################################################################
###############################################################################
#set -x

profile=$1
region=$2

ips=`aws ec2 describe-addresses --profile $profile --region $region --query 'length(Addresses[*].PublicIp)'`

inst=`aws ec2 describe-addresses --profile $profile --region $region --query 'length(Addresses[*].AssociationId)'` 

result=$(($ips - $inst))

echo $result


