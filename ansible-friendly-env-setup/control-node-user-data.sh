#!/bin/bash
sudo amazon-linux-extras install ansible2 -y
sudo useradd ansible
sudo echo ansible:ansible | chpasswd
sudo echo "ansible ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo sed -i "s/.*#PermitRootLogin yes/PermitRootLogin yes/g" /etc/ssh/sshd_config
sudo service sshd restart
sudo -u ansible ssh-keygen -t rsa -f /home/ansible/.ssh/id_rsa -q -N ""
sudo chmod 700 /home/ansible/.ssh
sudo chmod 600 /home/ansible/.ssh/id_rsa
# Array of remote node IP addresses
REMOTE_NODES=("172.31.34.54" "172.31.35.113") # Replace & add more IPs as needed
sudo yum install expect -y
# Loop through each IP address
for REMOTE_NODE in "${REMOTE_NODES[@]}"; do
    expect -c "
    spawn sudo -u ansible ssh-copy-id ansible@$REMOTE_NODE
    expect {
		\"*re you sure you want to continue connecting*\" { send \"yes\r\"; exp_continue }
        \"*pass*\" { send \"ansible\r\"; exp_continue }
        \"*Pass*\" { send \"ansible\r\" }
    }
    expect eof
    "
done
