#!/bin/sh 

# run system update first
# sudo apt update && sudo apt upgrade

# nordvpn
sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
# starship shell
curl -sS https://starship.rs/install.sh | sh

# zsh setup 
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions

git clone https://github.com/olets/zsh-abbr ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-abbr

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

# Lazygit
sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit
