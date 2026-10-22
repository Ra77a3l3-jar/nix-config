{ pkgs, config, ... }:

{
  programs.kitty = {
    enable = true;

    package = pkgs.kitty;

    themeFile = "VibrantInk";

    font = {
      name = ''family="JetBrainsMono Nerd Font" style=Bold'';
      size = 13;
    };

    settings = {
      bold_font = ''family="JetBrainsMono Nerd Font" style=ExtraBold'';
      italic_font = ''family="JetBrainsMono Nerd Font" style="Bold Italic"'';
      bold_italic_font = ''family="JetBrainsMono Nerd Font" style="ExtraBold Italic"'';

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
