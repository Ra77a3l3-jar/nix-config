{ pkgs-unstable, ... }:

{
  programs.gh-dash = {
    enable = true;
    package = pkgs-unstable.gh-dash;

    settings = {
      theme = {
        ui = {
          sectionsShowCount = true;
          table = {
            showSeparators = true;
            compact = false;
          };
        };

        colors = {
          text = {
            primary = "#c0caf5";
            secondary = "#a9b1d6";
            inverted = "#1a1b26";
            faint = "#565f89";
            warning = "#e0af68";
            success = "#9ece6a";
            actor = "#7aa2f7";
          };

          background = {
            selected = "#283457";
          };

          border = {
            primary = "#7aa2f7";
            secondary = "#27a1b9";
            faint = "#414868";
          };

          inline = {
            icons = {
              newcontributor = "#7dcfff";
              contributor = "#7aa2f7";
              collaborator = "#bb9af7";
              member = "#9ece6a";
              owner = "#ff9e64";
              unknownrole = "#565f89";
            };
          };
        };

        icons = {
          inline = {
            newcontributor = "󰎔";
            contributor = "";
            collaborator = "";
            member = "";
            owner = "";
            unknownrole = "󰭙";
          };
        };
      };
    };
  };
}
