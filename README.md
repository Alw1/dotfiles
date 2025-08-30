# Dotfiles

Configuration files for my Linux Laptop and PC setups

## Installation
Setup instructions for use on NixOS

```sh
nix-shell -p stow git
git clone git@github.com/Alw1/dotfiles ~/.dotfiles
cd ~/.dotfiles
stow --adopt */
cd ~/.config/nixos-config

# Make sure to add host directory in the nixos-config folder before building, then execute the below command with the proper host
sudo nixos-rebuild switch --flake .#$HOST --experimental-features 'nix-command flakes'
```

## Screenshots

| ![Desktop](/assets/desktop.png) | ![Gotop](/assets/gotop.png) |
|---------------------------------|-----------------------------|
| ![Neovim](/assets/neovim.png)   | ![Neovim2](/assets/neovim-open.png) |

