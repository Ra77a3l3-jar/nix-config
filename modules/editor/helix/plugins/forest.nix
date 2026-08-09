{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.nhx.plugins.forest = {
    enable = true;
    config = {
      style = "mini";
      position = "left";
      ignore = [
        ".git"
        "target"
        ".cache"
        "pycache"
      ];
    };
  };
}
