{ pkgs-unstable, ... }:

{
  programs.helix = {
    enable = true;
    package = pkgs-unstable.steelix;

    settings = {
       theme = "catppuccin_mocha_transparent";
      
      editor = {
        scrolloff = 999;
        line-number = "relative";
        bufferline = "multiple";
        mouse = false;
        
        true-color = true;
        color-modes = true;
        rainbow-brackets = true;

        auto-completion = true;
        completion-trigger-len = 2;
        completion-timeout = 5;
        continue-comments = false;

        cursor-shape = {
          insert = "block";
          normal = "block";
          select = "block";
        };

        indent-guides = {
          render = true;
          character = "|";
          skip-levels = 1;
        };

        statusline = {
          left = [ "mode" "spinner" "file-name" ];
          center = [ "version-control" ];
          right = [ "diagnostics" "selections" "position" "file-encoding" "file-line-ending" "file-type" ];
          separator = "│";
          mode = {
            normal = "NOR";
            insert = "INS";
            select = "SEL";
          };
        };
      };
    };
  };
}
