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

  # Several GB once realised, so this stays off unless a host asks for it.
  # Python lives in base.nix instead, since too much tooling assumes it.
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
