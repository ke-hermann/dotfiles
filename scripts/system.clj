#!/usr/bin/env bb

(require '[babashka.process :refer [shell process exec]])

(def packages
  ["build-essential",
   "curl",
   "emacs",
   "fish",
   "fonts-cascadia-code",
   "fonts-firacode",
   "fonts-jetbrains-mono",
   "gh",
   "git",
   "gnome-tweaks",
   "htop",
   "libfuse2",
   "lm-sensors",
   "nodejs",
   "npm",
   "qbittorrent",
   "ripgrep",
   "tldr",
   "vim",
   "vlc",
   "yarn",
   "zoxide",
   "zsh",
   "neofetch",
   "alacritty",
   "blueman",
   "firefox",
   "kitty",
   "neovim",
   "tmux",
   "snapd",
   "flatpak"])

(defn install-packages []
  (doseq [p packages]
    (shell "sudo" "apt" "install" p)))

(install-packages)
