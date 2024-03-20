#!/bin/sh 

# run system update first
# sudo apt update && sudo apt upgrade

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

/bin/bash -c "$(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)"

atuin login -u wintermute -e hermannkevin@gmail.com
atuin import auto
atuin sync
