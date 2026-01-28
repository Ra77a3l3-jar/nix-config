{ config, pkgs, pkgs-unstable, nixvim, zen-browser, ... }:

{
  imports = [
    ./modules/core/default.nix
    ./modules/desktop/default.nix
  ];
  
  home.username = "raffaele";
  home.homeDirectory = "/home/raffaele";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  nix.package = pkgs.nix;
  
  home.packages = with pkgs; [
    curl
    wget
    man
    man-pages
  ];
}
