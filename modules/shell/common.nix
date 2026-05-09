{ pkgs-unstable, ... }:

{

  home.packages = with pkgs-unstable; [
    nushell
  ];
  
}
