#!/bin/bash
# Author: Natalia Vaz <natalia@track.co>
#set -x

zabbix_sender=/usr/bin/zabbix_sender
ip_zabbix_server=127.0.0.1
nome_host_zabbix="Zabbix server"

profile=$1
account=$2

###########Billing Account###
$zabbix_sender -z $ip_zabbix_server -s "AWS-$profile" -k billing.account -o $(/etc/zabbix/scripts/aws/aws-billing-account.sh $profile $account)
$zabbix_sender -z $ip_zabbix_server -s "AWS-$profile" -k billing.total -o $(/etc/zabbix/scripts/aws/aws-billing.sh $profile)
