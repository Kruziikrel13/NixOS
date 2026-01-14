{
  lib,
  config,
  ...
}:
let

  inherit (lib) elem;
  inherit (lib.modules) mkIf;
in
mkIf (elem "peripherals/logitech" config.modules.profiles.hardware) {
  hardware.logitech = {
    wireless.enable = true;
    wireless.enableGraphical = true;
  };
  services.ratbagd.enable = true;
}
