{ pkgs-unstable, ... }:

{

  home.packages = with pkgs-unstable; [
    # (cargo, fmt, lsp will be downloaded from rustup)
    rustup
  ];
  
}
