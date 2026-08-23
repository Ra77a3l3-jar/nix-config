{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./forest.nix
    ./moka.nix
    ./oil-unstable.nix
    ./scopeline.nix
    ./who-unstable.nix
  ];
}
