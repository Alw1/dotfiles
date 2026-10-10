# Dotfiles

Configuration files for my Linux Laptop and PC setups, managed with
[GNU Stow](https://www.gnu.org/software/stow/).

## Installation

Setup instructions for use on NixOS

```sh
nix-shell -p stow git
git clone git@github.com/Alw1/dotfiles ~/.dotfiles
cd ~/.dotfiles
stow --adopt */

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
symlinks, so new files there are picked up automatically.

## Screenshots

| ![Desktop](/assets/desktop.png) | ![Gotop](/assets/gotop.png) |
|---------------------------------|-----------------------------|
| ![Neovim](/assets/neovim.png)   | ![Neovim2](/assets/neovim-open.png) |
