{ pkgs, pkgs-unstable, config, ... }:

{

  home.packages = with pkgs; [
    python3
  ] ++ (with pkgs-unstable; [
    opencode
    lazygit
    gh-dash

    steel # steel suite for helix plugins

    arduino-ide
    arduino-cli

    claude-code
    code-cursor
    codex
    mistral-vibe
  ]) ++ [
    # (config.lib.nixGL.wrap pkgs-unstable.kicad)
    (config.lib.nixGL.wrap pkgs-unstable.warp-terminal)
  ];

}
