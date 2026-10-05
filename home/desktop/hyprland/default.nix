{ ... }:

{
  xdg.configFile."hypr" = {
    source = ./config;
    recursive = true;
  };

  xdg.configFile."hypr/scripts/toggle-layout.sh" = {
    source = ./config/scripts/toggle-layout.sh;
    executable = true;
  };
}
