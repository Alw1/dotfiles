{ ... }:
{
  # One module per package group. `base.nix` is unconditional; every other
  # group is opt-in via `my.packages.<name>.enable`, so storage constrained
  # hosts only pay for what they ask for.
  imports = [
    ./base.nix
    ./dev.nix
  ];
}
