{ pkgs, ... }:

{
  config.vim = {
    extraPlugins.autopairs = {
      package = pkgs.vimPlugins.nvim-autopairs;
    };

    luaConfigRC.autopairs = ''
      require("nvim-autopairs").setup({
        check_ts = true,
        enable_check_bracket_line = true,
      })
    '';
  };
}
