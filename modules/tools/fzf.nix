{ pkgs-unstable, ... }:

{

  programs.fzf = {
    enable = true;
    package = pkgs-unstable.fzf;

    enableFishIntegration = true;
  };
  
}
