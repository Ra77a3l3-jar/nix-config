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

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
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
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nhx = {
      url = "github:Ra77a3l3-jar/nhx";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    herdnix = {
      url = "github:Ra77a3l3-jar/herdnix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      flake-utils,
      zen-browser,
      nixvim,
      neovim-nvf,
      nix-ros-overlay,
      helix-steel,
      nhx,
      herdnix,
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

      homeConfigurations = {
        # School/Travel laptop configuration
        "raffaele@bobasek" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit
              inputs
              pkgs-unstable
              zen-browser
              nixvim
              neovim-nvf
              helix-steel
              nhx
              herdnix
              ;
            system = "x86_64-linux";
          };

          modules = [
            ./hosts/bobasek/home.nix
          ];
        };

        # Personal PC configuration
        "raffaele@legion" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit
              inputs
              pkgs-unstable
              zen-browser
              nixvim
              neovim-nvf
              helix-steel
              nhx
              herdnix
              ;
            system = "x86_64-linux";
          };

          modules = [
            ./hosts/legion/home.nix
          ];
        };

        # Legacy alias (keep for backward compatibility)
        "raffaele" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit
              inputs
              pkgs-unstable
              zen-browser
              nixvim
              helix-steel
              ;
          };

          modules = [
            ./home.nix
          ];
        };
      };
    };
}
