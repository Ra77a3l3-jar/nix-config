{
  description = "My first Nix + distro config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Keep Hyprland and GUI utilities on one compatible HyprWM release
    hyprnix.url = "github:hyprwm/hyprnix";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    helix-steel = {
      url = "github:Ra77a3l3-jar/helix/steel-personal-branch";
    };

    nhx = {
      url = "github:Ra77a3l3-jar/nhx";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    sonora.url = "github:sonorahq/sonora";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      zen-browser,
      neovim-nvf,
      helix-steel,
      nhx,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          nvidia.acceptLicense = true;
        };
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      extraSpecialArgs = {
        inherit
          inputs
          pkgs-unstable
          zen-browser
          neovim-nvf
          helix-steel
          nhx
          ;
        inherit system;
      };
    in
    {
      nixosConfigurations = {
        bobasek = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs pkgs-unstable;
          };
          modules = [
            ./hosts/bobasek/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = extraSpecialArgs // {
                  isNixOS = true;
                  hostName = "bobasek";
                };
                users.raffaele = import ./hosts/bobasek/home.nix;
              };
            }
          ];
        };
      };

      homeConfigurations = {
        "raffaele@legion" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = extraSpecialArgs // {
            isNixOS = false;
            hostName = "legion";
          };
          modules = [
            ./hosts/legion/home.nix
          ];
        };
      };
    };
}
