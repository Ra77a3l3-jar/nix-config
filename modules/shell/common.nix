{ pkgs-unstable, ... }:

{

  home.packages = with pkgs-unstable; [
    oh-my-posh
  ];
  
}
