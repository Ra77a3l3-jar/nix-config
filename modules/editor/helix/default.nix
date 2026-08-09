{ config, lib, nhx, ... }:

{
  imports = [
    nhx.homeManagerModules.nhx
    ./core.nix
    ./keybinds.nix
    ./languages.nix
    ./plugins
  ];
}
