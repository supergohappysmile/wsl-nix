{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    # <nixos-wsl/modules>
  ];

  # https://nix-community.github.io/NixOS-WSL/options.html
	wsl = {
		enable = true;
		defaultUser = "anna";
		wslConf.user.default = "anna";
		startMenuLaunchers = true;
	};
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
  users = 
	 {
		mutableUsers = true; # let's you change the passwords after btw
		users = {
			# TODO fix up whatever wsl inital config does to root user. Changing stuff broke this
		nixos = lib.mkForce { # TODO think i need this guy for nixos wsl module to work
				# hash a password with mkpasswd -m sha-512, or with -s $SALT
				isNormalUser = true;
				group = "users";
				description = "nixos";
				shell=pkgs.zsh;
				useDefaultShell = true; # should be zsh
				extraGroups = [ 
					"networkmanager"
					"wheel" 
					];
				packages = with pkgs; [
					zsh
				];
			};
			anna = lib.mkForce {
				# hash a password with mkpasswd -m sha-512, or with -s $SALT
				isNormalUser = true;
				group = "users";
				description = "anna";
				shell=pkgs.zsh;
				useDefaultShell = true; # should be zsh
				extraGroups = [ 
					"networkmanager"
					"wheel" 
					];
				packages = with pkgs; [
					zsh
				];
			};
		};
		};
			programs.zsh.enable = true;
	environment.systemPackages = with pkgs; [
		vim # text editor, worse
		nano # text editor
		baobab # disk usage analyzer
		nmap # network scanner
	];
  system.stateVersion = "24.11"; # Did you read the comment?
}
