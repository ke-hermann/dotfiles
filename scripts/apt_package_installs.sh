#!/bin/sh 

# package installs

sudo apt install git
sudo apt install curl 
sudo apt install gh
sudo apt install libfuse2
sudo apt install fish
sudo apt install gnome-tweaks
sudo apt install npm
sudo apt install nodejs
sudo apt install vlc
sudo apt install build-essential
sudo apt install helix
sudo apt install yarn
sudo apt install ripgrep
sudo apt install htop
sudo apt install vim
sudo apt install tldr
sudo apt install fonts-jetbrains-mono
sudo apt install fonts-cascadia-code
sudo apt install qbittorrent
sudo apt install fonts-firacode
sudo apt install lm-sensors
sudo apt install gnome-tweaks

# snap packages
snap install discord
snap install code --classic 

# nordvpn
sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
# starship shell
curl -sS https://starship.rs/install.sh | sh

# brave browser 
sudo curl -fsSLo /usr/share/keyrings/brave-browser-beta-archive-keyring.gpg https://brave-browser-apt-beta.s3.brave.com/brave-browser-beta-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-beta-archive-keyring.gpg] https://brave-browser-apt-beta.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-beta.list

sudo apt update

sudo apt install brave-browser-beta

# vim plugin manager 
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
