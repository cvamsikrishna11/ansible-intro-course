#!/bin/bash
# Script to setup ansible tower in Red Hat Enterprise Linux 8, with t2.xlarge machine!
set -e

sudo yum install wget -y

wget https://releases.ansible.com/ansible-tower/setup/ansible-tower-setup-latest.tar.gz

tar xvzf ansible-tower-setup-latest.tar.gz

sudo sed -i "s/^admin_password=''$/admin_password='ansible'/" ansible-tower-setup-*/inventory

sudo sed -i "s/^pg_password=''$/pg_password='ansible'/" ansible-tower-setup-*/inventory

sudo sh -c "cd /ansible-tower-setup-*/ && ./setup.sh"