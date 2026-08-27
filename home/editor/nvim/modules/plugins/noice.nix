{ pkgs, ... }:

{
  config.vim = {
    notify.nvim-notify.enable = true;

    extraPlugins.noice = {
      package = pkgs.vimPlugins.noice-nvim;
    };

    luaConfigRC.noice = ''
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
          },
        },

        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          lsp_doc_border = true,
        },
      })
    '';
  };
}
