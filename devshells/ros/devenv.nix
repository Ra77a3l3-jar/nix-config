{ inputs, pkgs, ... }:

let
  ros-pkgs = import inputs.nix-ros-overlay.inputs.nixpkgs {
    system = pkgs.stdenv.system;
    overlays = [ inputs.nix-ros-overlay.overlays.default ];
    config.allowUnfree = true;
  };
  ros-env =
    with ros-pkgs.rosPackages.jazzy;
    buildEnv {
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
in
{
  packages = [
    ros-pkgs.colcon
    ros-env
  ];

  enterShell = ''
    echo "ROS2 Jazzy dev environment"
  '';
}
