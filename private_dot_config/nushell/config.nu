# ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
#██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
#██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
#██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
#╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
# ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 
                                               

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

$env.config = { show_banner: false }
$env.EDITOR = "nvim"
source ~/.zoxide.nu

$env.config.shell_integration.osc133 = false


#███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
#██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
#█████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
#██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
#██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
#╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
                                                                          

def wrap-file [filepath: path] {
    # Get the file's parent directory and stem (filename without extension)
    let parent = $filepath | path dirname
    let stem = $filepath | path parse | get stem
    let extension = $filepath | path parse | get extension
    
    # Construct the new directory path
    let new_dir = $parent | path join $stem
    
    # Create the directory
    mkdir $new_dir
    
    # Move the file into the new directory
    mv $filepath $new_dir
    
    print $"Wrapped ($filepath) into ($new_dir)/"
}
