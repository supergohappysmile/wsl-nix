{	config,lib, pkgs,... }:

{
	imports = [
    ../home.nix
	];
	home ={
		username = "nixos";
		homeDirectory = "/home/nixos";
		stateVersion = "24.11";
	};
	home.file = { # starts at ~/.config
	};
	home.packages = with pkgs; [

		gnupg # gpg

	];
	home.sessionVariables = {

	};



}