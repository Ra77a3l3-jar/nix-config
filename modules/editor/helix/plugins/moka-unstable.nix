{ config, lib, pkgs, ... }:

{
  programs.nhx.plugins."moka-unstable" = {
    enable = true;
    config = {
      transparent = true;
      rowOffset = 2;
      modeColors = {
        normal = {
          bg = "#59c2ff";
          fg = "#000000";
        };
        insert = {
          bg = "#aad94c";
          fg = "#000000";
        };
        select = {
          bg = "#d2a6ff";
          fg = "#000000";
        };
      };
      sections = [
        {
          align = "left";
          segments = [
            {
              kind = "mode";
              bubble = true;
            }
            {
              kind = "file";
              bg = "#222222";
              fg = "#c1c1c1";
              bubble = true;
              coloredIcons = true;
            }
          ];
        }
        {
          align = "center";
          segments = [
            {
              kind = "git-branch";
              bg = "#e78a53";
              fg = "#000000";
              bubble = true;
            }
          ];
        }
        {
          align = "right";
          segments = [
            { kind = "diagnostics"; }
            {
              kind = "lsp";
              bg = "#222222";
              fg = "#c1c1c1";
              bubble = true;
            }
            { kind = "position-percentage"; }
            {
              kind = "position";
              bg = "#222222";
              fg = "#c1c1c1";
              bubble = true;
            }
          ];
        }
      ];
      bufferline = {
        active = {
          bg = "#7aa2f7";
          fg = "#1a1b26";
          bubble = true;
        };
        inactive = {
          fg = "#565f89";
        };
        gap = 1;
      };
    };
  };
}
