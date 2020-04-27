#!/bin/bash

###############################################################################
###############################################################################
# Script created by DevOps Team - 2020 
# Usage example: ./aws-backup-succeeded.sh <profile> 
#
# Adapted by: Natalia Vaz <silva.vaz@gmail.com>
# Change date: 2020-04-24
###############################################################################
###############################################################################
#set -x

profile=$1

DIA=$(date +"%d")
MES=$(date +"%m")
ANO=$(date +"%Y")

HOJE="$ANO"-"$MES"-"$DIA"

backup=$(aws backup list-backup-jobs --profile $1 --by-state FAILED --by-created-after $HOJE | grep -i backupjobs | wc -l)

echo $backup

