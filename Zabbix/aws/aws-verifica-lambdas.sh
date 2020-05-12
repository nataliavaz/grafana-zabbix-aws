#!/bin/bash

###############################################################################
###############################################################################
# Script created by Cloud and Monitoring Team - 2020
# Usage example: aws-verifica-lambdas.sh <profile> <region> <tempo_em_dias>
#
# Original: https://github.com/victorcfonseca/GrafanaDashboardAWS
# Adapted by: Natalia Vaz <silva.vaz@gmail.com>
# Change date: 2020-05-12
###############################################################################
###############################################################################
#set -x

declare -i count=0

HOJE=$(date '+%Y-%m-%dT%H:%M:%SZ')

qtd=$3

declare -i qtdade_dias=$qtd

profile=$1
region=$2

inicio=$(date -d "-$qtdade_dias days"  '+%Y-%m-%d'T00:00:00Z)

periodo=$((60*24*$qtdade_dias))

for OUTPUT in $(aws lambda list-functions --region $2 --profile $profile --query 'Functions[].FunctionName' | grep -v "\[" | grep -v "\]" | sed -e 's/\"//g' | sed -e 's/\,//g')
do
	lambda_execution=""    
	lambda_execution=$(aws cloudwatch get-metric-statistics --region $2 --profile $profile --metric-name Invocations --start-time $inicio --end-time $HOJE --period $periodo --namespace AWS/Lambda --statistics Sum --dimensions Name=FunctionName,Value=$OUTPUT --output json | jq '.Datapoints[].Sum' 2> /dev/null)

	if [[ $lambda_execution == "" ]]
	then
		count=$count+1
	fi
 
done

echo $count  
