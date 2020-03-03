#!/bin/bash

set -e

stackup="docker run --rm \
-v `pwd`:/cwd \
-e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN \
-e AWS_DEFAULT_REGION -e AWS_REGION \
realestate/stackup:latest"


command="$stackup demo-vpc-endpoints-with-ec2 up -t cfn_templates/demo.yml  --tags cfn_templates/tags.yml"
echo $command
eval $command