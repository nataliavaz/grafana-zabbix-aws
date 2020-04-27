#!/bin/bash
# Author: Natalia Vaz <silva.vaz@gmail.com>
# Usage Example: ./cron_aws.sh <profile AWS>
# cron: */120 * * * * /etc/zabbix/scripts/cron_aws.sh <profile AWS>
#set -x

zabbix_sender=/usr/bin/zabbix_sender
ip_zabbix_server=127.0.0.1
nome_host_zabbix="Zabbix server"

profile=$1
###########S3 Sem Encriptar###
$zabbix_sender -z $ip_zabbix_server -s "AWS-$profile" -k s3.without.encrypt -o $(/etc/zabbix/scripts/aws/aws-s3-encrypt-prd.sh $profile)

####Verifica S3 public PRD####
$zabbix_sender -z $ip_zabbix_server -s "AWS-$profile" -k aws.verifica.s3.public -o $(/etc/zabbix/scripts/aws/aws-s3-check-public.sh $profile)

####Verifica Lambda PRD que não foram executadas nos ultimos 30 dias####
$zabbix_sender -z  $ip_zabbix_server -s "AWS-$profile" -k aws.verifica.lambda.30 -o $(/etc/zabbix/scripts/aws/aws-verifica-lambdas.sh $profile 30)

####Verifica Lambda PRD que não foram executadas nos ultimos 90 dias####
$zabbix_sender -z  $ip_zabbix_server -s "AWS-$profile" -k aws.verifica.lambda.90 -o $(/etc/zabbix/scripts/aws/aws-verifica-lambdas.sh $profile 90)

####Verifica Lambda PRD que não foram executadas nos ultimos 180 dias####
$zabbix_sender -z  $ip_zabbix_server -s "AWS-$profile" -k aws.verifica.lambda.180 -o $(/etc/zabbix/scripts/aws/aws-verifica-lambdas.sh $profile 180)

##TAGS##
## ELVB ##
$zabbix_sender -z  $ip_zabbix_server -s "AWS-$profile" -k aws.elbv2.without.tag -o $(/etc/zabbix/scripts/aws/aws-elbv2-without-tag-prd.sh $profile)

#S3
$zabbix_sender -z  $ip_zabbix_server -s "AWS-$profile" -k aws.s3.without.tag -o $(/etc/zabbix/scripts/aws/aws-s3-without-tag-prd.sh $profile)

## SQS
$zabbix_sender -z  $ip_zabbix_server -s "AWS-$profile" -k aws.sqs.without.tag -o $(/etc/zabbix/scripts/aws/aws-sqs-without-tag-prd.sh $profile)

## lambda
$zabbix_sender -z  $ip_zabbix_server -s "AWS-$profile" -k aws.lambda.without.tag -o $(/etc/zabbix/scripts/aws/aws-lambda-without-tag-prd.sh $profile)

# SNS
$zabbix_sender -z  $ip_zabbix_server -s "AWS-$profile" -k aws.sns.without.tag -o $(/etc/zabbix/scripts/aws/aws-sns-without-tag-prd.sh $profile)

#Redis
$zabbix_sender -z  $ip_zabbix_server -s "AWS-$profile" -k aws.redis.without.tag -o $(/etc/zabbix/scripts/aws/aws-redis-without-tag-prd.sh $profile)

#EC2
$zabbix_sender -z  $ip_zabbix_server -s "AWS-$profile" -k aws.ec2.without.tag -o $(/etc/zabbix/scripts/aws/aws-ec2-without-tag-prd.sh $profile)

#EBS
$zabbix_sender -z  $ip_zabbix_server -s "AWS-$profile" -k aws.ebs.without.tag -o $(/etc/zabbix/scripts/aws/aws-ebs-without-tag.sh $profile)
