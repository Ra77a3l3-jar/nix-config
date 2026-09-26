{ config, ... }:

{
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    TERMINAL = "wezterm";
    PAGER = "bat";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    STEEL_HOME = "${config.home.homeDirectory}/.steel";
    HELIX_DISABLE_TERMINAL_BACKGROUND_QUERY = "1";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.cargo/bin"
  ];
}
