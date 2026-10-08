{ inputs, pkgs, ... }:

let
  # Use the same pinned HyprWM release as Bobasek
  hyprPackages = inputs.hyprnix.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  # Hyprland's Lua configuration remains in the separate dotfiles repository
  home.packages = [
    hyprPackages.default
    hyprPackages.xdg-desktop-portal-hyprland
    hyprPackages.hyprland-guiutils
    hyprPackages.hyprlauncher
  ];
}
