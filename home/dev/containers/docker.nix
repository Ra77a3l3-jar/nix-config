{ pkgs-unstable, ... }:

{

  home.packages = with pkgs-unstable; [
    docker
    docker-compose
    lazydocker
  ];

}
