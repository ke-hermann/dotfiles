#!/bin/sh

source /etc/os-release
if [[ $PRETTY_NAME =~ "Fedora" ]]; then 
    sudo dnf install -y snapd;
    sudo ln -s /var/lib/snapd/snap /snap;
fi

snap install code --classic
snap install bitwarden
snap install spotify 
snap install telegram-desktop
snap install discord
