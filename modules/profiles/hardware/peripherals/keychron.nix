{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
mkIf (elem "peripherals/keychron" config.modules.profiles.hardware) {
  hardware.keyboard.qmk = {
    enable = true;
    keychronSupport = true;
  };

  environment.systemPackages = [ pkgs.via ];
}
