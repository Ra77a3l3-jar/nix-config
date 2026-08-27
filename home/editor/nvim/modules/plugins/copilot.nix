{ pkgs, ... }:

{
  config.vim = {
    extraPlugins.copilot = {
      package = pkgs.vimPlugins.copilot-lua;
    };

    luaConfigRC.copilot = ''
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,

          keymap = {
            accept = "<Tab>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },

        panel = {
          enabled = true,
        },
      })
    '';
  };
}
