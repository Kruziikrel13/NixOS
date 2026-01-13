{
  lib,
  lib',
  config,
  pkgs,
  ...
}:
let
  inherit (lib'.options) mkBoolOpt;
in
{
  options.modules.desktop.apps.vesktop.enable = mkBoolOpt false;
  config = lib.mkIf config.modules.desktop.apps.vesktop.enable {
    user.packages = [
      (pkgs.vesktop.override {
        withSystemVencord = true;
      })
    ];
  };
}
