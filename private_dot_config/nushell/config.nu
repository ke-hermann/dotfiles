$env.path ++= ["~/bin"]

mkdir ($nu.data-dir | path join "vendor/autoload")

$env.config = {
  buffer_editor: "nvim",
  show_banner: false
}

alias ls = lsd

starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
source ~/.zoxide.nu
