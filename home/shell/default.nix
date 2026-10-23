{ pkgs-unstable, ... }:

{
  imports = [
    ./fish.nix
    ./nushell.nix
    ./zsh.nix
  ];

  programs.oh-my-posh = {
    enable = true;
    package = pkgs-unstable.oh-my-posh;
    useTheme = "robbyrussell";

    enableFishIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    enableBashIntegration = false;
  };

  programs.carapace = {
    enable = true;
    package = pkgs-unstable.carapace;

    enableNushellIntegration = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;
  };
}
