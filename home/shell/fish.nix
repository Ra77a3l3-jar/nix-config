{ config, ... }:

{
  programs.fish = {
    enable = true;

    # Let the compositor size the window before drawing Fastfetch's image.
    functions.fish_greeting = ''
      sleep 0.3
      ${config.programs.fastfetch.package}/bin/fastfetch
    '';

    interactiveShellInit = ''
      fish_add_path $HOME/.local/bin
      fish_add_path $HOME/.nix-profile/bin
    '';
  };
}
