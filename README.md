1- download ssh key

2- config inventory
cp inventory.example inventory
sed -i "s/REMOTE_HOST_IP/10.0.0.100/g" inventory
sed -i "s/REMOTE_HOST_USERNAME/vagrant/g" inventory

3- run ansible playbook
ansible-playbook -vvv -i inventory playbook.yml --extra-vars "ossec_server_fqdn=10.0.0.100"
