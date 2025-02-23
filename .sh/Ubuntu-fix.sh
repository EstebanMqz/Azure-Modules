W#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# Update package list and upgrade all packages
echo "Updating package list and upgrading all packages..."
sudo apt-get update && sudo apt-get upgrade -y

# Fix broken dependencies
echo "Fixing broken dependencies..."
sudo apt-get install -f

# Clean up unnecessary files
echo "Cleaning up unnecessary files..."
sudo apt-get autoremove -y
sudo apt-get autoclean -y

# Check and repair the file system
echo "Checking and repairing the file system..."
sudo fsck -Af -M

# Reconfigure all packages
echo "Reconfiguring all packages..."
sudo dpkg --configure -a

# Check for and remove any held packages
echo "Checking for and removing any held packages..."
sudo apt-get dist-upgrade -y

# Ensure essential services are running
echo "Ensuring essential services are running..."
sudo systemctl restart networking
sudo systemctl restart NetworkManager
sudo systemctl restart ssh

# Update the GRUB bootloader
echo "Updating the GRUB bootloader..."
sudo update-grub

# Reboot the system
echo "Rebooting the system to apply changes..."
sudo reboot

echo "Ubuntu system fix completed."