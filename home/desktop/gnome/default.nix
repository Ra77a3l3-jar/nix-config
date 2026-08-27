{ ... }:

{
  imports = [
    ./fonts.nix
    ./gnome.nix
    ./theme.nix
  ];

  desktop.gnome = {
    uiFont = "Fira Code Nerd Font";
    documentFont = "Fira Code Nerd Font";
    monoFont = "Fira Code Nerd Font";
    fontSize = 13;
  };
}
