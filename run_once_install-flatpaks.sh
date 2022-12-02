#!/bin/sh 

#flatpak setup 

if [[ $PRETTY_NAME =~ "Ubuntu" ]]; then 
    sudo apt install gnome-software-plugin-flatpak -y
fi 
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


flatpak install flathub md.obsidian.Obsidian -y
flatpak install flathub com.github.hugolabe.Wike -y
flatpak install flathub de.gunibert.Hackgregator -y
