#!/bin/bash
sudo useradd ansible
sudo echo ansible:ansible | chpasswd
sudo echo "ansible ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo sed -i "s/.*#PermitRootLogin yes/PermitRootLogin yes/g" /etc/ssh/sshd_config
sudo service sshd restart