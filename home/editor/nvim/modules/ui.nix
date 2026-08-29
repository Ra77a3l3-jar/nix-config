{ ... }:

{
  config.vim = {
    statusline.lualine = {
      enable = true;
      theme = "catppuccin";
    };

    tabline.nvimBufferline = {
      enable = true;

      setupOpts.options = {
        always_show_bufferline = false;
        numbers = "none";
        offsets = [
          {
            filetype = "oil";
            text = "File Explorer";
            highlight = "Directory";
            separator = true;
          }
          {
            filetype = "minifiles";
            text = "Mini Files";
            highlight = "Directory";
            separator = true;
          }
        ];
      };
    };
  };
}
