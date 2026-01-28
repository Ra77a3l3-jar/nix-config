{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    package = pkgs.runCommand "kitty-system" {} ''
        mkdir -p $out/bin
        ln -s /usr/bin/kitty $out/bin/kitty
      '';
    
    themeFile = "VibrantInk";

    font = {
      name = "Ubuntu Nerd Font";
      size = 13;
    };
    
    settings = {
      # Cursor
      cursor_shape = "beam";
      cursor_blink_interval = "0";
      cursor_trail = "1";
      
      # Scrollback
      scrollback_lines = 20000;
      
      # Window
      window_padding_width = 5;
      remember_window_size = true;
      hide_window_decorations = true;
    };
    
  };
}
