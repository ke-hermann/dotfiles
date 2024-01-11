#!/bin/sh 

# run system update first
# sudo apt update && sudo apt upgrade

# package installs

sudo apt install build-essential -y
sudo apt install curl -y
sudo apt install emacs -y
sudo apt install fish -y
sudo apt install fonts-cascadia-code -y
sudo apt install fonts-firacode -y
sudo apt install fonts-jetbrains-mono -y
sudo apt install gh -y
sudo apt install git -y
sudo apt install gnome-tweaks -y
sudo apt install gnome-tweaks -y
sudo apt install helix -y
sudo apt install htop -y
sudo apt install libfuse2 -y
sudo apt install lm-sensors -y
sudo apt install nodejs -y
sudo apt install npm -y
sudo apt install qbittorrent -y
sudo apt install ripgrep -y
sudo apt install tldr -y
sudo apt install vim -y
sudo apt install vlc -y
sudo apt install yarn -y
sudo apt install zoxide -y
sudo apt install zsh -y
sudo apt install neofetch -y

# snap packages
snap install code --classic 

# nordvpn
sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
# starship shell
curl -sS https://starship.rs/install.sh | sh

# flatpak setup
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# install flatpaks
flatpak install flathub org.wezfurlong.wezterm
flatpak install flathub com.github.geigi.cozy

# antidote, zsh plugin manager 
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote

# git identity setup
git config --global user.name "Kevin Hermann"
git config --global user.email "hermannkevin@gmail.com"

# terminal setup 
bash -c  "$(wget -qO- https://git.io/vQgMr)"

# vim plug 
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# change system editor to vim
sudo update-alternatives --set editor /usr/bin/vim.basic

# homebrew on linux
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# TUI git app
brew install jesseduffield/lazygit/lazygit

# atuin setup; improved shell history and cross device sync
bash (curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh | psub)

atuin login -u wintermute -e hermannkevin@gmail.com
atuin import auto
atuin sync
