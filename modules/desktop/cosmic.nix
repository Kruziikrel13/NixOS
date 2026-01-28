{
  config,
  lib,
  lib',
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib'.options) mkBoolOpt;
in
{
  options.modules.desktop.cosmic = {
    enable = mkBoolOpt false;
  };

  config = mkIf config.modules.desktop.cosmic.enable {
    services.displayManager.cosmic-greeter.enable = true;
    services.desktopManager.cosmic.enable = true;
  };
}
