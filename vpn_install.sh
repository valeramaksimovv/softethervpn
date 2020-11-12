#!/bin/bash
# Install update
echo "Install Update & Upgrade..."
apt update && apt -y dist-upgrade
echo "Update & Upgrade installed"

# Add user "softether" and setting passwd
adduser softether
usermod -aG sudo softether

# Reboot server
# reboot 