{
  config,
  lib',
  lib,
  pkgs,
  ...
}:
let

  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe;
  inherit (lib.options) mkEnableOption;
  cfg = config.modules.services.hyprpolkitagent;
in
{
  options.modules.services.hyprpolkitagent.enable = mkEnableOption "hyprpolkitagent service";
  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.modules.desktop.hyprland.enable;
        message = "hyprpolkitagent requires the hyprland desktop";
      }
      {
        assertion = config.security.polkit.enable;
        message = "hyprpolkitagent requires polkit to be enabled";
      }
    ];
    user.packages = [ pkgs.hyprpolkitagent ];
  };
}
