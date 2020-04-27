#!/bin/bash
###############################################################################
###############################################################################
# Script created by DevOps Team - 2020 
# Usage example: ./aws-ec2-ondemand.sh<profile> 
#
# Original: https://github.com/victorcfonseca/GrafanaDashboardAWS
# Adapted by: Natalia Vaz <silva.vaz@gmail.com>
# Change date: 2020-04-22
###############################################################################
###############################################################################
#set -i

profile=$1
region=$2

spot=`aws ec2 describe-instances --profile $1 --region $2 --query 'Reservations[*].Instances[*].InstanceLifecycle' --filters Name=instance-state-name,Values=running | grep -v "\[" | grep -v "\]" | wc -l`
instancias=`aws ec2 describe-instances --profile $1 --region $2 --query 'Reservations[*].Instances[*].InstanceId' --filters Name=instance-state-name,Values=running | grep i- | wc -l`

ondemand=$(($instancias - $spot))

echo $ondemand
