#!/bin/sh 

# run system update first
sudo apt update && sudo apt upgrade

# package installs

sudo apt install git -y
sudo apt install curl  -y
sudo apt install gh -y
sudo apt install libfuse2 -y
sudo apt install fish -y
sudo apt install gnome-tweaks -y
sudo apt install npm -y
sudo apt install nodejs -y
sudo apt install vlc -y
sudo apt install build-essential -y
sudo apt install helix -y
sudo apt install yarn -y
sudo apt install ripgrep -y
sudo apt install htop -y
sudo apt install vim -y
sudo apt install tldr -y
sudo apt install fonts-jetbrains-mono -y
sudo apt install fonts-cascadia-code -y
sudo apt install qbittorrent -y
sudo apt install fonts-firacode -y
sudo apt install lm-sensors -y
sudo apt install gnome-tweaks -y
sudo apt install zoxide -y

# snap packages
snap install discord
snap install code --classic 

# nordvpn
sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
# starship shell
curl -sS https://starship.rs/install.sh | sh

# brave browser 
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt install brave-browser

# flatpak setup
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# install flatpaks
flatpak install flathub org.wezfurlong.wezterm
flatpak install flathub com.github.geigi.cozy
