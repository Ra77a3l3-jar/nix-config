{ config, pkgs-unstable, ... }:

let
  revision = "10eeefa0519e09992b68a1d2949781a876230f5c";
  version = builtins.substring 0 12 revision;

  plugin = pkgs-unstable.hyprlandPlugins.mkHyprlandPlugin {
    hyprland = config.programs.hyprland.package;
    pluginName = "scrolloverview";
    inherit version;
    src = pkgs-unstable.fetchFromGitHub {
      owner = "yayuuu";
      repo = "hyprland-scroll-overview";
      rev = revision;
      hash = "sha256-EdtVRpwYkLtqTrNBA2VbGXpt7DMyMlRm6LCDNfI/1pU=";
    };
    buildInputs = [ pkgs-unstable.lua5_4 ];
    enableParallelBuilding = true;
    dontUseCmakeConfigure = true;

    buildPhase = ''
      runHook preBuild
      SCROLLOVERVIEW_BUILD_VERSION=${version} make all
      runHook postBuild
    '';
    installPhase = ''
      runHook preInstall
      install -Dm755 scrolloverview.so "$out/lib/libscrolloverview.so"
      runHook postInstall
    '';
  };
in
{
  environment.etc."hypr/plugins/scrolloverview.so".source =
    "${plugin}/lib/libscrolloverview.so";
}
