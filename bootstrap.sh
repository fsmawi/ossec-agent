#!/bin/bash

[[ -z "${OSSEC_STACK_STAGE}" ]] && OSSEC_BUCKET='pipeline-ossec-config-prod' || OSSEC_BUCKET="pipeline-ossec-config-${OSSEC_STACK_STAGE}"

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
ansible-playbook -vvv -i inventory playbook.yml --extra-vars "ossec_server_name=${OSSEC_SERVER_IP} ossec_server_fqdn=${OSSEC_SERVER_FQDN}"



export S3_BUCKET="s3://pipeline-ossec-config-${STACK}"

aws s3 cp "s3://pipeline-ossec-config-${STACK}/id_ossec_agent" ~/.ssh/