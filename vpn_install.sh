#!/bin/bash
# Install update & upgrade & MC
echo "Install Update & Upgrade..."
apt update && apt -y dist-upgrade
echo "Update & Upgrade installed"
echo "Install MC"
apt install mc
echo "MC installed"

# Add user "softether" and setting passwd
adduser softether
echo "user softether add"
usermod -aG sudo softether

# Reboot server
# reboot 

# SWAP setting
echo "swap configure"
sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

echo "sysctl vm.swappiness=10"
sudo sysctl vm.swappiness=10
echo "sysctl vm.vfs_cache_pressure=50"
sudo sysctl vm.vfs_cache_pressure=50

echo "vm.swappiness = 10" >> /etc/sysctl.conf
echo "vm.vfs_cache_pressure=50" >> /etc/sysctl.conf

# Install fail2ban which will block brute force attacks
echo "install fail2ban"
sudo apt -y install fail2ban
echo "fail2ban installed"

# Ensure that firewall is only allowing the ports that we need
echo "add rules firewall"
echo "Managments ports 443, 992, 1194, 5555"
echo "vpn ports 500/udp, 1701/udp, 4500/udp, 1723/tcp"

sudo ufw allow OpenSSH
echo "ufw allow OpenSSH"
sudo ufw allow 443
echo "ufw allow 443"
sudo ufw allow 992
echo "ufw allow 992"
sudo ufw allow 1194
echo "ufw allow 1194"
sudo ufw allow 5555
echo "ufw allow 5555"
sudo ufw allow 500/udp
echo "ufw allow 500/udp"
sudo ufw allow 1701/udp
echo "ufw allow 1701/udp"
sudo ufw allow 4500/udp
echo "ufw allow 4500/udp"
sudo ufw allow 1723/tcp
echo "ufw allow 1723/tcp"

# Enable the firewall
echo "enable firewall"
sudo ufw enable

# Test it
echo "firewall status"
sudo ufw status

# SoftEther Server Installation
echo "Install SoftEtherServer"
sudo apt-add-repository -y ppa:paskal-07/softethervpn 
sudo apt update 
sudo apt -y install softether-vpnserver
echo "SoftEtherServer installed"

# start the SoftEther VPN server

echo "start the SoftEther VPN server"
sudo service softether-vpnserver start

echo "SoftEther VPN server READY"