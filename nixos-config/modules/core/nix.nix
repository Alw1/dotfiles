{ inputs, ... }:
{
  nixpkgs = {
    overlays = import ../../overlays { inherit inputs; };
    config.allowUnfree = true;
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
