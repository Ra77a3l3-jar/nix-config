{ pkgs, config, ... }:

let
  hubyoung-unwrapped = pkgs.stdenvNoCC.mkDerivation {
    pname = "hubyoung-unwrapped";
    version = "7.7.450";
    src = ./HUB-Young.deb;
    nativeBuildInputs = [ pkgs.dpkg ];
    dontUnpack = true;
    dontFixup = true;
    installPhase = ''
      runHook preInstall
      mkdir -p $out
      dpkg-deb --fsys-tarfile $src | tar -x --no-same-owner -C $out
      chmod -R u+w,go-w $out
      runHook postInstall
    '';
  };

  extraLibs =
    pkgs: with pkgs; [
      cacert
      gtk3
      libcanberra-gtk3
      libepoxy
      libglvnd
      libxshmfence
      mesa
      openssl
      unzip
      zip
    ];

  fhs = pkgs.appimageTools.defaultFhsEnvArgs;

  hubyoung = pkgs.buildFHSEnv (
    fhs
    // {
      pname = "hubyoung";
      version = "7.7.450";
      targetPkgs = pkgs: (fhs.targetPkgs pkgs) ++ extraLibs pkgs;
      multiPkgs = pkgs: (fhs.multiPkgs pkgs) ++ extraLibs pkgs;
      extraInstallCommands = ''
        mkdir -p $out/share/applications $out/share/icons/hicolor/256x256/apps
        cp ${hubyoung-unwrapped}/usr/share/applications/hubyoung.desktop $out/share/applications/
        cp ${hubyoung-unwrapped}/usr/share/young.png $out/share/icons/hicolor/256x256/apps/hubyoung.png
        substituteInPlace $out/share/applications/hubyoung.desktop \
          --replace-fail "/usr/local/bin/hubyoung/hub-young-prod -ui" "hubyoung" \
          --replace-fail "Path=/usr/local/bin/hubyoung/" "" \
          --replace-fail "Icon=/usr/share/young.png" "Icon=hubyoung"
      '';
      runScript = pkgs.writeShellScript "hubyoung" ''
        export HOME="''${HOME:-${config.home.homeDirectory}}"
        export SSL_CERT_FILE="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
        export SSL_CERT_DIR="${pkgs.cacert}/etc/ssl/certs"
        export NIX_SSL_CERT_FILE="$SSL_CERT_FILE"
        export NODE_EXTRA_CA_CERTS="$SSL_CERT_FILE"
        mkdir -p "$HOME/.HUB-young.v2" "$HOME/Downloads"
        chmod -R u+w "$HOME/.HUB-young.v2" 2>/dev/null || true
        cd ${hubyoung-unwrapped}/usr/local/bin/hubyoung
        export LD_LIBRARY_PATH="$PWD/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
        exec ./hub-young-prod -ui "$@"
      '';
    }
  );
in
{
  home.packages = [ hubyoung ];
}
