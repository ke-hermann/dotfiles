#!/bin/sh 

# nordvpn
sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
# starship shell
curl -sS https://starship.rs/install.sh | sh

# terminal setup 
bash -c  "$(wget -qO- https://git.io/vQgMr)"

# change system editor to vim
sudo update-alternatives --set editor /usr/bin/vim.basic

/bin/bash -c "$(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)"

atuin login -u wintermute -e hermannkevin@gmail.com
atuin import auto
atuin sync

