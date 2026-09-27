{ pkgs, ... }:

{
  # Keep the QML configuration unmanaged while it is under active development
  # in ~/.config/quickshell.
  home.packages = with pkgs; [
    quickshell
    qt6.qtdeclarative
    material-symbols
  ];
}
