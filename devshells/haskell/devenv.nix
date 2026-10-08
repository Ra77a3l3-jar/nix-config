{ pkgs, ... }:

{
  languages.haskell = {
    enable = true;
    package = pkgs.haskellPackages.ghcWithPackages (
      p: with p; [
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
      ]
    );
  };

  packages = with pkgs; [
    ghcid
    ormolu
    fourmolu
    hlint
  ];

  enterShell = ''
    echo "Haskell dev environment"
  '';
}
