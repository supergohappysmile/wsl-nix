#  access your package set through nix build, shell, run, etc this flake
{
  description = "precious config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # WSL 
    # https://github.com/nix-community/NixOS-WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = { self, 
  nixpkgs, 
  nixpkgs-unstable,
  nixos-wsl,
  home-manager,  ... }@inputs:

    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
      ];
    in
    rec {


      myPkgs = forAllSystems (system:
        import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );
      myPkgsUnstable = forAllSystems (system:
        import inputs.nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        }
      );
      # vimjoyer iso nonsense https://www.youtube.com/watch?v=-G8mN6HJSZE&



      nixosConfigurations = {
        # https://github.com/nix-community/nixos-generators?tab=readme-ov-file#using-in-a-flake
        


        "wsl" = nixpkgs.lib.nixosSystem { # slightly modifying stuff for qemu/kvm vms
          system = "x86_64-linux";
          pkgs = myPkgs.x86_64-linux;
          specialArgs = {
            pkgs-unstable = myPkgsUnstable.x86_64-linux;
          };

          modules =  [
            nixos-wsl.nixosModules.default
            {
              system.stateVersion = "24.11";
              wsl.enable = true;
            }
            ({ pkgs, lib, fetchFromGitHub, home-manager,... }: { 
              swapDevices = lib.mkForce [ ];
              environment.variables.NIXOS_FLAKE_CONFIGURATION = "wsl";
                  

            })
            ./configuration.nix
            home-manager.nixosModules.home-manager
            ({ lib, pkgs, ... }: {
		          home-manager.backupFileExtension = "_backup_option_in_flake_btw";
              home-manager.extraSpecialArgs = { 
                  inherit inputs; 
                  
                  pkgs-unstable = myPkgsUnstable.x86_64-linux;
              }; # Pass flake input to home-manager

              home-manager.users = {
                anna = {
                  home.homeDirectory = lib.mkForce "/home/anna";
                  imports = [ ./home-manager/anna/anna.nix ];
                  home.stateVersion="24.11";
                };
                nixos = {
                  home.homeDirectory = lib.mkForce "/home/nixos";
                  imports = [ ./home-manager/nixos/nixos.nix ];
                  home.stateVersion="24.11";
                };
              };
            })
          ];
        };

      };
    };
}
