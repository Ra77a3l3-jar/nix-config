{ pkgs, ... }:

{
  config.vim = {
    extraPlugins.render-markdown = {
      package = pkgs.vimPlugins.render-markdown-nvim;
    };

    luaConfigRC.render-markdown = ''
      require("render-markdown").setup({
        enabled = true,

        completions = {
          lsp = {
            enabled = true,
          },
        },
      })
    '';
  };
}
