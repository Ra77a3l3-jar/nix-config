{ pkgs-unstable, ... }:

{
  programs.zoxide = {
    enable = true;
    package = pkgs-unstable.zoxide;

    enableFishIntegration = true;
  };
}
