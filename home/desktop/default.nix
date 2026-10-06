{ lib, isNixOS, ... }:

{
  imports =
    [
      ./gnome/theme.nix
      ./quickshell/default.nix
    ]
    ++ lib.optionals (!isNixOS) [
      ./gnome/default.nix
    ];
}
