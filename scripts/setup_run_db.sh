#!/bin/bash

# -----------------------------------------------------------------------------
# Perform one-time setup of the DynamoDB database that is used to store run
# metadata. Requires that the AWS CLI is configured with credientials with 
# sufficient permissions.
# -----------------------------------------------------------------------------

run_table_name="CESM_Runs"
run_update_table_name="CESM_Run_Updates"
instance_table_name="CESM_Instances"

echo "Checking for existing table $run_table_name"
if aws dynamodb describe-table --table-name $run_table_name 2> /dev/null
then
	echo "$run_table_name found; exiting"
else
	echo "$run_table_name not found"
fi

echo "Checking for existing table $instance_table_name"
if aws dynamodb describe-table --table-name $instance_table_name 2> /dev/null
then
	echo "$instance_table_name found; exiting"
else
	echo "$instance_table_name not found"
fi

echo "Creating table $run_table_name"
aws dynamodb create-table \
	--table-name $run_table_name \
	--provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
	--key-schema \
		AttributeName=InstanceId,KeyType=HASH \
		AttributeName=CreatedTime,KeyType=RANGE \
	--attribute-definitions \
		AttributeName=InstanceId,AttributeType=S \
		AttributeName=CreatedTime,AttributeType=S 

echo "Creating table $run_update_table_name"
aws dynamodb create-table \
	--table-name $run_update_table_name \
	--provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
	--key-schema \
		AttributeName=InstanceId,KeyType=HASH \
		AttributeName=CreatedTime,KeyType=RANGE \
	--attribute-definitions \
		AttributeName=InstanceId,AttributeType=S \
		AttributeName=CreatedTime,AttributeType=S 

echo "Creating table $instance_table_name"
aws dynamodb create-table \
	--table-name $instance_table_name \
	--provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
	--key-schema \
		AttributeName=InstanceId,KeyType=HASH \
	--attribute-definitions \
		AttributeName=InstanceId,AttributeType=S \
