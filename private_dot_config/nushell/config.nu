mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

$env.config = { show_banner: false }
$env.EDITOR = "nvim"
source ~/.zoxide.nu

$env.config.shell_integration.osc133 = false


