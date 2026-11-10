{
  pkgs,
  pkgs-unstable,
  config,
  mistral-vibe,
  ...
}:

{

  home.packages =
    with pkgs;
    [
      python3
    ]
    ++ (with pkgs-unstable; [
      webex

      steel # steel suite for helix plugins

      arduino-ide
      arduino-cli

    ])
    ++ [
      pkgs-unstable.kicad
      pkgs-unstable.devenv
      mistral-vibe.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

}
