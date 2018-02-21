# This template is for bootstrapping a node from itself, admin.pem and chef validator.pem have to copied from your chef server

#sudo openvpn --config /root/<certficiate-name>.ovpn &
curl -L https://www.chef.io/chef/install.sh | sudo bash -s -- -v 12.8.1
#sudo knife configure initial
mkdir /home/ec2-user/.chef
cat > /home/ec2-user/.chef/knife.rb << "EOF"
log_level                :info
log_location             STDOUT
node_name                'admin'
client_key               '/home/ec2-user/.chef/admin.pem'
validation_client_name   'chef-validator'
validation_key           '/etc/chef-server/chef-validator.pem'
#chef_server_url          'https://<ip>:443'
chef_server_url          'https://<chef-srvr-hostname>:443'
syntax_check_cache_path  '/home/ec2-user/syntax_check_cache'
knife[:editor]=          '/bin/vi'
EOF
cat > /home/ec2-user/.chef/admin.pem << "EOF"
----RSA PRIVATE KEY-----
EOF
sudo knife ssl fetch
sudo -- sh -c -e "echo '<chef server ip>  <chef server FQDN' >> /etc/hosts"
cat > /home/ec2-user/.ssh/ec2-pri.pem << "EOF"
----RSA PRIVATE KEY-----
EOF
chmod 400 /home/ec2-user/.ssh/ec2-pri.pem
sudo knife ssl fetch
ip_address=$(ip a s|grep "scope global eth0"|tr ' ' '|'|cut -f6 -d'|'|cut -f1 -d'/')
sudo knife bootstrap $ip_address -N $1 -E <env name> -r 'recipe[<base recipe like setting hostnames>]' -x ec2-user -i .ssh/ec2-pri.pem --sudo
