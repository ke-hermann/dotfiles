# set prompt
starship init fish | source

# opam configuration
source /home/kevin/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
zoxide init --cmd cd fish | source
# improved and synced shell history completion
atuin init fish | source


set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/kevinh/.ghcup/bin $PATH # ghcup-env