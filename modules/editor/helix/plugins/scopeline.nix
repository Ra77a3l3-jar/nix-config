{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.nhx.plugins.scopeline = {
    enable = true;
    config = {
      showFile = false;
    };
  };
}
