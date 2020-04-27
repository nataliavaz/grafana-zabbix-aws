#!/bin/bash

###############################################################################
###############################################################################
# Script created by DevOps Team - 2020
# Usage example: ./aws-redis.sh <profile>
#
# Original: https://github.com/victorcfonseca/GrafanaDashboardAWS
# Adapted by: Natalia Vaz <silva.vaz@gmail.com>
# Change date: 2020-04-22
###############################################################################
###############################################################################
#set -x


redis=`aws elasticache describe-cache-clusters --profile $1 --region $2 --query 'CacheClusters[*].[ReplicationGroupId]' --output json | grep -v null | grep -v "\[" | grep -v "\]" | wc -l `

result=$redis

calc=$(($redis/2))

echo $calc
