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
      opencode
      webex

      steel # steel suite for helix plugins

      arduino-ide
      arduino-cli

      claude-code
      code-cursor
      codex
      mistral-vibe
    ])
    ++ [
      pkgs-unstable.kicad
    ];

}
