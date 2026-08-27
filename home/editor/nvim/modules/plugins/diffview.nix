{ pkgs, ... }:

{
  config.vim = {
    extraPlugins.diffview = {
      package = pkgs.vimPlugins.diffview-nvim;
    };

    luaConfigRC.diffview = ''
      require("diffview").setup({})
    '';
  };
}
