{ pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
    lutris
    heroic
  ];
}
