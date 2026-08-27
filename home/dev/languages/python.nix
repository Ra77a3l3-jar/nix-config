{ pkgs-unstable, ... }:

{

  home.packages = with pkgs-unstable; [
    # Python package manager
    pixi
    uv

    # Lsp
    pyright
  ];

}
