{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./cliff.nix
    ./forest.nix
    ./moka.nix
    ./oil-unstable.nix
    ./scopeline.nix
    ./vista.nix
    ./who-unstable.nix
  ];
}
