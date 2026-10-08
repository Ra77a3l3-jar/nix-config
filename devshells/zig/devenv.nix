{ inputs, pkgs, ... }:

let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.system;
    config.allowUnfree = true;
  };
in
{
  languages.zig = {
    enable = true;
    package = unstable.zig;
    lsp.package = unstable.zls;
  };

  packages = [ unstable.zig-zlint ];
}
