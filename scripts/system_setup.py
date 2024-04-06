from pathlib import Path
import argparse
import subprocess
import os


PACKAGE_MANAGER = "dnf"
SCRIPT_DIR = Path.home() / "scripts" / "custom"

PACKAGES = [
    "build-essential",
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
    "flatpak",
]

FLATPAKS = ["wezterm", "cozy"]
SNAPS = []


class NoValidPackageManager(Exception):
    pass


class Installer:

    def __init__(self) -> None:
        self.pkg_cmd = []
        self._set_package_command()

    def _set_package_command(self):
        if PACKAGE_MANAGER == "apt":
            self.pkg_cmd = ["sudo", "apt", "install"]
        elif PACKAGE_MANAGER == "dnf":
            self.pkg_cmd = ["sudo", "dnf", "in"]
        elif PACKAGE_MANAGER == "pacman":
            self.pkg_cmd = ["sudo", "pacman", "-S"]
        elif PACKAGE_MANAGER == "zypper":
            self.pkg_cmd = ["sudo", "zypper", "in"]

        else:
            raise NoValidPackageManager("no valid package manager specified")

    def install_package(self, package):
        proc = self.pkg_cmd[:]
        proc.append(package)
        proc.append("-y")
        subprocess.run(proc)

    def install_all_packages(self):
        for package in PACKAGES:
            self.install_package(package)

    def install_flatpaks(self):
        for package in FLATPAKS:
            proc = ["flatpak", "install", package]
            subprocess.run(proc)

    def install_snaps(self):
        for package in SNAPS:
            proc = ["sudo", "snap", "install", package]
            subprocess.run(proc)

    def run_scripts(self):
        shell = os.environ["SHELL"]
        for script in SCRIPT_DIR.iterdir():
            print(script)
            subprocess.call([shell, script])


if __name__ == "__main__":

    # cli arguments
    parser = argparse.ArgumentParser(description="A poor man's setup automation tool.")
    parser.add_argument("--snaps", action="store_true", help="only install snaps.")
    parser.add_argument(
        "--flatpaks", action="store_true", help="only install flatpaks."
    )
    parser.add_argument("--pkgs", action="store_true", help="only install packages.")
    args = parser.parse_args()

    installer = Installer()

    if args.snaps:
        installer.install_snaps()
    elif args.flatpaks:
        installer.install_flatpaks()
    elif args.pkgs:
        installer.install_all_packages()
    # if no cli argument is given, just run everything.
    else:
        installer.run_scripts()
        installer.install_all_packages()
        installer.install_flatpaks()
        installer.install_snaps()
