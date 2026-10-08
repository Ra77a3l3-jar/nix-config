{ pkgs, ... }:

{
  languages.nix = {
    enable = true;
    lsp.package = pkgs.nil;
  };

  packages = with pkgs; [
    nixpkgs-fmt
    nix-init
  ];
}
