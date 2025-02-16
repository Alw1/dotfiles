{ pkgs, config, inputs, ... }: with pkgs;
let programs = {
	  cliPrograms = [
		hyfetch
		gotop
		tree
		stow
		zip 
		unzip
		xz
	  ];
	  programmingUtils = [
		vim 
		vscode
		git
		gnumake
		gcc
		ghc
		go
		jdk
		rustc
		python3
		nodejs
		cargo
		cabal-install
	];
	neovimUtils = [
		neovim
		rust-analyzer
		ripgrep
		haskell-language-server
	];
	video = [
		vlc
	];
	miscPrograms = [
		spotify
		mongodb-compass
		mongosh
		mongodb-tools
		discord
		gnome-boxes
		openconnect
		melonDS
		snes9x
	];
};
in {
	nixpkgs.config.allowUnfree = true;
	environment.systemPackages = lib.concatLists (lib.attrValues programs);
}
