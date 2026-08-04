{ pkgs, ... }:

{
  config.vim = {
    extraPlugins.mini = {
      package = pkgs.vimPlugins.mini-nvim;
    };

    luaConfigRC.mini-files = ''
      require("mini.files").setup({
        windows = {
          preview = true,
          width_focus = 30,
          width_nofocus = 20,
          width_preview = 60,
          max_number = 3,
        },
      })
    '';
  };
}
