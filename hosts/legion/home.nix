{ config, pkgs, pkgs-unstable, nixvim, zen-browser, inputs, ... }:

{
  imports = [
    ../../modules/core/default.nix
    ../../modules/desktop/default.nix
    ../../modules/terminal/default.nix
    ../../modules/shell/default.nix
    ../../modules/editor/default.nix
    ../../modules/tools/default.nix
    ../../modules/dev/default.nix
  ];
  
  home.username = "raffaele";
  home.homeDirectory = "/home/raffaele";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  nix.package = pkgs.nix;

  # Allows nix GUI apps to use the NVIDIA GPU. Modules install GUI apps through
  # config.lib.nixGL.wrap, and this picks which wrapper that uses.
  # Vulkan is on because zed renders with it. Driver pin: lib/nixgl.nix
  targets.genericLinux.nixGL = let
    nixgl = import ../../lib/nixgl.nix { inherit pkgs; nixgl = inputs.nixgl; };
  in {
    packages = { inherit (nixgl) nixGLNvidia nixVulkanNvidia; };
    defaultWrapper = "nvidia";
    vulkan.enable = true;
    # provides nixGLNvidia command to run any other app on the GPU
    installScripts = [ "nvidia" ];
  };


  # Machine-specific aliases for home-manager
  home.shellAliases = {
    hms = "home-manager switch --flake ~/.config/nix-config#raffaele@legion";
    hmb = "home-manager build --flake ~/.config/nix-config#raffaele@legion";
  };
  
  home.packages = with pkgs; [
    curl
    wget
    man
    man-pages
    nh
  ];
  
}
