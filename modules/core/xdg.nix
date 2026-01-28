{ pkgs, config, lib, ... }:

{
  xdg = {
    enable = true;

    # Fix for applications not appearing in GNOME on Fedora/Debian
    # This creates a systemd user environment file that sets XDG_DATA_DIRS correctly
    # so the launcher can find apps installed by Home Manager.
    configFile."environment.d/hm-session-vars.conf".text = ''
      XDG_DATA_DIRS=${config.home.homeDirectory}/.nix-profile/share:${config.home.homeDirectory}/.local/share:/usr/local/share:/usr/share:/var/lib/flatpak/exports/share
    '';
  };

  # Force an update of the desktop database after switching generations
  # This helps applications appear immediately without a reboot
  home.activation = {
    updateDesktopDatabase = lib.hm.dag.entryAfter ["writeBoundary"] ''
       if [ -d "${config.home.homeDirectory}/.nix-profile/share/applications" ]; then
         $DRY_RUN_CMD ${pkgs.desktop-file-utils}/bin/update-desktop-database ${config.home.homeDirectory}/.nix-profile/share/applications
       fi
       if [ -d "${config.home.homeDirectory}/.local/share/applications" ]; then
         $DRY_RUN_CMD ${pkgs.desktop-file-utils}/bin/update-desktop-database ${config.home.homeDirectory}/.local/share/applications
       fi
    '';
  };
}
