{ lib, config, ... }:
with lib;
mkIf (elem "peripherals/logitech" config.modules.profiles.hardware) {
  services.ratbagd.enable = true;
  hardware.logitech = {
    wireless.enable = true;
    wireless.enableGraphical = true;
  };
  user.extraGroups = [ "plugdev" ];
}
