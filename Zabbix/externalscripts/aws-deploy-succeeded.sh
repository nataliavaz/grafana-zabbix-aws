#!/bin/bash

###############################################################################
###############################################################################
# Script created by DevOps Team - 2020 
# Usage example: ./aws-deploy-succeeded.sh <profile> 
#
# Original: https://github.com/victorcfonseca/GrafanaDashboardAWS
# Adapted by: Natalia Vaz <silva.vaz@gmail.com>
# Change date: 2020-04-22
###############################################################################
###############################################################################
#set -x

profile=$1
region=$2
DIA=$(date +"%d")
MES=$(date +"%m")
ANO=$(date +"%Y")

HOJE="$ANO"-"$MES"-"$DIA"
#FIM=$ANO"-"$MES"-"$DIA"T11:59:59"

#deploy=$(aws deploy list-deployments --profile $1 --region $2 --include-only-statuses Succeeded --create-time-range start=$HOJE | wc -l)
#deploy=$(aws deploy list-deployments --profile $1 --region $2 --include-only-statuses Succeeded | wc -l)

deploy=$(aws deploy list-deployments --profile $1 --region $2 --application-name $3 --deployment-group-name $4 --include-only-statuses Succeeded --create-time-range start=$HOJE | wc -l)

echo $deploy
