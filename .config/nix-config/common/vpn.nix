{ config, pkgs, ... }: {
  networking.openconnect = {
    enable = true;
    user = "wyatta4";
    server = "ramsvpn.vcu.edu";

    # group = "your_group"; 
    # post_connect = "your_post_connect_script";
  };
}
