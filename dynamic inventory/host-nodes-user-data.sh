#!/bin/bash
# Hardware requirements: AWS Linux 2 with mimum t2.micro type instance & port 8080(application port), 9100 (node-exporter port) should be allowed on the security groups
# setup for the ansible configuration
sudo yum update –y
sudo useradd ansadmin
sudo echo "ansadmin:ansadmin" | chpasswd
sudo sed -i "s/.*PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo sed -i 's/.*#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo echo "%wheel  ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sudo usermod -aG wheel ansadmin
sudo service sshd restart