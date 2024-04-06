#!/bin/sh 

# git identity setup
git config --global user.name "Kevin Hermann"
git config --global user.email "hermannkevin@gmail.com"

# Github CLI setup 
gh auth login

# Lazygit, powerful terminal ui interface
sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit
