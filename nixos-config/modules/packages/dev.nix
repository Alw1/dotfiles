{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.packages.dev;
in
{
  options.my.packages.dev.enable = lib.mkEnableOption "language toolchains and compilers";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cabal-install
      cargo
      clang
      gcc
      ghc
      gnumake
      go
      haskell-language-server
      jdk
      julia
      nodejs
      pkg-config
      rustc
      rustfmt
    ];
  };
}
