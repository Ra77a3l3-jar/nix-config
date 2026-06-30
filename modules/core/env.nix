{ config, ... }:

{
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    TERMINAL = "kitty";
    PAGER  = "bat";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    STEEL_HOME = "${config.home.homeDirectory}/.steel";
  };
}
