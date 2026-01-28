{ lib, config, pkgs, ... }:

let
  cfg = config.desktop.gnome;
in
{
  options.desktop.gnome = {
    uiFont = lib.mkOption {
      type = lib.types.str;
      default = "Ubuntu Mono Nerd Font";
    };

    documentFont = lib.mkOption {
      type = lib.types.str;
      default = "Ubuntu Mono Nerd Font";
    };

    monoFont = lib.mkOption {
      type = lib.types.str;
      default = "Ubuntu Mono Nerd Font";
    };

    fontSize = lib.mkOption {
      type = lib.types.int;
      default = 13;
    };

    textScaling = lib.mkOption {
      type = lib.types.float;
      default = 1.0;
    };
    
  };

  config = {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        font-name =
          "${cfg.uiFont} ${toString cfg.fontSize}";

        document-font-name =
          "${cfg.documentFont} ${toString cfg.fontSize}";

        monospace-font-name =
          "${cfg.monoFont} ${toString cfg.fontSize}";

        text-scaling-factor = cfg.textScaling;

        color-scheme = "prefer-dark";
        enable-hot-corners = false;
        clock-show-weekday = true;
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
      };

      "org/gnome/desktop/applications/terminal" = {
        exec = "kitty";
      };
    };

    home.packages = with pkgs; [
      gnome-extension-manager
      gnome-tweaks
      dconf-editor
    ];
  };
}
