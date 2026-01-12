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
    services.hypridle.enable = true;
  };
}
