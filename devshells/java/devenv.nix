{ pkgs, ... }:

{
  languages.java = {
    enable = true;
    jdk.package = pkgs.jdk21;
    maven.enable = true;
    gradle.enable = true;
  };
}
