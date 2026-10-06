{ inputs, pkgs-unstable, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = false;
    package = pkgs-unstable.hyprland;
    portalPackage = pkgs-unstable.xdg-desktop-portal-hyprland;
  };

  environment.systemPackages = [
    inputs.hyprland-guiutils.packages.${pkgs-unstable.stdenv.hostPlatform.system}.default
  ];
}
