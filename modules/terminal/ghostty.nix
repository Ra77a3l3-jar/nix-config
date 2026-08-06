{ config, pkgs-unstable, ... }:

let
  ghosttyPkg = pkgs-unstable.ghostty;
in
{
  programs.ghostty = {
    enable = true;

    package = ghosttyPkg;

    settings = {
      theme = "Vibrant Ink";
      # theme = "TokyoNight";
      # theme = "Spacedust";
      # theme = "Sea Shells";
      # theme = "Black Metal (Bathory)";

      font-family = "Jetbrains Mono Nerd Font";
      font-synthetic-style = "bold";
      font-size = 13;

      cursor-style = "bar";
      cursor-style-blink = "false";

      scrollback-limit = 50000;

      window-padding-x = 10;
      window-padding-y = 10;
      window-save-state = "always";
      window-decoration = false;

      fullscreen = "true";

      background-opacity = 0.85;
      background-blur-radius = 25;

      # disable D-Bus single instance so GNOME launches the binary directly
      gtk-single-instance = false;
    };
  };

  # removes DBusActivatable so GNOME runs the wrapped binary
  # directly instead of going through the systemd service
  xdg.desktopEntries."com.mitchellh.ghostty" = {
    name = "Ghostty";
    comment = "A terminal emulator";
    exec = "${ghosttyPkg}/bin/ghostty";
    icon = "com.mitchellh.ghostty";
    categories = [
      "System"
      "TerminalEmulator"
    ];
    startupNotify = true;
    settings = {
      StartupWMClass = "com.mitchellh.ghostty";
      Keywords = "terminal;tty;pty;";
      X-TerminalArgExec = "-e";
      X-TerminalArgTitle = "--title=";
      X-TerminalArgDir = "--working-directory=";
    };
  };

}
