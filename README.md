# Dotfiles

Configuration files for my Linux Laptop and PC setups

## Installation
Setup instructions for use on NixOS

```sh
nix-shell -p stow git
git clone --recurse-submodules git@github.com/Alw1/dotfiles ~/.dotfiles
cd ~/.dotfiles
stow --adopt */
cd ~/.config/nixos-config

# Make sure to add host directory in the nixos-config folder before building, then execute the below command with the proper host
sudo nixos-rebuild switch --flake .#$HOST
```

## Neovim

`nvim/.config/nvim` is a submodule pointing at
[Alw1/nvim](https://github.com/Alw1/nvim); commit and push it from inside that
directory, then commit the moved pointer here.

## Monitors

The hypr config is shared by every host, so `monitor =` lines are not in it.
Each host declares its own in `nixos-config/.config/nixos-config/hosts/<host>/default.nix`:

```nix
my.desktop.hyprland.monitors = [ "eDP-1,2256x1504@60,0x0,auto" ];
```

That is rendered to `/etc/hypr/monitors.conf`, which `hyprland.conf` sources.
Changing it needs a rebuild.

## Screenshots

| ![Desktop](/assets/desktop.png) | ![Gotop](/assets/gotop.png) |
|---------------------------------|-----------------------------|
| ![Neovim](/assets/neovim.png)   | ![Neovim2](/assets/neovim-open.png) |

