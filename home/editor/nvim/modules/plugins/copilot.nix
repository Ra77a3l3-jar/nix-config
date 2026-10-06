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
          auto_trigger = false,
          trigger_on_accept = false,

          keymap = {
            accept = "<M-l>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },

        panel = {
          enabled = true,
        },
      })

      vim.keymap.set("i", "<M-s>", function()
        local request = function()
          require("copilot.suggestion").next()
        end

        if not require("blink.cmp").hide({ callback = request }) then
          request()
        end
      end, { desc = "Request Copilot suggestion", silent = true })
    '';
  };
}
