{ pkgs, pkgs-unstable, config, ... }:

{

  home.packages = with pkgs; [

  ] ++ (with pkgs-unstable; [
    neovim
    zed-editor
  ]);

}
