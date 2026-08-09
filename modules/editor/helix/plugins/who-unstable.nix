{ config, lib, pkgs, ... }:

{
  programs.nhx.plugins."who-unstable" = {
    enable = true;
    config = {
      color = "#94e2d5";
    };
  };
}
