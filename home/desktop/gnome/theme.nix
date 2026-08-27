{ pkgs, ... }:

{
  gtk.enable = true;

  gtk.theme = {
    name = "Yaru-dark";
    package = pkgs.yaru-theme;
  };

  gtk.iconTheme = {
    name = "Yaru-dark";
    package = pkgs.yaru-theme;
  };
}
