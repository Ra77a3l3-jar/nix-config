{pkgs, pkgs-unstable, ... }:

{

  home.packages = with pkgs; [
    # chromium
    libreoffice
  ] ++ (with pkgs-unstable; [
    fluffychat
    keepassxc
    vesktop
  ]);
  
}
