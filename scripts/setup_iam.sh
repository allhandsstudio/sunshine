#!/bin/bash

aws iam create-role --role-name sunshine-executor --assume-role-policy-document file://ec2-role-trust-policy.json

aws iam put-role-policy --role-name sunshine-executor --policy-name S3-Permissions --policy-document file://ec2-role-s3-access-policy.json
aws iam put-role-policy --role-name sunshine-executor --policy-name Dynamo-Permissions --policy-document file://ec2-role-dynamo-access-policy.json

aws iam create-instance-profile --instance-profile-name Sunshine-Executor
aws iam add-role-to-instance-profile --instance-profile-name Sunshine-Executor --role-name sunshine-executor
