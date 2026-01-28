{ ... }:

{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  # Critical to load enviorments on login
  targets.genericLinux.enable = true;
}

