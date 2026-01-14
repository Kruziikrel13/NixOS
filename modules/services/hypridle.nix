{
  lib',
  lib,
  config,
  ...
}:
let

  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.services.hypridle;
in
{
  options.modules.services.hypridle.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = config.modules.desktop.hyprland.enable;
        message = "hypridle requires the hyprland desktop";
      }
    ];
    services.hypridle.enable = true;
  };
}
