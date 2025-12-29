{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableLsColors = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      system-update = "nix flake update --flake ~/.config/nixos-config";
	  system-update-alt = ''nix flake lock \
							  --update-input home-manager \
							  --update-input nixpkgs \
							  --update-input nixpkgs-unstable --flake ~/.config/nixos-config'';
      system-upgrade =
        "sudo nixos-rebuild switch --flake ~/.config/nixos-config#$HOST";
    };
  };
}
