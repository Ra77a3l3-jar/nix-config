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

let
  nvidiaIcd = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json";
  steam = pkgs.writeShellScriptBin "steam" ''
    unset VK_ICD_FILENAMES
    unset VK_DRIVER_FILES
    if [ -x /usr/bin/steam ]; then
      exec /usr/bin/steam "$@"
    fi
    exec "${config.home.homeDirectory}/.local/share/Steam/steam.sh" "$@"
  '';
in
{
  imports = [
    ../../home/core/default.nix
    ../../home/desktop/default.nix
    ../../home/desktop/hyprland/fedora.nix
    ../../home/apps/default.nix
    ../../home/terminal/default.nix
    ../../home/shell/default.nix
    ../../home/editor/default.nix
    ../../home/tools/default.nix
    ../../home/dev/default.nix
    ../../home/games/default.nix
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
      version = "615.71.09";
      sha256 = "sha256-zc7tIrvrYSSNGm3qvCWWZz46ZQFpjucayNL9wo87cP4=";
    };
  };

  # Nix Vulkan apps (zed, sonora, ...) don't scan /run/opengl-driver for ICDs.
  # This override is nix-only: Steam is wrapped below so Proton keeps Fedora's ICD.
  home.sessionVariables.VK_ICD_FILENAMES = nvidiaIcd;

  xdg.desktopEntries.steam = {
    name = "Steam";
    exec = "${steam}/bin/steam %U";
    icon = "steam";
    terminal = false;
    categories = [
      "Network"
      "FileTransfer"
      "Game"
    ];
    mimeType = [
      "x-scheme-handler/steam"
      "x-scheme-handler/steamlink"
    ];
    prefersNonDefaultGPU = true;
  };

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
      steam
      zen-browser.packages.${system}.default
    ];

}
