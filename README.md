## download and configure ssh key

## config inventory
`cp inventory.example inventory`
`sed -i "s/REMOTE_HOST_IP/10.0.0.100/g" inventory`
`sed -i "s/REMOTE_HOST_USERNAME/centos/g" inventory`

## run ansible playbook
`ansible-playbook -vvv -i inventory playbook.yml --extra-vars "ossec_server_fqdn=10.0.0.100 ossec_server_fqdn=10.0.0.100"`
