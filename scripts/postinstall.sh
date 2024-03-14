#!/bin/sh 

# run system update first
# sudo apt update && sudo apt upgrade

# package installs

sudo pacman -S build-essential -y
sudo pacman -S curl -y
sudo pacman -S emacs -y
sudo pacman -S fish -y
sudo pacman -S fonts-cascadia-code -y
sudo pacman -S fonts-firacode -y
sudo pacman -S fonts-jetbrains-mono -y
sudo pacman -S gh -y
sudo pacman -S git -y
sudo pacman -S gnome-tweaks -y
sudo pacman -S gnome-tweaks -y
sudo pacman -S helix -y
sudo pacman -S htop -y
sudo pacman -S libfuse2 -y
sudo pacman -S lm-sensors -y
sudo pacman -S nodejs -y
sudo pacman -S npm -y
sudo pacman -S qbittorrent -y
sudo pacman -S ripgrep -y
sudo pacman -S tldr -y
sudo pacman -S vim -y
sudo pacman -S vlc -y
sudo pacman -S yarn -y
sudo pacman -S zoxide -y
sudo pacman -S zsh -y
sudo pacman -S neofetch -y
sudo pacman -S atuin -y
sudo pacman -S lazygit -y

# nordvpn
sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
# starship shell
curl -sS https://starship.rs/install.sh | sh

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

# change system editor to vim
sudo update-alternatives --set editor /usr/bin/vim.basic

atuin login -u wintermute -e hermannkevin@gmail.com
atuin import auto
atuin sync
