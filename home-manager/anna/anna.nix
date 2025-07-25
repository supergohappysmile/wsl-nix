{	config,lib, pkgs,... }:
{
	imports = [
		../home.nix
		./vscodium.nix
		./ssh.nix
		./git.nix
		./firefox.nix
		./annaShell.nix
	];
			nixpkgs.config.allowUnfree=true;

	home ={
		username = "anna";
		homeDirectory = "/home/anna";
		stateVersion = "24.11";
	};
	home.file = { # starts at ~/.config

};
	home.packages = with pkgs; [
		gnupg # gpg
		direnv
	];
	home.sessionVariables = {
	};
}