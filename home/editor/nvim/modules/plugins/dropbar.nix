{ pkgs, ... }:

{
  config.vim = {
    extraPlugins = {
      nui = {
        package = pkgs.vimPlugins.nui-nvim;
      };

      dropbar = {
        package = pkgs.vimPlugins.dropbar-nvim;
      };
    };

    luaConfigRC.dropbar = ''
      require("dropbar").setup({
        menu = {
          win_configs = {
            border = "rounded",
          },
        },
      })
    '';
  };
}
