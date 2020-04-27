#!/bin/bash

###############################################################################
###############################################################################
# Script created by DevOps Team - 2020 
# Usage example: ./aws-deploy-failed.sh <profile> 
#
# Original: https://github.com/victorcfonseca/GrafanaDashboardAWS
# Adapted by: Natalia Vaz <silva.vaz@gmail.com>
# Change date: 2020-04-22
###############################################################################
###############################################################################
#set -x

profile=$1
region=$2
env=$3

DIA=$(date +"%d")
MES=$(date +"%m")
ANO=$(date +"%Y")

HOJE=$ANO"-"$MES"-"$DIA"T02:00:00"
#FIM=$ANO"-"$MES"-"$DIA"T02:59:59"


#deploy=$(aws deploy list-deployments --profile $profile --region $region --include-only-statuses Failed --create-time-range start=$HOJE | wc -l)
#deploy=$(aws deploy list-deployments --profile $profile --region $region --include-only-statuses Failed | wc -l)

deploy=$(aws deploy list-deployments --profile $1 --region $2 --application-name $3 --deployment-group-name $4 --include-only-statuses Failed --create-time-range start=$HOJE | wc -l)

echo $deploy
