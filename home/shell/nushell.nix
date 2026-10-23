{ pkgs-unstable, ... }:

{
  programs.nushell = {
    enable = true;
    package = pkgs-unstable.nushell;

    configFile.source = ./nushell/config.nu;
    settings.show_banner = false;

    shellAliases = {
      la = "ls -la";
      ll = "ls -l";
      lg = "ls -l";
    };
  };
}
