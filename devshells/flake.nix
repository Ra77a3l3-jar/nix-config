{ inputs, system }:

let
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  hpkgs = pkgs.haskellPackages;

in
{
  haskell = pkgs.mkShell {
    packages = [

      pkgs.ghc
      pkgs.cabal-install
      pkgs.stack
      pkgs.haskell-language-server
      pkgs.ghcid

      pkgs.ormolu
      pkgs.fourmolu
      pkgs.hlint

      (hpkgs.ghcWithPackages (p: with p; [
        text
        bytestring
        containers
        unordered-containers
        vector
        aeson
        aeson-pretty
        generic-aeson
        optparse-applicative
        mtl
        transformers
        exceptions
        safe-exceptions
        async
        stm
        unliftio
        http-conduit
        servant
        servant-server
        wai
        warp
        megaparsec
        pretty-simple
        lens
        directory
        filepath
        random
      ]))
    ];

    shellHook = ''
      echo "Haskell dev environment"
    '';
  };

  go = pkgs.mkShell {
    packages = [
      pkgs.go
      pkgs.gopls
      pkgs.go-tools
    ];
  };

  java = pkgs.mkShell {
    packages = [
      pkgs.jdk21
      pkgs.maven
      pkgs.gradle
      pkgs.jdt-language-server
    ];
  };

  zig = pkgs.mkShell {
    packages = [
      pkgs.zig
      pkgs.zls
    ];
  };

  asm = pkgs.mkShell {
    packages = [
      pkgs.gcc
      pkgs.binutils
      pkgs.gdb
      pkgs.nasm
      pkgs.lldb
    ];
  };

  nix = pkgs.mkShell {
    packages = [
      pkgs.nixd
      pkgs.nixpkgs-fmt
      pkgs.statix
    ];
  };

  bash = pkgs.mkShell {
    packages = [
      pkgs.shellcheck
      pkgs.shfmt
      pkgs.bash-language-server
    ];
  };
}
