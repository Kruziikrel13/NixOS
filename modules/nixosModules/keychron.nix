self:
{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.hardware.keyboard.qmk;
in
{
  options.hardware.keyboard.qmk.keychronSupport = mkEnableOption "Keychron keyboard support.";
  config = mkIf cfg.keychronSupport {
    services.udev.packages = [ pkgs.keychron-udev-rules ];
  };
}
