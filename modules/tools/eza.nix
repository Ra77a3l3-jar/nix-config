{ pkgs-unstable, ... }:

{
  programs.eza = {
    enable = true;
    package = pkgs-unstable.eza;
    icons = "auto";
    enableFishIntegration = true;
  };
}
