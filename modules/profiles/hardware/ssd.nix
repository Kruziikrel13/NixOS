{ lib, config, ... }:
with lib;
mkIf (elem "ssd" config.modules.profiles.hardware) {
  services.fstrim.enable = true;
  boot.initrd.availableKernelModules = [ "nvme" ];
}
