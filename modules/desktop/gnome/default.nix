{ ... }:

{
  imports = [
    ./fonts.nix
    ./gnome.nix
    ./theme.nix
  ];

  desktop.gnome = {
    uiFont = "Caskaydia Mono Nerd Font";
    documentFont = "Caskaydia Mono Nerd Font";
    monoFont = "Caskaydia Mono Nerd Font";
    fontSize = 13;
  };
}
