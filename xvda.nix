{ pkgs, lib, fetchFromGitHub, home-manager,... }: { 
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];
  swapDevices = lib.mkForce [ ];
  environment.variables.NIXOS_FLAKE_CONFIGURATION = "xvda";
  boot.loader  = lib.mkDefault  {
    systemd-boot.enable = false;
    grub.enable = true;
    grub.devices =  ["/dev/xvda"] ;
  };
  services.xserver.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
  services.xserver.displayManager.lightdm.enable = true;


}