{ inputs, pkgs, ... }:

let
  # Use HyprWM's pinned package set for Hyprland, portal, and GUI utilities
  hyprPackages = inputs.hyprnix.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [ ./scroll-overview.nix ];

  programs.hyprland = {
    enable = true;
    withUWSM = false;
    package = hyprPackages.default;
    portalPackage = hyprPackages.xdg-desktop-portal-hyprland;
  };

  environment.systemPackages = [
    hyprPackages.hyprland-guiutils
  ];
}
