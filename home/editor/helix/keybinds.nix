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
      n = ":buffer-next";
      p = ":buffer-previous";
    };

    "space" = {
      e = ":forest-open";
      o = ":oil";
      p = ":trail-open";
      v = ":cliff-toggle";
    };
  };
}
