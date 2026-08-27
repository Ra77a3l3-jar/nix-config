{ pkgs-unstable, ... }:

{

  programs.zellij = {
    enable = true;
    package = pkgs-unstable.zellij;

    settings = {
      simplified_ui = true;

      default_layout = "compact";

      copy_on_select = true;

      show_startup_tips = false;

      ui = {
        pane_frames = {
          rounded_corners = false;
          hide_session_name = true;
        };
      };

      # Config for minimal borders
      pane_frames = false;
    };
  };
}
