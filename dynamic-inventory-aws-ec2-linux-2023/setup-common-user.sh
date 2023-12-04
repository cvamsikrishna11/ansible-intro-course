#!/bin/bash
# Hardware requirements: AWS EC2 Linux 2023
sudo yum update –y
sudo useradd ansadmin
sudo echo "ansadmin:ansadmin" | chpasswd
sudo sed -i "s/.*PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo sed -i 's/.*#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo echo "%wheel  ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sudo usermod -aG wheel ansadmin
sudo service sshd restart