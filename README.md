# Dotfiles

Configuration files for my Linux Laptop and PC setups, managed with
[GNU Stow](https://www.gnu.org/software/stow/).

## Installation

Setup instructions for use on NixOS

```sh
nix-shell -p stow git
git clone git@github.com/Alw1/dotfiles ~/.dotfiles
cd ~/.dotfiles
stow --adopt --ignore='\.claude' */

cd ~/.config/nixos-config
# Make sure to add host directory in the nixos-config folder before building,
# then execute the below command with the proper host
sudo nixos-rebuild switch --flake .#$HOST
```

## Adding files

Each top-level directory is a stow package whose contents mirror `$HOME`:
`zsh/.zshrc` → `~/.zshrc`, `kitty/.config/kitty/` → `~/.config/kitty/`.
Add a new file by putting it at the matching path inside its package and
re-running `stow <package>`.

`~/.config/nixos-config` and `~/Pictures/Wallpapers` are whole-directory
symlinks (stow folding), so new files there are picked up automatically.

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
