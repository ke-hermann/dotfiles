if status is-interactive
    # Commands to run in interactive sessions can go here
end

# abbreviations
# apt / debian / ubuntu
abbr -a aguu 'sudo apt update  && sudo apt upgrade'
abbr -a agr 'sudo apt remove'
abbr -a agi 'sudo apt install -y'
# opensuse / zypper
abbr -a zin  'sudo zypper in -y'
abbr -a zup  'sudo zypper dup'
abbr -a zdel  'sudo zypper remove'
abbr -a zfd  'zypper search'
# fedora 
abbr -a dnfi 'sudo dnf install -y'
abbr -a dnfr 'sudo dnf remove'
abbr -a dnfu 'sudo dnf upgrade'
abbr -a dnfs 'dnf search'
# fedora 
abbr -a pacin 'sudo pacman -S'
abbr -a pacrm 'sudo pacman -Rs'
abbr -a pacup 'sudo pacman -Syu'
abbr -a pacfd 'sudo pacman -Ss'

# git 
abbr -a gitscd 'git config credential.helper store'

# aliases 
alias ls='lsd'
alias temacs='emacs -nw'

# customized prompt
# oh-my-posh init fish --config ~/.ohmyposh.json | source
starship init fish | source
# smarter cd
zoxide init fish | source
