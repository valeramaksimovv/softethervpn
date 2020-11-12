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
usermod -aG sudo softether

# Reboot server
# reboot 