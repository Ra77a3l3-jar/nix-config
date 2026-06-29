{ config, pkgs, pkgs-unstable, nixvim, zen-browser, ... }:

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
  
  # Machine-specific aliases for home-manager
  home.shellAliases = {
    hms = "home-manager switch --flake ~/.config/nix-config#raffaele@legion";
    hmb = "home-manager build --flake ~/.config/nix-config#raffaele@legion";
  };
  
  home.packages = with pkgs; [
    curl
    wget
    man
    man-pages
    nh
  ];
  
}
