{ config, lib, ... }:

{
  imports = [
    ./core.nix
    ./keybinds.nix
    ./languages.nix
    ./plugins
  ];
}
