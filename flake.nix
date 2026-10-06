{
  description = "My first Nix + distro config";

  nixConfig = {
    extra-substituters = [ "https://ros.cachix.org" ];
    extra-trusted-public-keys = [
      "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    hyprland-guiutils = {
      url = "github:hyprwm/hyprland-guiutils";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # pinened ros version to use cache instead of builing everything
    nix-ros-overlay = {
      url = "github:lopsided98/nix-ros-overlay/13634b579b61299abfc5389d7d47dd7d1701a3a2";
      inputs.nixpkgs.follows = "nixpkgs-ros";
    };
    nixpkgs-ros.url = "github:NixOS/nixpkgs/d233902339c02a9c334e7e593de68855ad26c4cb";

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
      flake-utils,
      zen-browser,
      neovim-nvf,
      nix-ros-overlay,
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
      devShells =
        let
          shells = import ./devshells/flake.nix {
            inherit inputs system;
          };
        in
        {
          ${system} = shells;
        };

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
