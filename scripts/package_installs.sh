#!/bin/sh 

# package installs
sudo dnf install git -y
sudo dnf install curl  -y
sudo dnf install gh -y
sudo dnf install libfuse2 -y
sudo dnf install fish -y
sudo dnf install gnome-tweaks -y
sudo dnf install npm -y
sudo dnf install nodejs -y
sudo dnf install vlc -y
sudo dnf install build-essential -y
sudo dnf install helix -y
sudo dnf install yarn -y
sudo dnf install ripgrep -y
sudo dnf install htop -y
sudo dnf install vim -y
sudo dnf install tldr -y
sudo dnf install fonts-jetbrains-mono -y
sudo dnf install fonts-cascadia-code -y
sudo dnf install qbittorrent -y
sudo dnf install fonts-firacode -y
sudo dnf install lm-sensors -y
sudo dnf install gnome-tweaks -y

# nordvpn
sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
# starship shell
curl -sS https://starship.rs/install.sh | sh


# flatpak setup
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# install flatpaks
flatpak install flathub org.wezfurlong.wezterm
flatpak install flathub com.github.geigi.cozy
flatpak install flathub md.obsidian.Obsidian
flatpak install flathub com.logseq.Logseq
flatpak install flathub com.brave.Browser
