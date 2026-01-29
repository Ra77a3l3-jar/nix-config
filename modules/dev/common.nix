{ pkgs, pkgs-unstable, ... }:

{

  home.packages = with pkgs; [
    pkg-config
  ] ++ (with pkgs-unstable; [
    opencode
    lazygit
    mise
  ]);
  
}
