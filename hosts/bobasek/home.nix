{
  pkgs,
  zen-browser,
  helium,
  system,
  ...
}:

{
  imports = [
    ../../home/core/default.nix
    ../../home/desktop/default.nix
    ../../home/apps/default.nix
    ../../home/terminal/default.nix
    ../../home/shell/default.nix
    ../../home/editor/default.nix
    ../../home/tools/default.nix
    ../../home/dev/default.nix
  ];

  home.username = "raffaele";
  home.homeDirectory = "/home/raffaele";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.shellAliases = {
    hms = "sudo nixos-rebuild switch --flake ~/.config/nix-config#bobasek";
    hmb = "sudo nixos-rebuild build --flake ~/.config/nix-config#bobasek";
    nrs = "sudo nixos-rebuild switch --flake ~/.config/nix-config#bobasek";
    nrb = "sudo nixos-rebuild build --flake ~/.config/nix-config#bobasek";
    nrt = "sudo nixos-rebuild test --flake ~/.config/nix-config#bobasek";
    nrd = "sudo nixos-rebuild dry-activate --flake ~/.config/nix-config#bobasek";
  };

  home.packages =
    (with pkgs; [
      curl
      wget
      man
      man-pages
      nh
      btop
    ])
    ++ [
      zen-browser.packages.${system}.default
      helium.packages.${system}.default
    ];
}
