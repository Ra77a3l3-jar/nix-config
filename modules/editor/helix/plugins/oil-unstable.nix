{ config, lib, pkgs, ... }:

{
  programs.nhx.plugins."oil-unstable" = {
    enable = true;
    config = {
      hintLayout = {
        "git-status" = "start";
        icon = "start";
        metadata = "end";
      };
      keymaps.normal = {
        "-" = ":oil-up";
        I = ":oil-toggle-git-ignored";
        X = ":oil-cut";
        c = ":oil-clipboard-clear";
        h = ":oil-toggle-hidden";
        p = ":oil-paste";
        q = ":oil-close";
        "ret" = ":oil-enter";
        w = ":oil-save";
        y = ":oil-yank";
      };
    };
  };
}
