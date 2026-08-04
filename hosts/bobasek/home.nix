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
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  nix.package = pkgs.nix;

  # Mesa GPU integration for nix apps via /run/opengl-driver
  targets.genericLinux.gpu = {
    enable = true;
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
