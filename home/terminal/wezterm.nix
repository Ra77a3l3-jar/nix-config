{ pkgs-unstable, ... }:

{
  home.packages = [ pkgs-unstable.wezterm ];

  xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;
  xdg.configFile."wezterm/colors".source = ./themes/wezterm;
}
