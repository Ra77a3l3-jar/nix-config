{ pkgs, pkgs-unstable, ... }:

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

      if type -q oh-my-posh
        oh-my-posh init fish --config ${pkgs-unstable.oh-my-posh}/share/oh-my-posh/themes/robbyrussell.omp.json | source
      end
    '';
  };
}
