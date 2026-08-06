{
  config,
  pkgs,
  pkgs-unstable,
  nixvim,
  zen-browser,
  inputs,
  system,
  ...
}:

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
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  nix.package = pkgs.nix;

  # NVIDIA GPU integration for nix apps via /run/opengl-driver.
  # The version must match the Fedora driver (see scripts/update-nvidia-driver.sh).
  targets.genericLinux.gpu = {
    enable = true;
    nvidia = {
      enable = true;
      version = "610.43.03";
      sha256 = "sha256-ReLUwTSiPDXlDyU6SqY+fl6NF+PRhdSgfIpY6WEu05I=";
    };
  };

  # nix Vulkan apps (zed, ...) don't scan /run/opengl-driver for ICDs;
  # point them at the driver's Vulkan ICD.
  home.sessionVariables.VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json";

  # Machine-specific aliases for home-manager
  home.shellAliases = {
    hms = "home-manager switch --flake ~/.config/nix-config#raffaele@legion";
    hmb = "home-manager build --flake ~/.config/nix-config#raffaele@legion";
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
    ];

}
