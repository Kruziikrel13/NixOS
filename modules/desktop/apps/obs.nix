{
  lib,
  lib',
  config,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.desktop.apps.obs;
in
{
  options.modules.desktop.apps.obs.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    user.packages = [ pkgs.obs-studio ];

    environment.variables = mkIf config.modules.desktop.hyprland.enable {
      __GL_VRR_ALLOWED = 0;
      __GL_GSYNC_ALLOWED = 0;
      __GL_SYNC_TO_VBLANK = 1;
    };
  };
}
