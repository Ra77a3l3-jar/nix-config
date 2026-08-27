{
  inputs,
  herdrPlugins,
  ...
}:

{
  imports = [
    inputs.herdnix.homeManagerModules.default
  ];

  programs.herdr = {
    enable = true;

    plugins = with herdrPlugins; [
      terminalBrowser
      terminalCode
    ];

    settings = {

      onboarding = false;
      theme.name = "tokyo-night";

      terminal = {
        default_shell = "fish";
        new_cwd = "follow";
      };

      ui = {
        pane_borders = true;
        pane_gaps = false;
      };

      experimental.kitty_graphics = true;

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

        command = [
          {
            key = "prefix+shift+1";
            type = "plugin_action";
            command = "herdr-file-viewer.open-file-viewer-tab";
          }
          {
            key = "prefix+shift+2";
            type = "plugin_action";
            command = "cloudmanic.herdr-plus.projects";
          }
          {
            key = "prefix+shift+3";
            type = "plugin_action";
            command = "cloudmanic.herdr-plus.quick-actions";
          }
          {
            key = "prefix+shift+4";
            type = "plugin_action";
            command = "herdr-spreader.apply";
          }
          {
            key = "prefix+shift+5";
            type = "plugin_action";
            command = "persiyanov.reviewr.toggle";
          }
          {
            key = "prefix+shift+6";
            type = "plugin_action";
            command = "official.browser.open-localhost";
          }
          {
            key = "prefix+shift+7";
            type = "plugin_action";
            command = "mirror.start";
          }
          {
            key = "prefix+shift+8";
            type = "plugin_action";
            command = "herdr-sidebar.open-sidebar";
          }
          {
            key = "prefix+shift+9";
            type = "plugin_action";
            command = "nicosuave.memex.desk";
          }
          {
            key = "prefix+shift+0";
            type = "plugin_action";
            command = "zenbu-labs.terminal-browser.open-split";
          }
          {
            key = "prefix+shift+minus";
            type = "plugin_action";
            command = "zenbu-labs.tode.open-split";
          }
        ];
      };
    };
  };
}
