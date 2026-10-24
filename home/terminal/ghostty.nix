{
  config,
  lib,
  pkgs-unstable,
  ...
}:

{
  programs.ghostty = {
    enable = true;

    package = pkgs-unstable.ghostty;

    themes."Saffron Nightfall" = lib.importJSON ./themes/ghostty/saffron-nightfall.json;

    settings = {
      theme = "Saffron Nightfall";

      font-family = "JetBrainsMono Nerd Font";
      font-style = "Bold";
      font-style-bold = "ExtraBold";
      font-style-italic = "Bold Italic";
      font-style-bold-italic = "ExtraBold Italic";
      font-size = 13;

      cursor-style = "bar";
      cursor-style-blink = "false";

      scrollback-limit = 50000;

      window-padding-x = 10;
      window-padding-y = 10;
      window-save-state = "always";
      window-decoration = false;

      maximize = true;
      fullscreen = false;

      background-opacity = 0.85;
      background-blur-radius = 0;

      # disable D-Bus single instance so GNOME launches the binary directly
      gtk-single-instance = false;
    };
  };

  # removes DBusActivatable so GNOME runs the wrapped binary
  # directly instead of going through the systemd service
  xdg.desktopEntries."com.mitchellh.ghostty" = {
    name = "Ghostty";
    comment = "A terminal emulator";
    exec = "${config.programs.ghostty.package}/bin/ghostty";
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
