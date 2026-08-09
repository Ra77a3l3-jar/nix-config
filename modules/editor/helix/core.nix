{
  config,
  lib,
  pkgs,
  helix-steel,
  helixPlugins,
  ...
}:

{
  programs.nhx = {
    enable = true;

    plugins = with helixPlugins; [
      trail
      anchor
      cliff
      vista
      scooter
    ];

    package = helix-steel.packages.${pkgs.stdenv.hostPlatform.system}.helix;

    steel = {
      enable = true;
    };

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
        completion-trigger-len = 1;
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
          left = [
            "mode"
            "spinner"
            "file-name"
          ];
          center = [ "version-control" ];
          right = [
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];
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
