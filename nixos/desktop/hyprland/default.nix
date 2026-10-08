{ inputs, pkgs, pkgs-unstable, ... }:

let
  # Use HyprWM's pinned package set for Hyprland, portal, and GUI utilities
  hyprPackages = inputs.hyprnix.packages.${pkgs.stdenv.hostPlatform.system};

  # Build the plugin against Bobasek's installed Hyprland to match its ABI
  scrollOverview = pkgs-unstable.hyprlandPlugins.mkHyprlandPlugin {
    hyprland = hyprPackages.default;
    pluginName = "scrolloverview";
    version = "10eeefa0519e";
    src = pkgs-unstable.fetchFromGitHub {
      owner = "yayuuu";
      repo = "hyprland-scroll-overview";
      rev = "10eeefa0519e09992b68a1d2949781a876230f5c";
      hash = "sha256-EdtVRpwYkLtqTrNBA2VbGXpt7DMyMlRm6LCDNfI/1pU=";
    };
    buildInputs = [ pkgs-unstable.lua5_4 ];
    enableParallelBuilding = true;
    dontUseCmakeConfigure = true;

    buildPhase = ''
      runHook preBuild
      export SCROLLOVERVIEW_BUILD_VERSION="10eeefa0519e"
      make all
      runHook postBuild
    '';
    installPhase = ''
      runHook preInstall
      mkdir -p "$out/lib"
      mv scrolloverview.so "$out/lib/libscrolloverview.so"
      runHook postInstall
    '';

    meta = {
      description = "Scrollable workspace overview plugin for Hyprland";
      homepage = "https://github.com/yayuuu/hyprland-scroll-overview";
      license = pkgs-unstable.lib.licenses.bsd3;
      platforms = pkgs-unstable.lib.platforms.linux;
    };
  };
in
{
  programs.hyprland = {
    enable = true;
    withUWSM = false;
    package = hyprPackages.default;
    portalPackage = hyprPackages.xdg-desktop-portal-hyprland;
  };

  # Give the manually managed Lua config a stable path to the Nix-built plugin
  environment.etc."hypr/plugins/scrolloverview.so".source =
    "${scrollOverview}/lib/libscrolloverview.so";

  environment.systemPackages = [
    hyprPackages.hyprland-guiutils
  ];
}
