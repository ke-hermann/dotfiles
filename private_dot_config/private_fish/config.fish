if status is-interactive
    # Commands to run in interactive sessions can go here
end

# abbreviations
# apt / debian / ubuntu
abbr -a aguu 'sudo apt update  && sudo apt upgrade'
abbr -a agr 'sudo apt remove'
abbr -a agi 'sudo apt install -y'


# git 
abbr -a gitscd 'git config credential.helper store'


# aliases 
alias ls='lsd'
alias temacs='emacs -nw'

starship init fish | source

# smarter cd
zoxide init fish | source
