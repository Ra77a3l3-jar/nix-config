{ pkgs, ... }:

{
  config.vim = {
    enableLuaLoader = true;

    extraPackages = with pkgs; [
      nodejs
    ];

    clipboard = {
      enable = true;
      registers = "unnamedplus";
      providers = {
        wl-copy.enable = true;
        xclip.enable = true;
      };
    };

    telescope = {
      enable = true;

      setupOpts.defaults.borderchars = [
        "─"
        "│"
        "─"
        "│"
        "┌"
        "┐"
        "┘"
        "└"
      ];
    };

    binds.whichKey = {
      enable = true;

      register = {
        "<leader>g" = "+Git";
        "<leader>l" = "+LSP";
        "<leader>t" = "+TODO";
      };

      setupOpts = {
        preset = "helix";

        icons.rules = [
          {
            pattern = "lsp";
            icon = "󰒲";
            color = "blue";
          }
          {
            pattern = "todo";
            icon = "󰙵";
            color = "yellow";
          }
        ];
      };
    };

    visuals = {
      nvim-web-devicons.enable = true;
      fidget-nvim.enable = true;
      rainbow-delimiters.enable = true;

      indent-blankline = {
        enable = true;
        setupOpts = {
          indent = {
            char = "|";
            tab_char = "|";
          };
          scope = {
            enabled = false;
          };
        };
      };
    };

    comments.comment-nvim.enable = true;

    notes.todo-comments.enable = true;

    git.gitsigns.enable = true;

    utility.oil-nvim.enable = true;

    autocomplete.blink-cmp = {
      enable = true;
      mappings.next = null;

      setupOpts = {
        completion = {
          documentation = {
            auto_show = true;
          };

          menu = {
            draw = {
              treesitter = [ "lsp" ];
            };
          };
        };

        signature = {
          enabled = true;
        };

        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
        };

        keymap = {
          preset = "super-tab";
        };

        cmdline = {
          completion.menu.auto_show = true;

          keymap = {
            preset = "cmdline";
            "<Tab>" = [ "select_and_accept" "fallback" ];
            "<Up>" = [ "select_prev" "fallback" ];
            "<Down>" = [ "select_next" "fallback" ];
          };
        };
      };
    };

    lsp = {
      enable = true;
      formatOnSave = false;
    };

    treesitter = {
      enable = true;
    };
  };
}
