#!/bin/bash
echo "**** Begin installing Ubuntu, etc"

sudo apt update
sudo apt upgrade -y

echo "**** Begin installing ubuntu-desktop"
sudo apt install ubuntu-desktop -y
sudo timedatectl set-timezone Europe/Amsterdam
echo "**** End installing ubuntu-desktop"

echo "**** Begin installing Visual Studio Code"
#Install the apt repository and signing key to enable auto-updating using the system's package manager
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

#Update the package cache and install the package
sudo apt install apt-transport-https
sudo apt update
sudo apt install code
echo "**** End installing Visual Studio Code"

echo "**** Begin installing Node.js"
# Using Ubuntu
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
echo "**** End installing Node.js"

echo "**** Begin installing Terraform"
#Ensure that your system is up to date and you have installed the gnupg, software-properties-common, and curl packages installed. You will use these packages to verify HashiCorp's GPG signature and install HashiCorp's Debian package repository.
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
#Install the HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
#Verify the key's fingerprint
sudo gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
#Add the official HashiCorp repository to your system. The lsb_release -cs command finds the distribution release codename for your current system, such as buster, groovy, or sid.
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
#Download the package information from HashiCorp
sudo apt update
#Install Terraform from the new repository
sudo apt-get install terraform
#Verify the installation
terraform -help
#Enable tab completion
touch ~/.bashrc
#Then install the autocomplete package
terraform -install-autocomplete
echo "**** End installing Terraform"

echo "**** Begin installing Azure CLI"
# Get packages needed for the install process
sudo apt-get update
sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg
#Download and install the Microsoft signing key
sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg
#Add the Azure CLI software repository
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list
#Update repository information and install the azure-cli package
sudo apt-get update
sudo apt-get install azure-cli
echo "**** End installing Azure CLI"

echo "**** End installing Ubuntu, etc"
