#!/usr/bin/env bb

(require '[babashka.process :refer [shell process exec]])

(def packages
  ["fonts-inter"
   "leiningen"
   "fonts-firacode"
   "flatpak"
   "black"
   "cloc"
   "tokei"
   "golang-1.22-go"
   "python3-pylsp"
   "transmission-gtk"
   "build-essential" 
   "curl"
   "brave-browser"
   "go"
   "fonts-jetbrains-mono"
   "vim"
   "flatpak"
   "curl"
   "chezmoi"
   "curl"
   "flatpak"
   "vim"])

(defn install-packages []
  (doseq [p packages]
    (shell "sudo" "apt" "install" p)))

(install-packages)
