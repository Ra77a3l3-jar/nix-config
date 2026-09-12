{ pkgs, ... }:

let
  inherit (pkgs)
    appimageTools
    dpkg
    libpng
    libxkbfile
    stdenvNoCC
    ;

  version = "9.0.1";

  appimage = stdenvNoCC.mkDerivation {
    pname = "cisco-packet-tracer-appimage";
    inherit version;
    src = ./CiscoPacketTracer_901_Ubuntu_64bit.deb;
    nativeBuildInputs = [ dpkg ];
    dontUnpack = true;
    installPhase = ''
      runHook preInstall
      dpkg-deb -x $src unpacked
      cp unpacked/opt/pt/packettracer.AppImage $out
      runHook postInstall
    '';
  };

  packet-tracer = appimageTools.wrapType2 rec {
    pname = "cisco-packet-tracer";
    inherit version;
    src = appimage;
    extraPkgs = _: [
      libpng
      libxkbfile
    ];
    extraBwrapArgs = [
      "--setenv QT_QPA_PLATFORM xcb"
    ];
    extraInstallCommands =
      let
        contents = appimageTools.extract { inherit pname version src; };
      in
      ''
        mv $out/bin/${pname} $out/bin/packettracer9
        install -Dm444 ${contents}/CiscoPacketTracer-${version}.desktop $out/share/applications/cisco-packet-tracer-9.desktop
        install -Dm444 ${contents}/CiscoPacketTracerPtsa-${version}.desktop $out/share/applications/cisco-packet-tracer-ptsa-9.desktop
        substituteInPlace $out/share/applications/* \
          --replace-fail "Exec=@EXEC_PATH@" "Exec=packettracer9" \
          --replace-fail "Icon=app" "Icon=cisco-packet-tracer-9"
        install -Dm444 ${contents}/usr/share/icons/hicolor/48x48/apps/app.png $out/share/icons/hicolor/48x48/apps/cisco-packet-tracer-9.png
        cp -r ${contents}/usr/share/icons/gnome/48x48/mimetypes $out/share/icons/hicolor/48x48/
        for desktop in $out/share/applications/*.desktop; do
          sed -i '/^\[Desktop Entry\]/a StartupWMClass=PacketTracer' "$desktop"
        done
      '';
  };
in
{
  home.packages = [ packet-tracer ];
}
