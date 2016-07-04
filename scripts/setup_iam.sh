#!/bin/bash

aws iam create-role --role-name s3access --assume-role-policy-document file://ec2-role-trust-policy.json
aws iam put-role-policy --role-name s3access --policy-name S3-Permissions --policy-document file://ec2-role-access-policy.json
aws iam create-instance-profile --instance-profile-name S3-Permissions
aws iam add-role-to-instance-profile --instance-profile-name S3-Permissions --role-name s3access
