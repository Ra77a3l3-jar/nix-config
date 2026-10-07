{ lib, pkgs, hostName, ... }:
{
  # Install and enable these extensions only on Bobasek
  config = lib.mkIf (hostName == "bobasek") {
    home.packages = with pkgs.gnomeExtensions; [
      blur-my-shell
      keep-pinned-apps-in-appgrid
    ];

    dconf.settings."org/gnome/shell".enabled-extensions = [
      "blur-my-shell@aunetx"
      "pinned-apps-in-appgrid@brunosilva.io"
    ];
  };
}
