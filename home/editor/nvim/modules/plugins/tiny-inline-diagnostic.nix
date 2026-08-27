{ pkgs, ... }:

{
  config.vim = {
    extraPlugins.tiny-inline-diagnostic = {
      package = pkgs.vimPlugins.tiny-inline-diagnostic-nvim;
    };

    luaConfigRC.tiny-inline-diagnostic = ''
      require("tiny-inline-diagnostic").setup({
        preset = "modern",
        options = {
          show_source = true,
          multilines = true,
          break_line = {
            enabled = true,
          },
        },
      })
    '';
  };
}
