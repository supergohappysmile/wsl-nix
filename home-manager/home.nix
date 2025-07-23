{	config,lib, pkgs,... }:
{
	home.sessionVariables = {
		EDITOR = "nano";
	};

	fonts.fontconfig.enable = true;

	home.packages = with pkgs; [
		htop # system monitor
		git # version control
		(python3.withPackages (python-pkgs: [
			python-pkgs.pandas
			python-pkgs.numpy
		]))
		wget # for downloading files
		nix-index # for nix search
		(pkgs.nerdfonts.override { fonts=["DroidSansMono" ]; }) # for vscode
		];

}