{ hostName, ... }:

{
  xdg.configFile."hypr" = {
    source = ./configs/${hostName};
    recursive = true;
  };

  xdg.configFile."hypr/scripts/toggle-layout.sh" = {
    source = ./scripts/toggle-layout.sh;
    executable = true;
  };
}
