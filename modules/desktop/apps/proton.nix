{
  self,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (self.lib.options) mkBoolOpt;
  inherit (lib) mkMerge mkIf;
  cfg = config.modules.desktop.apps;
in
{
  options.modules.desktop.apps = {
    protonmail.enable = mkBoolOpt false;
    protonpass.enable = mkBoolOpt false;
  };
  config = mkMerge [
    (mkIf cfg.protonmail.enable {
      user.packages = [ pkgs.protonmail-desktop ];
    })

    (mkIf cfg.protonpass.enable {
      user.packages = [ pkgs.proton-pass ];
    })
  ];
}
