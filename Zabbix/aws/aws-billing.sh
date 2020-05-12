#!/bin/bash

###############################################################################
###############################################################################
# Script created by DevOps Team - 2020 
# Usage example: ./aws-billing.sh <profile> 
#
# Created by: Natalia Vaz <natalia@track.co>
# Change date: 2020-04-23
###############################################################################
###############################################################################
#set -x

DAY=$(date +"%d")
MONTH=$(date +"%m")
YEAR=$(date +"%Y")

#HOJE=$ANO"-"$MES"-"$DIA"T02:00:00"
#FIM=$ANO"-"$MES"-"$DIA"T11:59:59"

cost=$(aws ce get-cost-and-usage --profile $1 --time-period Start=$YEAR-$MONTH-01,End=$YEAR-$MONTH-$DAY --granularity MONTHLY --metrics "BlendedCost" | grep BLENDEDCOST | awk '{print $2}')

echo $cost
