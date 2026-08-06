{
  config,
  pkgs,
  helix-steel,
  ...
}:

{
  programs.helix = {
    enable = true;
    # my helix fork with steel plugin support
    package = helix-steel.packages.${pkgs.stdenv.hostPlatform.system}.helix;

    steel = {
      enable = true;
      plugins = with config.programs.helix.steel.availablePlugins; [
        anchor
        forest
        glyph
        moka-unstable
        notify
        oil-unstable
        trail
        who-unstable
        scopeline
        scooter
        vista
        cliff
      ];
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
