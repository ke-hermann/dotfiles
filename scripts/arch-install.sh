#!/usr/bin/env bash

set -euo pipefail

echo "=== Updating system ==="
sudo pacman -Syu --noconfirm

echo "=== Installing base packages needed for AUR ==="
sudo pacman -S --needed --noconfirm base-devel git curl emacs

echo "=== Installing yay (AUR helper) ==="
if ! command -v yay &>/dev/null; then
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
else
  echo "yay already installed, skipping"
fi

echo "=== Installing Brave browser ==="
yay -S --noconfirm brave-bin

echo "=== Installing NordVPN ==="
yay -S --noconfirm nordvpn-bin
sudo systemctl enable --now nordvpnd

echo "=== Initializing dotfiles with chezmoi ==="
if [ ! -d "$HOME/.local/share/chezmoi" ]; then
  chezmoi init ke-hermann
else
  echo "chezmoi already initialized, skipping"
fi

chezmoi apply

echo "=== Done ==="


