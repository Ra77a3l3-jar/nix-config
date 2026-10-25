{ pkgs-unstable, ... }:

{
  programs.zoxide = {
    enable = true;
    package = pkgs-unstable.zoxide;

    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
  };
}
