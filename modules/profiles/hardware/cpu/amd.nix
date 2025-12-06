{ lib, config, ... }:
with lib;
mkMerge [
  (mkIf (any (s: hasPrefix "cpu/amd" s) config.modules.profiles.hardware) {
    hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
    boot.kernelParams = [ "amd_pstate=active" ];
  })
]
