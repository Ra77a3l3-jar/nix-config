{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.nhx.settings.keys.normal = {
    n = {
      a = ":buffer-close-all";
      c = ":buffer-close";
      f = ":buffer-close!";
      h = ":moka-bufferline-move-left!";
      l = ":moka-bufferline-move-right!";
      n = ":buffer-next";
      p = ":buffer-previous";
    };

    "space" = {
      e = ":forest-open";
      o = ":oil";
      p = ":trail-open";

      u = {
        a = ":cliff-unfold-all";
        f = ":cliff-fold";
        o = ":cliff-unfold";
        u = ":cliff-toggle";
      };

      v = {
        N = ":delta-prev-hunk";
        Z = ":anchor-restore";
        n = ":delta-next-hunk";
        t = ":dispatch-open";
        z = ":anchor-save";
      };
    };
  };
}
