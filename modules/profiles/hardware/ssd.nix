{ lib, config, ... }:
let

  inherit (lib) elem;
  inherit (lib.modules) mkIf;
in
mkIf (elem "ssd" config.modules.profiles.hardware) {
  services.fstrim.enable = true;
  boot.initrd.availableKernelModules = [ "nvme" ];
}
