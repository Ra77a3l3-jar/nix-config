{ ... }:

{
  config.vim.keymaps = [
    {
      key = "ge";
      mode = [ "n" "x" ];
      action = "G";
      desc = "Go to end of file";
    }

    {
      key = "y";
      mode = "x";
      action = "ygv";
      desc = "Yank and keep selection";
    }

    {
      key = "<leader>e";
      mode = "n";
      action = "<cmd>lua MiniFiles.open()<CR>";
      desc = "Mini Files";
    }

    {
      key = "<leader>m";
      mode = "n";
      action = "<cmd>Oil<CR>";
      desc = "File explorer";
    }

    # Telescope
    {
      key = "<leader>ff";
      mode = "n";
      action = "<cmd>Telescope find_files<CR>";
      desc = "Find files";
    }

    {
      key = "<leader>fg";
      mode = "n";
      action = "<cmd>Telescope live_grep<CR>";
      desc = "Live grep";
    }

    {
      key = "<leader>fb";
      mode = "n";
      action = "<cmd>Telescope buffers<CR>";
      desc = "Buffers";
    }

    # Buffers
    {
      key = "<leader>bn";
      mode = "n";
      action = "<cmd>bnext<CR>";
      desc = "Next buffer";
    }

    {
      key = "<leader>bp";
      mode = "n";
      action = "<cmd>bprevious<CR>";
      desc = "Previous buffer";
    }

    {
      key = "<leader>bd";
      mode = "n";
      action = "<cmd>bdelete<CR>";
      desc = "Delete buffer";
    }

    # Git
    {
      key = "<leader>gd";
      mode = "n";
      action = "<cmd>DiffviewOpen<CR>";
      desc = "Diffview open";
    }

    {
      key = "<leader>gc";
      mode = "n";
      action = "<cmd>DiffviewClose<CR>";
      desc = "Diffview close";
    }

    {
      key = "<leader>gh";
      mode = "n";
      action = "<cmd>DiffviewFileHistory<CR>";
      desc = "File history";
    }

    # LSP
    {
      key = "<leader>la";
      mode = "n";
      action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      desc = "Code action";
    }

    {
      key = "<leader>lr";
      mode = "n";
      action = "<cmd>lua vim.lsp.buf.rename()<CR>";
      desc = "Rename";
    }

    {
      key = "<leader>lf";
      mode = "n";
      action = "<cmd>lua vim.lsp.buf.format()<CR>";
      desc = "Format";
    }
  ];
}
