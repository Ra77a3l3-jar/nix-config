{ pkgs-unstable, ... }:

{

  home.packages = with pkgs-unstable; [
    # Python package manager
    pixi

    # Lsp
    pyright
  ];
  
}
