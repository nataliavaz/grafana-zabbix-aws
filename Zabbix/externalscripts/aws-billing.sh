#!/bin/bash

###############################################################################
###############################################################################
# Script created by DevOps Team - 2020 
# Usage example: ./aws-billing.sh <profile> 
#
# Created by: Natalia Vaz <silva.vaz@gmail.com>
# Change date: 2020-04-23
###############################################################################
###############################################################################
#set -x

DAY=$(date +"%d")
MONTH=$(date +"%m")
YEAR=$(date +"%Y")

cost=$(aws ce get-cost-and-usage --profile $1 --time-period Start=$YEAR-$MONTH-01,End=$YEAR-$MONTH-$DAY --granularity MONTHLY --metrics "BlendedCost" | grep BLENDEDCOST | awk '{print $2}')

echo $cost

