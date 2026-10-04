{ lib, isNixOS, ... }:

{
  imports =
    [
      ./gnome/theme.nix
      ./quickshell/default.nix
      ./hyprland/default.nix
    ]
    ++ lib.optionals (!isNixOS) [
      ./gnome/default.nix
    ];
}
