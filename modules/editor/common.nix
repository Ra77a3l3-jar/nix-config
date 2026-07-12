{ pkgs, pkgs-unstable, config, ... }:

{

  home.packages = with pkgs; [

  ] ++ (with pkgs-unstable; [
    neovim
  ]) ++ [
    (config.lib.nixGL.wrap pkgs-unstable.zed-editor)
  ];

}
