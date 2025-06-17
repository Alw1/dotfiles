{ ... }:

{
	programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableLsColors = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        system-update = ''nix flake update --flake ~/nix-config'';
        system-upgrade = ''sudo nixos-rebuild switch --flake ~/nix-config#$HOST'';
      };
    };
}
