{ pkgs-unstable, ... }:

{
  imports = [
    ./bash.nix
    ./fish.nix
    ./nushell.nix
    ./zsh.nix
  ];

  programs.oh-my-posh = {
    enable = true;
    package = pkgs-unstable.oh-my-posh;
    configFile = ./themes/saffron-nightfall.omp.json;

    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
  };

  programs.carapace = {
    enable = true;
    package = pkgs-unstable.carapace;
    
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
  };

  home.sessionVariables = {
    CARAPACE_BRIDGES = "fish,zsh,bash";
  };

  programs.nushell.extraEnv = ''
    $env.CARAPACE_BRIDGES = "fish,zsh,bash"
  '';
}
