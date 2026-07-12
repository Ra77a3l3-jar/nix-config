{ pkgs, config, ... }:

{
  home.packages = [ (config.lib.nixGL.wrap pkgs.wezterm) ];

  xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;
}
