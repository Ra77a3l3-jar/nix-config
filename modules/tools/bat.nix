{ pkgs-unstable, ... }:

{
  
  home.packages = with pkgs-unstable; [
    bat
    bat-extras.batman
  ];
  
}
