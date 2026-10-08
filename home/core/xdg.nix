{
  pkgs,
  config,
  lib,
  isNixOS,
  ...
}:

{
  xdg = {
    enable = true;

    configFile."environment.d/hm-session-vars.conf" = lib.mkIf (!isNixOS) {
      text = ''
        XDG_DATA_DIRS=${config.home.homeDirectory}/.nix-profile/share:${config.home.homeDirectory}/.local/share:/usr/local/share:/usr/share:/var/lib/flatpak/exports/share
      '';
    };
  };

  home.activation = {
    # The Nix profile is read-only; update only writable user desktop entries
    updateDesktopDatabase = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ -d "${config.home.homeDirectory}/.local/share/applications" ]; then
        $DRY_RUN_CMD ${pkgs.desktop-file-utils}/bin/update-desktop-database ${config.home.homeDirectory}/.local/share/applications
      fi
    '';

    removeFedoraXdgHack = lib.hm.dag.entryAfter [ "writeBoundary" ] (
      lib.optionalString isNixOS ''
        $DRY_RUN_CMD rm -f ${config.home.homeDirectory}/.config/environment.d/hm-session-vars.conf
      ''
    );
  };
}
