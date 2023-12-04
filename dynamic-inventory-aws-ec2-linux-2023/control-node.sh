#!/bin/bash
sudo useradd ansadmin
sudo echo ansadmin:ansadmin | chpasswd
sudo sed -i "s/.*PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo echo "%wheel  ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sudo sed -i 's/.*#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo usermod -aG wheel ansadmin
sudo service sshd restart
sudo yum install ansible -y
sudo ansible-config init --disabled > /etc/ansible/ansible.cfg
sudo yum install python-pip -y
sudo pip install boto3
sudo sed -i "s/.*;host_key_checking=True/host_key_checking=False/g" /etc/ansible/ansible.cfg
sudo sed -i "s/.*;enable_plugins=host_list, script, auto, yaml, ini, toml/enable_plugins=aws_ec2/g" /etc/ansible/ansible.cfg
sudo ansible-galaxy collection install amazon.aws