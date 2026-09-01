# Dotfiles

Configuration files for my Linux Laptop and PC setups, managed with
[chezmoi](https://www.chezmoi.io/).

## Installation

Setup instructions for use on NixOS

```sh
nix-shell -p chezmoi git
git clone git@github.com/Alw1/dotfiles ~/.dotfiles
chezmoi init --source=~/.dotfiles
chezmoi apply

cd ~/.config/nixos-config
# Make sure to add host directory in the nixos-config folder before building,
# then execute the below command with the proper host
sudo nixos-rebuild switch --flake .#$HOST
```

## Adding files

Managed files in `$HOME` are symlinks into this repo, so editing one edits the
repo directly. Adding a new file can be done by running this command:

```sh
chezmoi add ~/.config/kitty/new-file.conf
```

Source names map to targets by prefix: `dot_zshrc` → `~/.zshrc`,
`private_dot_config/<app>/` → `~/.config/<app>/`.

`~/.config/nixos-config` and `~/Pictures/Wallpapers` are whole-directory
symlinks, so new files there are picked up automatically with no `chezmoi add`.

## Screenshots

| ![Desktop](/assets/desktop.png) | ![Gotop](/assets/gotop.png) |
|---------------------------------|-----------------------------|
| ![Neovim](/assets/neovim.png)   | ![Neovim2](/assets/neovim-open.png) |
