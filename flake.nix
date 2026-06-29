{
  description = "My first Nix + distro config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, flake-utils, zen-browser, nixvim }@inputs: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      devShells = let
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
            inherit inputs pkgs-unstable zen-browser nixvim;
          };
          
          modules = [
            ./hosts/bobasek/home.nix
          ];
        };
        
        # Personal PC configuration
        "raffaele@legion" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          
          extraSpecialArgs = { 
            inherit inputs pkgs-unstable zen-browser nixvim;
          };
          
          modules = [
            ./hosts/legion/home.nix
          ];
        };
        
        # Legacy alias (keep for backward compatibility)
        "raffaele" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          
          extraSpecialArgs = { 
            inherit inputs pkgs-unstable zen-browser nixvim;
          };
          
          modules = [
            ./home.nix
          ];
        };
      };
    };
}
