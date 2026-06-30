{ pkgs, pkgs-unstable, ... }:

{

  home.packages = with pkgs; [
    python3
  ] ++ (with pkgs-unstable; [
    opencode
    lazygit
    gh-dash

    # warp-terminal (does not work on fedora + nix without gpu support)

    steel # steel suite for helix plugins

    arduino-ide
    arduino-cli

    # kicad design electronics circuits (install with system package for better peformance)
  ]);
  
}
