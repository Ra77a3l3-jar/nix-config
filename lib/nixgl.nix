# The version below must match the Fedora driver. If nix GUI apps stop
# starting after a driver update:
#   1. get the new version:  cat /proc/driver/nvidia/version
#   2. put it in `version` below
#   3. get the new hash for nvidiaHash with:
#      nix store prefetch-file https://download.nvidia.com/XFree86/Linux-x86_64/<version>/NVIDIA-Linux-x86_64-<version>.run
{ pkgs, nixgl }:

rec {
  version = "610.43.03";

  packages = pkgs.callPackage (nixgl + "/nixGL.nix") {
    nvidiaVersion = version;
    nvidiaHash = "sha256-ReLUwTSiPDXlDyU6SqY+fl6NF+PRhdSgfIpY6WEu05I=";
    enable32bits = false;
  };

  nixGLNvidia = pkgs.writeShellScriptBin "nixGLNvidia" ''
    exec ${packages.nixGLNvidia}/bin/nixGLNvidia-${version} "$@"
  '';
  nixVulkanNvidia = pkgs.writeShellScriptBin "nixVulkanNvidia" ''
    exec ${packages.nixVulkanNvidia}/bin/nixVulkanNvidia-${version} "$@"
  '';
}
