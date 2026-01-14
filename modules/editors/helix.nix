{
  lib,
  lib',
  config,
  pkgs,
  ...
}:
let
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.editors.helix;
in
{
  options.modules.editors.helix.enable = mkBoolOpt (config.modules.editors.default == "helix");
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        user.packages = [ pkgs.evil-helix ];
      }
      (lib.mkIf (config.modules.editors.default == "helix") {
        environment.variables.EDITOR = lib.mkOverride 900 "hx";
        environment.shellAliases = {
          vim = "hx";
          v = "hx";
        };
      })
    ]
  );
}
