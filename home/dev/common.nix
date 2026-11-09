{
  pkgs,
  pkgs-unstable,
  config,
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
    ];

}
