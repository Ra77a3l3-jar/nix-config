{ pkgs-unstable, ... }:

let
  tokyonight-flavors = pkgs-unstable.fetchFromGitHub {
    owner = "kalidyasin";
    repo = "yazi-flavors";
    rev = "bfd1b37a3beb27ee5cd51a96d7b4e8c116d50968";
    hash = "sha256-j9MCWSK8Xnj3mlbeQZcxkZ+wWQU+CCJfS39Tp8zextE=";
  };
in
{
  programs.yazi = {
    enable = true;
    package = pkgs-unstable.yazi;

    enableFishIntegration = true;
    shellWrapperName = "y";

    # Preview / opener helpers (fd, rg, jq, fzf, zoxide already in home/tools/common.nix)
    extraPackages = with pkgs-unstable; [
      ffmpeg
      p7zip
      poppler
      imagemagick
    ];

    plugins = {
      git = pkgs-unstable.yaziPlugins.git;
      full-border = pkgs-unstable.yaziPlugins.full-border;
    };

    flavors = {
      tokyonight-night = tokyonight-flavors + "/tokyonight-night.yazi";
      tokyonight-storm = tokyonight-flavors + "/tokyonight-storm.yazi";
      tokyonight-moon = tokyonight-flavors + "/tokyonight-moon.yazi";
      tokyonight-day = tokyonight-flavors + "/tokyonight-day.yazi";
    };

    settings = {
      mgr = {
        show_hidden = true;
        show_symlink = true;
        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        ratio = [ 1 4 3 ];
      };

      preview = {
        image_filter = "lanczos3";
        image_quality = 90;
        tab_size = 2;
        max_width = 600;
        max_height = 900;
        cache_dir = "";
      };

      plugin = {
        prepend_fetchers = [
          {
            url = "*";
            run = "git";
            group = "git";
          }
          {
            url = "*/";
            run = "git";
            group = "git";
          }
        ];
      };
    };

    theme = {
      flavor = {
        dark = "tokyonight-night";
      };

      git = {
        unknown = { fg = "#565f89"; };
        ignored = { fg = "#565f89"; };
        untracked = { fg = "#9ece6a"; };
        unstaged = { fg = "#e0af68"; };
        staged = { fg = "#9ece6a"; };
        added = { fg = "#9ece6a"; };
        deleted = { fg = "#f7768e"; };
        updated = { fg = "#e0af68"; };
        clean = { fg = "#9ece6a"; };

        unknown_sign = " ";
        ignored_sign = " ";
        untracked_sign = "? ";
        unstaged_sign = " ";
        staged_sign = " ";
        added_sign = " ";
        deleted_sign = " ";
        updated_sign = " ";
        clean_sign = "";
      };
    };

    initLua = ''
      require("full-border"):setup()
      require("git"):setup({
        order = 1500,
      })
    '';
  };
}
