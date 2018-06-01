1- download ssh key

2- config inventory
cp inventory.example inventory
sed -i "s/REMOTE_HOST_IP/10.0.0.100/g" inventory
sed -i "s/REMOTE_HOST_USERNAME/vagrant/g" inventory
