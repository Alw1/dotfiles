{ pkgs, ... }: {
  users.users.alex = {
    isNormalUser = true;
    description = "Alex Wyatt";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "plugdev" "light" "audio" ];
  };
}
