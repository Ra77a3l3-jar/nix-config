{ ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -g fish_greeting ""

      fish_add_path $HOME/.local/bin
      fish_add_path $HOME/.nix-profile/bin

      if type -q zoxide
        zoxide init fish | source
      end
    '';
  };
}
