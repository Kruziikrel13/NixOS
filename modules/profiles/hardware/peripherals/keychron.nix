{
  lib,
  config,
  pkgs,
  ...
}:
let

  inherit (lib) elem;
  inherit (lib.modules) mkIf;
in
mkIf (elem "peripherals/keychron" config.modules.profiles.hardware) {
  hardware.keyboard.qmk = {
    enable = true;
    keychronSupport = true;
  };
  environment.systemPackages = [ pkgs.via ];
}
