{pkgs, config, ...}:
let 
	user = "alex";
in {
	users.users.${user} = {
		isNormalUser = true;
		description = "Alex Wyatt";
		shell = pkgs.zsh;
		extraGroups = [ "networkmanager" "wheel" "libvirtd" "plugdev" ];
	};
}
