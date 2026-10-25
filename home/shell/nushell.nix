{ config, pkgs-unstable, ... }:

{
  programs.nushell = {
    enable = true;
    package = pkgs-unstable.nushell;

    configFile.source = ./nushell/config.nu;
    settings.show_banner = false;

    # Let the compositor size the window before drawing Fastfetch's image.
    extraConfig = ''
      if $nu.is-interactive {
        sleep 300ms
        ^${config.programs.fastfetch.package}/bin/fastfetch
      }
    '';

    shellAliases = {
      ll = "ls -la";
      lg = "ls | table --icons";
    };
  };
}
