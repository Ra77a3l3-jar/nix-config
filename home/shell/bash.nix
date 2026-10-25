{ pkgs-unstable, ... }:

{
  programs.bash = {
    enable = true;
    package = pkgs-unstable.bashInteractive;
    enableCompletion = true;
  };
}
