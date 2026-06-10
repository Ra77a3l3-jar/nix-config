{ pkgs, pkgs-unstable, ... }:

{

  home.packages = with pkgs; [

  ] ++ (with pkgs-unstable; [
    opencode
    lazygit
    mise
    #steel
    gh-dash
    arduino-ide
    arduino-cli
    arduino-language-server
  ]);
  
}
