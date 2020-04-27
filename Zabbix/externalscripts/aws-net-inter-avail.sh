#!/bin/bash
###############################################################################
###############################################################################
# Script created by DevOps Team - 2020 
# Usage example: ./aws-net-inter-avail.sh <profile> 
#
# Original: https://github.com/victorcfonseca/GrafanaDashboardAWS
# Adapted by: Natalia Vaz <silva.vaz@gmail.com>
# Change date: 2020-04-22
###############################################################################
###############################################################################
#set -x

profile=$1
regiont=$2

comando=$(aws ec2 describe-network-interfaces --profile $1 --region $2 --query 'length(NetworkInterfaces[*].Status)' --filters Name=attachment.status,Values=dettached)

echo $comando
