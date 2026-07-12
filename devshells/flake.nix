{ inputs, system }:

let
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  hpkgs = pkgs.haskellPackages;

in
{
  haskell = pkgs.mkShell {
    packages = [

      pkgs.ghc
      pkgs.cabal-install
      pkgs.stack
      pkgs.haskell-language-server
      pkgs.ghcid

      pkgs.ormolu
      pkgs.fourmolu
      pkgs.hlint

      (hpkgs.ghcWithPackages (p: with p; [
        text
        bytestring
        containers
        unordered-containers
        vector
        aeson
        aeson-pretty
        generic-aeson
        optparse-applicative
        mtl
        transformers
        exceptions
        safe-exceptions
        async
        stm
        unliftio
        http-conduit
        servant
        servant-server
        wai
        warp
        megaparsec
        pretty-simple
        lens
        directory
        filepath
        random
      ]))
    ];

    shellHook = ''
      echo "Haskell dev environment"
    '';
  };

  ros = let
    ros-pkgs = import inputs.nix-ros-overlay.inputs.nixpkgs {
      inherit system;
      overlays = [ inputs.nix-ros-overlay.overlays.default ];
      config.allowUnfree = true;
    };
    # nixGL lets rviz2 use the NVIDIA GPU. nvidiaVersion must match the
    # Fedora driver (cat /proc/driver/nvidia/version). After a driver update,
    # change it and get the new nvidiaHash with:
    #   nix store prefetch-file https://download.nvidia.com/XFree86/Linux-x86_64/<version>/NVIDIA-Linux-x86_64-<version>.run
    nvidiaVersion = "580.159.04";
    nixGLNvidia = (pkgs.callPackage (inputs.nixgl + "/nixGL.nix") {
      inherit nvidiaVersion;
      nvidiaHash = "sha256-weZnYbCI0Xs632y2l53przi+JoTRArABoXbc+vq9yh4=";
      enable32bits = false;
    }).nixGLNvidia;
    nixGL = ros-pkgs.writeShellScriptBin "nixGL" ''
      exec ${nixGLNvidia}/bin/nixGLNvidia-${nvidiaVersion} "$@"
    '';
    ros-env = with ros-pkgs.rosPackages.jazzy; buildEnv {
      paths = [
        ros-core
        ros-base
        rviz2
        rqt
        navigation2
        tf2-ros
        tf2-tools
        rmw-fastrtps-cpp
      ];
    };
  in ros-pkgs.mkShell {
    packages = [
      # GPU-wrapped rviz2; listed first so it wins over the plain one below
      (ros-pkgs.writeShellScriptBin "rviz2" ''
        exec ${nixGL}/bin/nixGL ${ros-env}/bin/rviz2 "$@"
      '')
      nixGL
      ros-pkgs.colcon
      ros-env
    ];
    shellHook = ''
      echo "ROS2 Jazzy dev environment (rviz2 is nixGL-wrapped)"
    '';
  };

  go = pkgs.mkShell {
    packages = [
      pkgs.go
      pkgs.gopls
      pkgs.go-tools
    ];
  };

  java = pkgs.mkShell {
    packages = [
      pkgs.jdk21
      pkgs.maven
      pkgs.gradle
      pkgs.jdt-language-server
    ];
  };

  zig = pkgs-unstable.mkShell {
    packages = [
      pkgs-unstable.zig
      pkgs-unstable.zls
      pkgs-unstable.zig-zlint
    ];
  };

  asm = pkgs.mkShell {
    packages = [
      pkgs.gcc
      pkgs.binutils
      pkgs.gdb
      pkgs.nasm
      pkgs.lldb
    ];
  };

  nix = pkgs.mkShell {
    packages = [
      pkgs.nixd
      pkgs.nixpkgs-fmt
      pkgs.statix
      pkgs.nix-init
    ];
  };

  bash = pkgs.mkShell {
    packages = [
      pkgs.shellcheck
      pkgs.shfmt
      pkgs.bash-language-server
    ];
  };
}
