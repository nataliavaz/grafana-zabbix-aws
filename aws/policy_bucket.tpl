{
    "Version": "2012-10-17",
    "Id": "SSEAndSSLPolicy",
    "Statement": [
        {
            "Sid": "Zabbix Check Encryption",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::{account_number}:user/zabbix.monitor"
            },
            "Action": "s3:GetEncryptionConfiguration",
            "Resource": "arn:aws:s3:::{bucket_name}"
        }
]
}
