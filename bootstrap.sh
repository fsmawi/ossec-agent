#!/bin/bash

OSSEC_BUCKET='s3://pipeline-ossec-config-prod'
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --output text --query 'Account')

if [[ $AWS_ACCOUNT_ID = "672327909798" ]]; then
    OSSEC_BUCKET='s3://pipeline-ossec-config-dev'
fi

HOST_IP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)

# Configure SSH key.
aws s3 cp ${OSSEC_BUCKET}/id_ossec_agent ~/.ssh/
chmod 600 ~/.ssh/id_ossec_agent

## Get server information
aws s3 cp ${OSSEC_BUCKET}/ossec-server.config .
source ossec-server.config

## Config inventory file.
cp inventory.example inventory
sed -i "s/REMOTE_HOST_IP/${OSSEC_SERVER_IP}/g" inventory
sed -i "s/REMOTE_HOST_USERNAME/centos/g" inventory

## Run ansible playbook.
ansible-playbook -vvv -i inventory playbook.yml --extra-vars "ossec_server_ip=${OSSEC_SERVER_IP} ossec_server_fqdn=${OSSEC_SERVER_FQDN} ossec_agent_public_ip=${HOST_IP}"