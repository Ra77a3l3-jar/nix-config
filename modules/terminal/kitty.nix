{ pkgs, config, ... }:

{
  programs.kitty = {
    enable = true;

    package = config.lib.nixGL.wrap pkgs.kitty;

    themeFile = "VibrantInk";

    font = {
      name = "Jetbrains Mono Nerd Font";
      size = 13;
    };
    
    settings = {
      # Cursor
      cursor_shape = "beam";
      cursor_blink_interval = "0";
      cursor_trail = "1";
      
      # Scrollback
      scrollback_lines = 20000;

      background_opacity = 0.8;
      background_blur = 25;
      
      # Window
      window_padding_width = 5;
      remember_window_size = true;
      hide_window_decorations = true;
    };
    
  };
}
