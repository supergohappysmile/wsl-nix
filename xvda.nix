{ pkgs, lib, fetchFromGitHub, home-manager,... }: { 
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];
  environment.variables.NIXOS_FLAKE_CONFIGURATION = "xvda";
  boot.loader  = lib.mkDefault  {
    systemd-boot.enable = false;
    grub.enable = true;
    grub.devices =  ["/dev/xvda"] ;
  };
  services.xserver.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
  services.xserver.displayManager.lightdm.enable = true;


	boot.kernel.sysctl = {
		"vm.swappiness" = "10"; # https://www.kernel.org/doc/Documentation/sysctl/vm.txt , only swap if needed
	};
	# https://phoenixnap.com/kb/linux-swap-file
# https://search.nixos.org/options?channel=24.05&show=swapDevices&from=0&size=50&sort=relevance&type=packages&query=swap
  # swapDevices = lib.mkForce [ ];
  swapDevices = [
    {
      device = "/__swapfile__";
      size = 1024*8; # in MiB, 8 GiB
      priority = 60;
      # label = "swap";
    }
  ];
}