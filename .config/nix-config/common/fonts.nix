{pkgs, ...}:
{
	fonts.packages = with pkgs; [
		intel-one-mono 
		nerdfonts
		font-awesome
		monaspace
	];
}
