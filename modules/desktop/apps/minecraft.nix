{
  self,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (self.lib.options) mkBoolOpt;
  cfg = config.modules.desktop.apps.minecraft;
in
{
  options.modules.desktop.apps.minecraft.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    user.packages = [ pkgs.prismlauncher ];
  };
}
