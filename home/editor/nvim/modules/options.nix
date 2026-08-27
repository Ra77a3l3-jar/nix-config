{ ... }:

{
  config.vim = {
    options = {
      number = true;
      relativenumber = true;

      signcolumn = "yes";

      cursorlineopt = "both";

      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 4;
      expandtab = true;

      swapfile = false;
      termguicolors = true;

      scrolloff = 5;

      wrap = true;
      linebreak = true;
      breakindent = true;
      showbreak = "↪ ";

      fillchars = "eob: ";

      undofile = true;

      ignorecase = true;
      smartcase = true;

      updatetime = 250;
      timeoutlen = 300;

      splitright = true;
      splitbelow = true;

      mouse = "";

      # allows for helix like movement to next or previous line
      whichwrap = "b,s,<,>,[,],h,l";

      guicursor = "n-c-sm:block,i-ci-ve:ver25,v:hor20,r-cr:hor20,o:hor50";
    };

    luaConfigRC.nix-indent = ''
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "nix",
        callback = function()
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          vim.opt_local.softtabstop = 2
          vim.opt_local.expandtab = true
        end,
      })
    '';
  };
}
