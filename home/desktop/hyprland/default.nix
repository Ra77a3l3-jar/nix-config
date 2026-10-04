{ ... }:

{
  xdg.configFile."hypr" = {
    source = ./configs;
    recursive = true;
  };

  xdg.configFile."hypr/scripts/toggle-layout.sh" = {
    source = ./configs/scripts/toggle-layout.sh;
    executable = true;
  };
}
