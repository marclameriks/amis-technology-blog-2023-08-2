#!/bin/bash
echo "**** Begin preparations for installing VBoxGuestAdditions"

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y build-essential module-assistant
sudo m-a prepare
#cd /media/vagrant/VBox_GAs_7.0.8
#sudo sh ./VBoxLinuxAdditions.run

echo "**** End preparations for installing VBoxGuestAdditions"
