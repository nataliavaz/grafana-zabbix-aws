#!/bin/bash

###############################################################################
################################# Tracksale   #################################
# Script created by DevOps Team - 2020
# Usage example: ./aws-redis-without-tag-prd.sh <profile>
#
# Original: https://github.com/victorcfonseca/GrafanaDashboardAWS
# Adapted by: Natalia Vaz <silva.vaz@gmail.com>
# Change date: 2020-04-22
###############################################################################
###############################################################################
#set -x 

profile=$1
declare -i count='0'

lista=$(aws elasticache describe-cache-clusters --profile $profile --query 'CacheClusters[*].CacheClusterId' | grep -v "\[" | grep -v "\]" | sed -e 's/\"//g' | sed -e 's/\,//g' | wc -l)
for OUTPUT in $(aws elasticache describe-cache-clusters --profile $profile --query 'CacheClusters[*].CacheClusterId' | grep -v "\[" | grep -v "\]" | sed -e 's/\"//g' | sed -e 's/\,//g')
do
    
list_tag=""
list_tag=$(aws elasticache list-tags-for-resource --profile $profile --resource-name arn:aws:elasticache:us-east-1:516669511250:cluster:$OUTPUT 2> /dev/null)


if [[ "${list_tag,,}" =~ "terraform" || "${list_tag,,}" =~ "name" ]];
    then

#echo -e '\033[01;32mTem Tag - Nome do Nó: '$OUTPUT'\033[00;37m' 
count=$count+1 
    #else
#echo -e '\033[01;31mNão Tem Tag -  Nome do Nó: '$OUTPUT'\033[00;37m'    


fi
#echo "========================================================================================"

done    

total=$(($lista - $count))
echo $total


