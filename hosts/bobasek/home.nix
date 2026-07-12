{ config, pkgs, pkgs-unstable, nixvim, zen-browser, inputs, ... }:

{
  imports = [
    ../../modules/core/default.nix
    ../../modules/desktop/default.nix
    ../../modules/terminal/default.nix
    ../../modules/shell/default.nix
    ../../modules/editor/default.nix
    ../../modules/tools/default.nix
    ../../modules/dev/default.nix
  ];
  
  home.username = "raffaele";
  home.homeDirectory = "/home/raffaele";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  nix.package = pkgs.nix;

  # let use Mesa for nix app
  targets.genericLinux.nixGL = {
    packages = pkgs.callPackage (inputs.nixgl + "/nixGL.nix") { };
    defaultWrapper = "mesa";
  };


  # Machine-specific aliases for home-manager
  home.shellAliases = {
    hms = "home-manager switch --flake ~/.config/nix-config#raffaele@bobasek";
    hmb = "home-manager build --flake ~/.config/nix-config#raffaele@bobasek";
  };
  
  home.packages = with pkgs; [
    curl
    wget
    man
    man-pages
  ];
}
