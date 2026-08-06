{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.programs.helix.steel;

  # use STEEL_HOME if it is defined, else flaback to default
  steelHome =
    config.home.sessionVariables.STEEL_HOME or "${config.home.homeDirectory}/.local/share/steel";

  # home.file targets must be relative to the home directory
  steelHomeRel = lib.removePrefix "${config.home.homeDirectory}/" steelHome;

  # includes plugin dependencies with passthru.dependencies
  flattenPlugins =
    plugins:
    map (item: item.val) (
      lib.genericClosure {
        startSet = map (p: {
          key = p.pluginName;
          val = p;
        }) plugins;
        operator =
          item:
          map (p: {
            key = p.pluginName;
            val = p;
          }) (item.val.dependencies or [ ]);
      }
    );

  allPlugins = flattenPlugins cfg.plugins;
  # pure plugins carry passthru.native = null; native plugins expose a `native` output
  nativePlugins = builtins.filter (drv: (drv.native or null) != null) allPlugins;

  cogLinks = builtins.listToAttrs (
    map (drv: {
      name = "${steelHomeRel}/cogs/${drv.pluginName}";
      value.source = drv;
    }) allPlugins
  );

  nativeLinks = lib.optionalAttrs (nativePlugins != [ ]) {
    "${steelHomeRel}/native".source = pkgs.symlinkJoin {
      name = "helix-steel-merged-native-libs";
      paths = map (drv: drv.native) nativePlugins;
    };
  };
in
{
  options.programs.helix.steel = {
    enable = lib.mkEnableOption "declarative Steel plugins for Helix";

    plugins = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      example = lib.literalExpression "with config.programs.helix.steel.availablePlugins; [ oil forest ]";
      description = "Steel plugins to link into STEEL_HOME/cogs.";
    };

    availablePlugins = lib.mkOption {
      type = lib.types.attrs;
      readOnly = true;
      default = inputs.helix-plugins-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.helixPlugins;
      defaultText = lib.literalExpression "helix-plugins-nix plugin set";
      description = "The helix-plugins-nix plugin set for this system.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.file = cogLinks // nativeLinks;
  };
}
