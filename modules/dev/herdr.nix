{ herdr, pkgs, ... }:

{
  imports = [ herdr.homeManagerModules.default ];

  programs.herdr = {
    enable = true;
    package = herdr.packages.${pkgs.system}.default;

    settings = {

      onboarding = false;
      theme.name = "catppuccin";

      terminal = {
        default_shell = "fish";
        new_cwd = "follow";
      };

      ui = {
        pane_borders = true;
        pane_gaps = false;
      };

      keys = {
        prefix = "ctrl+v";

        next_tab = "prefix+right";
        previous_tab = "prefix+left";

        focus_pane_left = "prefix+h";
        focus_pane_down = "prefix+j";
        focus_pane_up = "prefix+k";
        focus_pane_right = "prefix+l";

        next_workspace = "prefix+a";
        previous_workspace = "prefix+d";

        next_agent = "prefix+up";
        previous_agent = "prefix+down";
      };
    };
  };
}
