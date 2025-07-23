{	config,lib, pkgs,... }:
{
	imports = [
		../home.nix
		./vscodium.nix
		./ssh.nix
		./git.nix
	];
	home ={
		username = "anna";
		homeDirectory = "/home/anna";
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